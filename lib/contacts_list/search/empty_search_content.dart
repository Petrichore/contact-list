import 'package:flutter/material.dart';

class EmptySearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return emptySuggestions();
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