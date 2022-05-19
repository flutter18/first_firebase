import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RetrieveData extends StatefulWidget {
  const RetrieveData({Key? key}) : super(key: key);

  @override
  _RetrieveDataState createState() => _RetrieveDataState();
}

class _RetrieveDataState extends State<RetrieveData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Text("users"),
            Container(
              width: 200,
              height: 300,
              child: StreamBuilder<List<User>>(
                  stream: readUsers(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      final users = snapshot.data!;

                      return ListView(
                        children: users.map(buildUser).toList(),
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }

  Widget buildUser(User user) => ListTile(
        leading: CircleAvatar(
          child: Text('${user.age}'),
        ),
        title: Text(user.name),
        //subtitle: Text(user.birthday.toIso8601String()),
      );

  Stream<List<User>> readUsers() => FirebaseFirestore.instance
      .collection('users')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());
}

class User {
  String id;
  final String name;
  final int age;

  User({
    this.id = '',
    required this.name,
    required this.age,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'age': age,
      };

  static User fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        name: json['name'],
        age: json['age'],
      );
}
