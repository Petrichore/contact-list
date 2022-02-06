import 'package:contacts_list/contacts_list/contact_list_content.dart';
import 'package:contacts_list/contacts_list/search/empty_search_content.dart';
import 'package:contacts_list/contacts_list/search/search_suggestions_content.dart';
import 'package:contacts_list/util/StringUtil.dart';
import 'package:flutter/material.dart';
import 'package:contacts_list/model/Contact.dart';

class CustomSearch extends SearchDelegate {
  final List<Contact> searchItems;
  List<Contact> _searchResult = [];
  List<Contact> _relevantSuggestions= [];

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
    if(_relevantSuggestions.isNotEmpty){
      _searchResult.clear();
      _searchResult.addAll(_relevantSuggestions);
    }
    return ContactList(_searchResult);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _relevantSuggestions.clear();
    _relevantSuggestions.addAll(searchItems
        .where((item) => StringUtil.containsIgnoreCase(item.fullName, query))
        .toList());

    return _relevantSuggestions.isNotEmpty && query.isNotEmpty
        ? SearchSuggestionList(_relevantSuggestions)
        : EmptySearch();
  }
}
