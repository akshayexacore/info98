import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:info_91_proj/core/tiny/app_round_image.dart';

class ContactList extends StatefulWidget {
  final List<Contact> contacts;
   ContactList({super.key, required this.contacts});

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  Set<Contact> _selectedContacts = Set<Contact>();

    void _toggleContactSelection(Contact contact) {
    setState(() {
      if (_selectedContacts.contains(contact)) {
        _selectedContacts.remove(contact);
      } else {
        _selectedContacts.add(contact);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(body:widget.contacts.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: widget.contacts.length,
                itemBuilder: (context, index) {
                  final contact = widget.contacts[index];
                  return ListTile(
                    leading: CircleAvatar(backgroundImage:  MemoryImage(contact.avatar!),),
                    title: Text(contact.displayName ?? ''),
                    // subtitle: Text(contact.phones!.isNotEmpty
                    //     ? contact.phones!.first.value ?? ''
                    //     : 'No phone number'),
                    trailing: Checkbox(
                      value: _selectedContacts.contains(contact),
                      onChanged: (value) {
                        _toggleContactSelection(contact);
                      },
                    ),
                    onTap: () {
                      _toggleContactSelection(contact);
                    },
                  );
                },
              ),
      ),
    );
  }
}