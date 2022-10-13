import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phone_book_flutter/model/contact.dart';

class AddContactPage extends StatelessWidget {
  const AddContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    Contact.contacts.add(Contact(name: "Test", phoneNumber: "0555 555 55 55"));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text("Add New Contact"),
      ),
      body: const SingleChildScrollView(child: AddContactForm()),
    );
  }
}

class AddContactForm extends StatefulWidget {
  const AddContactForm({super.key});

  @override
  _AddContactFormState createState() => _AddContactFormState();
}

class _AddContactFormState extends State<AddContactForm> {
  final _formKey = GlobalKey<FormState>();
  File? _file;
  @override
  Widget build(BuildContext context) {
    late String name;
    late String phoneNumber;

    return Column(
      children: <Widget>[
        Stack(children: [
          Image.asset(
            _file == null ? "assets/images/personIcon.png" : _file!.path,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          Positioned(
              bottom: 8,
              right: 8,
              child: IconButton(
                  onPressed: () {
                    getFile();
                  },
                  icon: const Icon(Icons.camera_alt))),
        ]),
        Container(
          color: const Color.fromARGB(210, 212, 205, 203),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: "Contact Name",
                        icon: Icon(Icons.person),
                      ),
                      validator: ((value) {
                        if (value!.isEmpty) {
                          return "Isim Giriniz";
                        }
                      }),
                      onSaved: ((newValue) {
                        name = newValue!;
                      }),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: "Phone Number",
                        icon: Icon(Icons.phone),
                      ),
                      //inputFormatters: <TextInputFormatter>[
                      //  FilteringTextInputFormatter.digitsOnly
                      //],
                      keyboardType: TextInputType.number,
                      validator: ((value) {
                        if (value!.isEmpty) {
                          return "Lutfen Gecerli Bir Numara Giriniz";
                        }
                      }),
                      onSaved: (newValue) {
                        phoneNumber = newValue!;
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        Contact.contacts
                            .add(Contact(name: name, phoneNumber: phoneNumber));

                        var snackBar = ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(
                                duration: const Duration(milliseconds: 500),
                                content: Text("$name basariyla kaydedildi")));
                        snackBar.closed.then((onValue) {
                          Navigator.pop(context);
                        });
                      }
                    },
                    child: const Text("Submit"),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> getFile() async {
    var image = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      _file = image as File;
    });
  }
}
