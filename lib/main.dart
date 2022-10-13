import 'package:flutter/material.dart';
import 'package:phone_book_flutter/AddContactPage.dart';
import 'package:phone_book_flutter/contact_page.dart';

import 'model/contact.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: ContactPage());
  }
}
