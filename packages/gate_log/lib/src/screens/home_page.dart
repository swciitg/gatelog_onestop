import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gate_log/src/models/entry_details.dart';
import 'package:gate_log/src/screens/check_out_page.dart';
import 'package:gate_log/src/services/api.dart';
import 'package:gate_log/src/services/shared_prefs.dart';
import 'package:gate_log/src/widgets/home/entry_details_tile.dart';
import 'package:gate_log/src/widgets/shimmers/list_shimmer.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:onestop_kit/onestop_kit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final int pageSize = 10;
  final PagingController<int, EntryDetails> _entryController =
      PagingController(firstPageKey: 1, invisibleItemsThreshold: 1);
  bool isGuest = true;

  Future<void> _fetchEntries(int pageKey) async {
    try {
      final result = await APIService().getLogHistory(pageKey, pageSize);
      bool isLastPage = result.length < pageSize;

      if (isLastPage) {
        _entryController.appendLastPage(result);
      } else {
        _entryController.appendPage(result, pageKey + 1);
      }
    } on DioException catch (e) {
      log("Error: ${e.response?.data}");
    } catch (e) {
      log("Error: $e");
      _entryController.error = e;
    }
  }

  void setIsGuest() async {
    final isG = await SharedPrefs.isGuestUser();
    setState(() {
      isGuest = isG;
    });
  }

  @override
  void initState() {
    super.initState();
    setIsGuest();
    _entryController.addPageRequestListener(_fetchEntries);
  }

  @override
  void dispose() {
    _entryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: OneStopColors.backgroundColor,
        centerTitle: true,
        leadingWidth: 100,
        scrolledUnderElevation: 0,
        leading: OneStopBackButton(
          onTap: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
        ),
        title: AppBarTitle(title: 'GateLog'),
      ),
      backgroundColor: OneStopColors.backgroundColor,
      body: isGuest
          ? const GuestRestrictAccess()
          : PagedListView<int, EntryDetails>(
              pagingController: _entryController,
              builderDelegate: PagedChildBuilderDelegate(
                itemBuilder: (context, entry, index) => EntryDetailsTile(
                  entry: entry,
                  isFirst: index == 0,
                  onCheckIn: () => _entryController.refresh(),
                ),
                firstPageErrorIndicatorBuilder: (context) {
                  return ErrorReloadScreen(
                      reloadCallback: _entryController.refresh);
                },
                noItemsFoundIndicatorBuilder: (context) =>
                    const PaginationText(text: "No Entries found"),
                newPageErrorIndicatorBuilder: (context) => Column(children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: ErrorReloadButton(
                      reloadCallback: _entryController.retryLastFailedRequest,
                    ),
                  )
                ]),
                newPageProgressIndicatorBuilder: (context) => const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(child: CircularProgressIndicator()),
                ),
                firstPageProgressIndicatorBuilder: (context) => ListShimmer(
                  count: 10,
                  height: 100,
                ),
                noMoreItemsIndicatorBuilder: (context) =>
                    const PaginationText(text: "You've reached the end"),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: OneStopColors.primaryColor,
        onPressed: () async {
          await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CheckOutPage(),
          ));
          _entryController.refresh();
        },
        child: const Icon(
          Icons.add,
          color: OneStopColors.kBlack,
        ),
      ),
    );
  }
}

class PaginationText extends StatelessWidget {
  final String text;

  const PaginationText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: OnestopFonts.w400.setColor(OneStopColors.kWhite),
        ),
      ),
    );
  }
}
