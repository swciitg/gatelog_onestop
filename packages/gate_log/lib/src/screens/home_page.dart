import 'package:flutter/material.dart';
import 'package:gate_log/src/globals/my_fonts.dart';
import 'package:gate_log/src/models/entry_details.dart';
import 'package:gate_log/src/screens/check_out_page.dart';
import 'package:gate_log/src/services/api.dart';
import 'package:gate_log/src/stores/login_store.dart';
import 'package:gate_log/src/widgets/guest_restrict.dart';
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

  Future<void> _fetchEntries(int pageKey) async {
    try {
      final result = await APIService().getLogHistory(pageKey, pageSize);
      bool isLastPage = result.length < pageSize;

      if (isLastPage) {
        _entryController.appendLastPage(result);
      } else {
        _entryController.appendPage(result, pageKey + 1);
      }
    } catch (e) {
      _entryController.error = e;
    }
  }

  @override
  void initState() {
    super.initState();
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
          title: AppBarTitle(
            title: 'GateLog',
          )),
      backgroundColor: OneStopColors.backgroundColor,
      body: LoginStore().isGuestUser
          ? const GuestRestrictAccess()
          : PagedListView<int, EntryDetails>(
              pagingController: _entryController,
              builderDelegate: PagedChildBuilderDelegate(
                itemBuilder: (context, entry, index) => EntryDetailsTile(
                  entry: entry,
                  isFirst: index == 0,
                ),
                firstPageErrorIndicatorBuilder: (context) {
                  print(_entryController.error);
                  return Column(children: [
                    ErrorReloadScreen(reloadCallback: _entryController.refresh),
                  ]);
                },
                noItemsFoundIndicatorBuilder: (context) =>
                    const PaginationText(text: "No Entries found"),
                newPageErrorIndicatorBuilder: (context) => Column(children: [
                  ErrorReloadButton(
                    reloadCallback: _entryController.retryLastFailedRequest,
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
          setState(() {});
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
          style: MyFonts.w400.setColor(OneStopColors.kWhite),
        ),
      ),
    );
  }
}
