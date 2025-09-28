import 'package:flutter/material.dart';
import 'package:user_data/Widgets/card_item.dart';
import 'package:user_data/Widgets/text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var name = TextEditingController();

  var phone = TextEditingController();

  //List<QueryDocumentSnapshot> data = [];

  CollectionReference users = FirebaseFirestore.instance.collection('Users');

  @override
  void initState() {
    //getData();
    super.initState();
  }

  Stream<QuerySnapshot> streamUser = FirebaseFirestore.instance
      .collection('Users')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff121212),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              TextFieldWidget(
                hintText: "Enter Your Name",
                icon: Icon(Icons.person, color: Colors.white),
                controller: name,
              ),
              SizedBox(height: 20),
              TextFieldWidget(
                hintText: "Enter Your Phone",
                icon: Icon(Icons.phone, color: Colors.white),
                controller: phone,
              ),
              SizedBox(height: 20),
              MaterialButton(
                onPressed: () {
                  if (name.text.isNotEmpty && phone.text.isNotEmpty) {
                    addUser(name.text, phone.text);
                    name.clear();
                    phone.clear();
                  }
                },
                color: Colors.deepPurpleAccent,
                height: 50,
                minWidth: 200,
                child: Text(
                  "ADD",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 20),
              StreamBuilder<QuerySnapshot>(
                stream: streamUser,
                builder: (context, Snapshot) {
                  if (Snapshot.hasError) {
                    return Text(
                      "Error",
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    );
                  }
                  if (Snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(color: Colors.white);
                  }

                  var data = Snapshot.data?.docs ?? [];
                  return Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return CardItem(
                          title: data[index]['name'],
                          subTitle: data[index]["phone"],
                          onPressed: () async {
                            await deleteUser(data[index].id);
                          },
                        );
                      },
                      itemCount: data.length,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  addUser(String name, String phone) async {
    loading();
    await users
        .add({"name": name, "phone": phone})
        .then((value) => Navigator.of(context).pop())
        .catchError((error) => print("Faild to add user : $error"));
  }

  // getData() async {
  //   var QuerySnapshot = await users.get();
  //   data.addAll(QuerySnapshot.docs);
  //   setState(() {});
  // }

  Future<void> deleteUser(String id) async {
    loading();
    await users
        .doc(id)
        .delete()
        .then((value) => Navigator.of(context).pop())
        .catchError((error) => print("Faild to delete user!!"));
  }

  void loading() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: Row(
            children: [
              SizedBox(width: 10),
              CircularProgressIndicator(color: Colors.black),
              SizedBox(width: 10),
              Text(
                "Loading",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
