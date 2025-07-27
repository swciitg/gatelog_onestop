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
  static const int pageSize = 10;

  late PagingController<int, EntryDetails> _pagingController;
  bool isGuest = true;
  bool hasUnclosedEntry = false;

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
    _pagingController = PagingController(
      getNextPageKey: (state) {
        return state.lastPageIsEmpty ? null : state.nextIntPageKey;
      },
      fetchPage: (pageKey) async {
        final results = await APIService().getLogHistory(pageKey, pageSize);
        if (pageKey == 1 && !results[0].isClosed) {
          hasUnclosedEntry = true;
          setState(() {});
        }
        return results;
      },
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
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
          : Column(
              children: [
                _entryCloseInfo(),
                Expanded(
                  child: PagingListener(
                    controller: _pagingController,
                    builder: (context, state, fetchNextPage) => PagedListView<int, EntryDetails>(
                      state: state,
                      fetchNextPage: fetchNextPage,
                      builderDelegate: PagedChildBuilderDelegate(
                        itemBuilder: (context, entry, index) => EntryDetailsTile(
                          entry: entry,
                          isFirst: index == 0,
                          onCheckIn: () => _pagingController.refresh(),
                        ),
                        firstPageErrorIndicatorBuilder: (context) {
                          return ErrorReloadScreen(reloadCallback: _pagingController.refresh);
                        },
                        noItemsFoundIndicatorBuilder: (context) =>
                            const PaginationText(text: "No Entries found"),
                        newPageErrorIndicatorBuilder: (context) => Column(children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: ErrorReloadButton(
                              reloadCallback: () => _pagingController.refresh(),
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
                  ),
                ),
              ],
            ),
      floatingActionButton: hasUnclosedEntry
          ? null
          : FloatingActionButton(
              backgroundColor: OneStopColors.primaryColor,
              onPressed: () async {
                await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CheckOutPage(),
                ));
                _pagingController.refresh();
              },
              child: const Icon(
                Icons.add,
                color: OneStopColors.kBlack,
              ),
            ),
    );
  }

  Widget _entryCloseInfo() {
    if (!hasUnclosedEntry) return const SizedBox();
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(10).copyWith(bottom: 0),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: OneStopColors.cardColor1,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_rounded,
            color: OneStopColors.cardFontColor2,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Close your previous entry to check out',
              style: OnestopFonts.w600.setColor(OneStopColors.cardFontColor2).size(13),
            ),
          ),
        ],
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
