import 'package:contacts_list/contacts_list/search/search_delegate.dart';
import 'package:contacts_list/model/Contact.dart';
import 'package:flutter/material.dart';

import 'contact_list_content.dart';

class ContactsListScreen extends StatefulWidget {
  @override
  createState() => ContactsListScreenState();
}

class ContactsListScreenState extends State {
  final contactsList = [
    Contact('Mark Go', 'https://googleflutter.com/sample_image.jpg', false,
        lastSeen: 'just now'),
    Contact('Chris Black', 'https://googleflutter.com/sample_image.jpg', true),
    Contact(
        'Andrey Verhovzev', 'https://googleflutter.com/sample_image.jpg', false,
        lastSeen: 'yesterday at 12:33'),
    Contact(
        'Bob Spanchecsky', 'https://googleflutter.com/sample_image.jpg', true),
    Contact('Mike Hunter', 'https://googleflutter.com/sample_image.jpg', false,
        lastSeen: 'today at 10:45'),
    Contact(
        'Peter Jackson', 'https://googleflutter.com/sample_image.jpg', true),
    Contact(
        'Vlad Novitsky', 'https://googleflutter.com/sample_image.jpg', true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts List'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearch(contactsList),
              );
            },
          )
        ],
      ),
      body: ContactList(
        contactsList,
        onItemDismissed: (contact) => {
          showSnackBar(context, contact.fullName),
          deleteItem(contact)
        },
      ),
    );
  }

  void showSnackBar(BuildContext context, String contactName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("$contactName deleted from contacts"),
      ),
    );
  }

  void deleteItem(Contact contact) {
    setState(() {
      contactsList.remove(contact);
    });
  }
}
