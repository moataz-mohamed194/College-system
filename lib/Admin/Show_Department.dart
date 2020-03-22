import 'package:collage2/Data/Department.dart';
import 'package:collage2/gobal_values/globals.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Edit_Department.dart';

class ShowDepartment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ShowDepartmentpage();
  }
}

final notesReference =
    FirebaseDatabase.instance.reference().child('Department');

class ShowDepartmentpage extends State<ShowDepartment> {
  List<Department> items;

  @override
  void initState() {
    super.initState();

    items = new List();
  }

  @override
  void dispose() {
    super.dispose();
  }

  var _firebaseRef = FirebaseDatabase().reference().child('Department');
  DeleteDepartment(String x) {
    _firebaseRef.child(x).remove();
    print("0000000" + x);
  }

  Edit() {}
  GlobalState _store = GlobalState.instance;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
                backgroundColor: Color(0xff002633), title: Text("Department")),
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

                          data.forEach((index, data) =>
                              item.add({"key": index, ...data}));

                          return Expanded(
                              child: SizedBox(
                                  child: ListView.builder(
                            itemCount: item.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: <Widget>[
                                  Card(
                                      child: Container(
                                    height: MediaQuery.of(context).size.height /
                                        3.8,
                                    padding: EdgeInsets.all(
                                        MediaQuery.of(context).size.height /
                                            70),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          child: Row(
                                            children: <Widget>[
                                              Text("Name :",
                                                  style:
                                                      TextStyle(fontSize: 17)),
                                              Text(item[index]['Name'],
                                                  style:
                                                      TextStyle(fontSize: 17))
                                            ],
                                          ),
                                        ),
                                        Container(
                                          child: Row(
                                            children: <Widget>[
                                              Text("Capacity :",
                                                  style:
                                                      TextStyle(fontSize: 17)),
                                              Text(item[index]['Capacity'],
                                                  style:
                                                      TextStyle(fontSize: 17))
                                            ],
                                          ),
                                        ),
                                        Container(
                                          child: Row(
                                            children: <Widget>[
                                              Text("Min Degree :",
                                                  style:
                                                      TextStyle(fontSize: 17)),
                                              Text(item[index]['Min Degree'],
                                                  style:
                                                      TextStyle(fontSize: 17))
                                            ],
                                          ),
                                        ),
                                        Container(
                                          child: Row(
                                            children: <Widget>[
                                              Text("Description:",
                                                  style:
                                                      TextStyle(fontSize: 17)),
                                              Text(item[index]['Description'],
                                                  style:
                                                      TextStyle(fontSize: 17))
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
                                                  "Edit Department",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 17),
                                                ),
                                              ),
                                              onPressed: () {
                                                _store.set('departmentname',
                                                    item[index]['Name']);
                                                _store.set('departmentkey',
                                                    item[index]['key']);
                                                _store.set('departmentcapacity',
                                                    item[index]['Capacity']);
                                                _store.set(
                                                    'departmentmindegree',
                                                    item[index]['Min Degree']);
                                                _store.set(
                                                    'departmentdescription',
                                                    item[index]['Description']);

                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            EditDepartment()));
                                              }),
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
                                                  "Delete Department",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 17),
                                                ),
                                              ),
                                              onPressed: () {
                                                DeleteDepartment(
                                                    item[index]['key']);
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
                ))));
  }
}
