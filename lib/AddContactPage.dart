import 'package:flutter/material.dart';
import 'package:phone_book_flutter/model/contact.dart';

class AddContactPage extends StatelessWidget {
  const AddContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    Contact.contacts.add(Contact(name: "Test", phoneNumber: "0555 555 55 55"));
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Contact"),
      ),
    );
  }
}
