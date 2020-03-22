import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Data/Student.dart';

class Showstudent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Showstudentpage();
  }
}

final notesReference = FirebaseDatabase.instance.reference().child('Student');

class Showstudentpage extends State<Showstudent> {
  List<Student> items;

  @override
  void initState() {
    super.initState();

    items = new List();
  }

  @override
  void dispose() {
    super.dispose();
  }

  var _firebaseRef = FirebaseDatabase().reference().child('Student');
  DeleteStudent(String x) {
    _firebaseRef.child(x).remove();
    print("0000000" + x);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(backgroundColor: Color(0xff002633), title: Text("Students")),
        body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xff000000), Color(0xff254660)]),
            ),
            child: Column(
              children: <Widget>[
                StreamBuilder(
                  stream: _firebaseRef.onValue,
                  builder: (context, snap) {
                    if (snap.hasData &&
                        !snap.hasError &&
                        snap.data.snapshot.value != null) {
                      Map data = snap.data.snapshot.value;
                      List item = [];

                      data.forEach(
                          (index, data) => item.add({"key": index, ...data}));

                      return Expanded(
                          child: SizedBox(
                              child: ListView.builder(
                        itemCount: item.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: <Widget>[
                              Card(
                                  child: Container(
                                height: MediaQuery.of(context).size.height / 4,
                                padding: EdgeInsets.all(
                                    MediaQuery.of(context).size.height / 70),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      child: Row(
                                        children: <Widget>[
                                          Text("Name :",
                                              style: TextStyle(fontSize: 17)),
                                          Text(item[index]['name'],
                                              style: TextStyle(fontSize: 17))
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        children: <Widget>[
                                          Text("ID :",
                                              style: TextStyle(fontSize: 17)),
                                          Text(item[index]['ID'],
                                              style: TextStyle(fontSize: 17))
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        children: <Widget>[
                                          Text("address :",
                                              style: TextStyle(fontSize: 17)),
                                          Text(item[index]['address'],
                                              style: TextStyle(fontSize: 17))
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        children: <Widget>[
                                          Text("Phone number :",
                                              style: TextStyle(fontSize: 17)),
                                          Text(item[index]['phonenumber'],
                                              style: TextStyle(fontSize: 17))
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        children: <Widget>[
                                          Text("Degree :",
                                              style: TextStyle(fontSize: 17)),
                                          Text(item[index]['degree'],
                                              style: TextStyle(fontSize: 17))
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        children: <Widget>[
                                          Text("Seat Number :",
                                              style: TextStyle(fontSize: 17)),
                                          Text(item[index]['seatnumber'],
                                              style: TextStyle(fontSize: 17))
                                        ],
                                      ),
                                    ),
                                    Card(
                                      color: Color(0xfff74883),
                                      child: FlatButton(
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2,
                                            child: Text(
                                              "Delete Student",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 17),
                                            ),
                                          ),
                                          onPressed: () {
                                            DeleteStudent(item[index]['key']);
                                          }),
                                    ),
                                  ],
                                ),
                              )),
                            ],
                          );
                        },
                      )));
                    } else
                      return Text("No data");
                  },
                ),
              ],
            )));
  }
}
