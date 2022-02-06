import 'package:contacts_list/util/StringUtil.dart';
import 'package:flutter/material.dart';
import 'package:contacts_list/model/Contact.dart';

class CustomSearch extends SearchDelegate {
  final List<Contact> searchItems;

  CustomSearch(this.searchItems);

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: Colors.white,
        selectionHandleColor: Colors.white,
        selectionColor: Colors.white.withAlpha(70),
      ),
      hintColor: Colors.white,
      textTheme: TextTheme(
        headline6: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
        ),
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () => {query = ""},
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => {close(context, null)},
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Contact> relevantItems = searchItems
        .where((item) => StringUtil.containsIgnoreCase(item.fullName, query))
        .toList();

    return relevantItems.isNotEmpty && query.isNotEmpty
        ? suggestionsList(relevantItems)
        : emptySuggestions();
  }

  Widget suggestionsList(List<Contact> relevantItems) {
    return ListView.builder(
      itemCount: relevantItems.length,
      itemBuilder: (context, i) {
        return buildSuggestion(
            relevantItems[i], i == 0, i == relevantItems.length - 1);
      },
    );
  }

  Widget buildSuggestion(Contact item, bool isFirst, bool isLast) {
    Function(Contact) onItemClick =
        (contact) => {debugPrint('selectedItem:::$contact')};
    if (!isFirst && !isLast) {
      return suggestionItem(
          item, EdgeInsets.fromLTRB(12, 8, 12, 0), onItemClick);
    } else if (isFirst) {
      return suggestionItem(
          item, EdgeInsets.fromLTRB(12, 24, 12, 0), onItemClick);
    } else {
      return suggestionItem(
          item, EdgeInsets.fromLTRB(12, 8, 12, 0), onItemClick,
          showDivider: false);
    }
  }

  Widget suggestionItem(Contact item, EdgeInsets paddings, onItemClick,
      {bool showDivider = true}) {
    return Padding(
      padding: paddings,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          suggestionsItemContent(item),
          showDivider
              ? Padding(
                  padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                  child: Divider(
                    color: Colors.blueGrey,
                  ),
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget suggestionsItemContent(Contact item) {
    return Text(
      item.fullName,
      style: TextStyle(
        fontSize: 18,
        color: Colors.black,
      ),
    );
  }

  Widget emptySuggestions() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Icon(
          Icons.search_off,
          color: Colors.black,
          size: 28,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
          child: Text(
            'No search results',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
