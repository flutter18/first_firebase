import 'dart:ffi';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_firebase/home.dart';
import 'package:flutter/material.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({Key? key}) : super(key: key);

  @override
  _AddUserPageState createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1950, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  final controllerName = TextEditingController();
  final controllerAge = TextEditingController();
  final controllerDate = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          TextField(
            controller: controllerName,
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            keyboardType: TextInputType.number,
            controller: controllerAge,
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            child: Container(
              width: 300,
              height: 60,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  ("${selectedDate.toLocal()}".split(' ')[0]),
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            onTap: () => _selectDate(context),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                // ! Create
                // final user = User(
                //     name: controllerName.text,
                //     age: int.parse(controllerAge.text),
                //     birthday: selectedDate);

                // createUser(user);

                // Navigator.pop(context);

                // ! Update specific field
                // final docUser =
                //     FirebaseFirestore.instance.collection('users').doc('my-id');
                // docUser.update({'name': 'thisalvindula'});
                // //? if there is a nested value can use, "name.firstname"

                // ! delete specific field
                // final docUser =
                //     FirebaseFirestore.instance.collection('users').doc('my-id');
                // docUser.update({'name': FieldValue.delete()});

                // ! Replace whole document with a value
                final docUser =
                    FirebaseFirestore.instance.collection('users').doc('my-id');
                docUser.set({'name': 'thisalvindula'});
              },
              child: Text('create')),
          SizedBox(
            height: 20,
          ),

          //! delete a document
          ElevatedButton(
              onPressed: () {
                final docUser =
                    FirebaseFirestore.instance.collection('users').doc('my-id');
                docUser.delete();
              },
              child: Text('Delete'))
        ],
      ),
    );
  }

  Future createUser(User user) async {
    final docUser = FirebaseFirestore.instance.collection('users').doc();
    user.id = docUser.id;

    final json = user.toJson();

    await docUser.set(json);
  }
}
