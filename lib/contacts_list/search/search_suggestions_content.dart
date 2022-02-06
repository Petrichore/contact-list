import 'package:flutter/material.dart';
import 'package:contacts_list/model/Contact.dart';

class SearchSuggestionList extends StatelessWidget {
  final List<Contact> relevantItems;

  SearchSuggestionList(this.relevantItems);

  @override
  Widget build(BuildContext context) {
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
}