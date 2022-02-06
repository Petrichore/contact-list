import 'package:contacts_list/contacts_list/search_delegate.dart';
import 'package:contacts_list/model/Contact.dart';
import 'package:flutter/material.dart';

class ContactsListContent extends StatefulWidget {
  @override
  createState() => ContactsListContentState();
}

class ContactsListContentState extends State {
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
        (contact) => {
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

class ContactList extends StatelessWidget {
  final List<Contact> contactsList;
  final Function(Contact) onItemDismissed;

  ContactList(this.contactsList, this.onItemDismissed);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: contactsList.length,
      itemBuilder: (context, i) {
        return Dismissible(
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            if (direction == DismissDirection.endToStart) {
              onItemDismissed(contactsList[i]);
            }
          },
          key: ObjectKey(contactsList[i]),
          child: i < contactsList.length - 1
              ? Padding(
                  padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                  child: ContactItem(contactsList[i]),
                )
              : Padding(
                  padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                  child: ContactItem(contactsList[i]),
                ),
        );
      },
    );
  }
}

class ContactItem extends StatelessWidget {
  final Contact item;

  const ContactItem(this.item);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2),
        ),
        shadowColor: Colors.grey,
        elevation: 4,
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 0, 16),
              child: contactImage(),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 16, 0, 0),
                  child: contactNameInfo(),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 8, 0, 16),
                  child: contactActivityInfo(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget contactNameInfo() {
    return Text(
      item.fullName,
      style: TextStyle(color: Colors.black, fontSize: 24),
    );
  }

  Widget contactImage() {
    return CircleAvatar(
      radius: 30,
      foregroundImage: NetworkImage(item.imageUrl),
    );
  }

  Widget contactActivityInfo() {
    return item.isOnline
        ? Text(
            'Online',
            style: TextStyle(color: Colors.green, fontSize: 16),
          )
        : Text(
            item.lastSeen,
            style: TextStyle(color: Colors.grey, fontSize: 16),
          );
  }
}
