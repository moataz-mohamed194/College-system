import 'dart:ffi';

import 'package:collage2/Data/Post.dart';
import 'package:collage2/gobal_values/globals.dart';

import '../Admin/Add_News.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart' as Toast;

import 'Recording_Desires.dart';
import 'Shownews.dart';
import 'attendance.dart';
import 'barcode.dart';

class mainforstudent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return mainpageforstudent();
  }
}

final notesReference = FirebaseDatabase.instance.reference().child('Posts');

class mainpageforstudent extends State<mainforstudent> {
  //that method to change the sharedpreferences which called loginasadmin to equal no
  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('loginasstudent', 'no');
    Navigator.of(context).pushNamedAndRemoveUntil(
        '/LoginStudent', (Route<dynamic> route) => false);
  }

  String studentname;
  nameinstudentpage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      studentname = prefs.getString('studentname');
    });
  }

  List<Post> items;

  @override
  void initState() {
    super.initState();
    nameinstudentpage();
    check();
    items = new List();
  }

  @override
  void dispose() {
    super.dispose();
  }

  var _firebaseRef = FirebaseDatabase().reference().child('Posts');
  Deletepost(String x) {
    _firebaseRef.child(x).remove();
    print("0000000" + x);
  }

  var yy;
  var kk;
  Query _firebaseRef1 = FirebaseDatabase().reference().child('student_desires');
  check() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('timenow', 0);
    yy = prefs.getString('Studentkeys');
    _firebaseRef1.once().then((DataSnapshot snapshot) {
      final value = snapshot.value as Map;
      for (final key in value.keys) {
        setState(() {
          kk = value.containsKey('${prefs.getString('Studentkeys')}');
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              ListTile(
                title: Image.asset("image_gif/unnamed.png"),
                onTap: () {},
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  '$studentname',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Divider(),
              ListTile(
                title: Text('Recording Desires'),
                onTap: () {
                  if (kk == true) {
                    Toast.Toast.show("You added your desires", context,
                        duration: Toast.Toast.LENGTH_SHORT,
                        gravity: Toast.Toast.BOTTOM);
                  } else {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Recording()));
                  }
                },
              ),
              Divider(),
              ListTile(
                title: Text('Barcode'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => barcode()));
                },
              ),
              Divider(),
              ListTile(
                title: Text('Your attendance'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => attendance()));
                },
              ),
              Divider(),
              ListTile(
                title: Text('Show News'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Shownews()));
                },
              ),
              Divider(),
              ListTile(
                title: Text('Log out'),
                onTap: () {
                  logout();
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Color(0xff254660),
          title: Text("Computer and information technology"),
        ),
        body: Container(
          child: StreamBuilder(
            stream: _firebaseRef.onValue,
            builder: (context, snap) {
              if (snap.hasData &&
                  !snap.hasError &&
                  snap.data.snapshot.value != null) {
                Map data = snap.data.snapshot.value;
                List item = [];

                data.forEach(
                    (index, data) => item.add({"key": index, ...data}));

                return ListView.builder(
                  itemCount: item.length,
                  itemBuilder: (context, index) {
                    item.reversed.toList();
                    return Column(
                      children: <Widget>[
                        Card(
                            child: Container(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.height / 70),
                          child: Column(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(bottom: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text('DR:' + item[index]['Name'],
                                        style: TextStyle(
                                            fontSize: 25,
                                            color: Color(0xffff9999)))
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 10),
                                child: Wrap(
                                  direction: Axis.horizontal,
                                  children: <Widget>[
                                    Text(
                                        "( Title:" + item[index]['Title'] + ")",
                                        style: TextStyle(fontSize: 17))
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 10),
                                child: Wrap(
                                  direction: Axis.horizontal,
                                  children: <Widget>[
                                    Text(item[index]['Description'],
                                        style: TextStyle(fontSize: 17))
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text(item[index]['Time'],
                                        style: TextStyle(
                                          fontSize: 17,
                                        ))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                      ],
                    );
                  },
                );
              } else
                return Text("No data");
            },
          ),
        ),
      ),
    );
  }
}
