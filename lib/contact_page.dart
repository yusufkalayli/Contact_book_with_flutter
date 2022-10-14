import 'package:flutter/material.dart';

import 'AddContactPage.dart';
import 'model/contact.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  late List<Contact> contacts;
  @override
  void initState() {
    contacts = Contact.contacts;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Contact.contacts
        .sort((Contact a, Contact b) => a.name[0].compareTo(b.name[0]));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text("Phone book"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddContactPage()));
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
          itemCount: contacts.length,
          itemBuilder: (BuildContext context, int index) {
            Contact contact = contacts[index];

            return Dismissible(
              background: Container(
                color: Colors.red,
                child: const Icon(Icons.delete),
              ),
              key: UniqueKey(),
              direction: DismissDirection.startToEnd,
              onDismissed: (direction) {
                setState(() {
                  contacts.removeAt(index);
                });
                var snackBar =
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  duration: const Duration(milliseconds: 2000),
                  content: Text("${contact.name} basariyla silindi"),
                  action: SnackBarAction(
                    label: "Geri Al",
                    onPressed: () {
                      setState(() {
                        contacts.add(contact);
                      });
                    },
                  ),
                ));
              },
              child: Container(
                color: Color.fromARGB(210, 212, 205, 203),
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    const CircleAvatar(
                      backgroundImage: NetworkImage(
                        "https://www.mazzetti.com/wp-content/uploads/2019/01/ANeathery-200x200.jpg",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(contact.name),
                          Text(contact.phoneNumber),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
