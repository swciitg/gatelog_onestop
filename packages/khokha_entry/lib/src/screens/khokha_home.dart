import 'dart:convert';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:flutter/material.dart';
import 'package:khokha_entry/src/globals/endpoints.dart';
import 'package:khokha_entry/src/globals/my_fonts.dart';
import 'package:khokha_entry/src/models/entry_details.dart';
import 'package:khokha_entry/src/models/entry_qr_model.dart';
import 'package:khokha_entry/src/screens/khokha_entry_form.dart';
import 'package:khokha_entry/src/stores/login_store.dart';
import 'package:khokha_entry/src/widgets/guest_restrict.dart';
import 'package:khokha_entry/src/widgets/khokha_entry_tile.dart';
import 'package:khokha_entry/src/widgets/list_shimmer.dart';
import 'package:onestop_kit/onestop_kit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:khokha_entry/src/services/api.dart';

class KhokhaHome extends StatefulWidget {
  const KhokhaHome({super.key});
  @override
  State<KhokhaHome> createState() => _KhokhaHomeState();
}

class _KhokhaHomeState extends State<KhokhaHome> {
  final int pageSize = 10;
  final PagingController<int, EntryDetails> _entryController =
      PagingController(firstPageKey: 1, invisibleItemsThreshold: 1);

  @override
  void initState() {
    super.initState();
    _entryController.addPageRequestListener((pageKey) async {
      await _fetchEntries(
          _entryController,
          APIService(
            onestopBaseUrl: Endpoints.khokhaWebSocketUrl,
            onestopSecurityKey: Endpoints.onestopSecurityKey,
          ).getLogHistory,
          pageKey);
    });
  }

  @override
  void dispose() {
    _entryController.dispose();
    super.dispose();
  }

  Future<void> _fetchEntries(
      PagingController controller, Function apiCall, int pageKey) async {
    try {
      var result = await apiCall(pageKey, pageSize);
      bool isLastPage = false;
      if (result.length < pageSize) {
        isLastPage = true;
      }
      if (mounted) {
        if (isLastPage) {
          controller.appendLastPage(result);
        } else {
          controller.appendPage(result, pageKey + 1);
        }
      }
    } catch (e) {
      controller.error = e;
    }
  }

  void callSetState() {
    setState(() {});
  }

  void reload_to_initial_state() {
    _entryController.refresh();
  }

  void reload_for_newpage_error() {
    _entryController.retryLastFailedRequest();
  }

  Future<List<EntryQrModel>> getEntries() async {
    final prefs = await SharedPreferences.getInstance();
    final data = await prefs.getString("entry_data");
    print(data);
    return data != null ? [EntryQrModel.fromJson(jsonDecode(data))] : [];
  }

// EntryQrModel test =
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: OneStopColors.secondaryColor,
        title: Text(
          "All Entries",
          style: MyFonts.w500.setColor(OneStopColors.kWhite),
        ),
      ),
      backgroundColor: OneStopColors.backgroundColor,
      body: LoginStore().isGuestUser
          ? const GuestRestrictAccess()
          : PagedListView<int, EntryDetails>(
              pagingController: _entryController,
              builderDelegate: PagedChildBuilderDelegate(
                itemBuilder: (context, entry, index) =>
                    KhokhaEntryTile(entry: entry),
                firstPageErrorIndicatorBuilder: (context) {
                  print(_entryController.error);
                  return Column(children: [
                    ErrorReloadScreen(reloadCallback: reload_to_initial_state)
                  ]);
                },
                noItemsFoundIndicatorBuilder: (context) =>
                    const PaginationText(text: "No Entries found"),
                newPageErrorIndicatorBuilder: (context) {
                  print(_entryController.error);
                  return Column(children: [
                    ErrorReloadButton(reloadCallback: reload_for_newpage_error)
                  ]);
                },
                newPageProgressIndicatorBuilder: (context) => const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(child: CircularProgressIndicator()),
                ),
                firstPageProgressIndicatorBuilder: (context) => ListShimmer(
                  count: 5,
                  height: 120,
                ),
                noMoreItemsIndicatorBuilder: (context) =>
                    const PaginationText(text: "You've reached the end"),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: OneStopColors.primaryColor,
        onPressed: () async {
          await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => KhokhaEntryForm(),
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
