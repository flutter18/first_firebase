import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_firebase/add_user_page.dart';
import 'package:first_firebase/retrieve_data.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: controller,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              final name = controller.text;

              createUser(name: name);
            },
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddUserPage()),
              );
            },
            child: Center(
              child: Container(
                height: 50,
                width: 200,
                color: Colors.deepPurple.shade100,
                child: Center(child: Text('Go to add user')),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RetrieveData()),
              );
            },
            child: Center(
              child: Container(
                height: 50,
                width: 200,
                color: Colors.deepPurple.shade100,
                child: Center(child: Text('All users')),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {},
            child: Center(
              child: Container(
                height: 50,
                width: 200,
                color: Colors.deepPurple.shade100,
                child: Center(child: Text('Share')),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future createUser({required String name}) async {
    // * method 1
    //final docUser = FirebaseFirestore.instance.collection('users').doc('my-id');

    //final json = {'name': name, 'age': 21, 'birthday': DateTime(2001, 7, 28)};

    //await docUser.set(json);

    // * method 2
    final docUser = FirebaseFirestore.instance.collection('users').doc();

    final user = User(
      id: docUser.id,
      name: name,
      age: 21,
      birthday: DateTime(2001, 07, 28),
    );
    final json = user.toJson();

    await docUser.set(json);
  }
}

// * method 2
class User {
  String id;
  final String name;
  final int age;
  final DateTime birthday;

  User({
    this.id = '',
    required this.name,
    required this.age,
    required this.birthday,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'age': age,
        'birthday': birthday,
      };
}
