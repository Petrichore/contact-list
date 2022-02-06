import 'package:contacts_list/model/Contact.dart';
import 'package:flutter/material.dart';

class ContactList extends StatelessWidget {
  final List<Contact> contactsList;
  final Function(Contact)? onItemDismissed;

  ContactList(this.contactsList, {this.onItemDismissed});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: contactsList.length,
      itemBuilder: (context, i) {
        if (onItemDismissed != null) {
          return Dismissible(
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              if (direction == DismissDirection.endToStart) {
                onItemDismissed!(contactsList[i]);
              }
            },
            key: ObjectKey(contactsList[i]),
            child: buildContactItem(contactsList[i], i),
          );
        } else {
          return buildContactItem(contactsList[i], i);
        }
      },
    );
  }

  Widget buildContactItem(Contact item, int itemIndex) {
    return Padding(
      padding: itemIndex < contactsList.length - 1
          ? EdgeInsets.fromLTRB(0, 12, 0, 0)
          : EdgeInsets.fromLTRB(0, 12, 0, 12),
      child: ContactItem(item),
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