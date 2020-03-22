import 'package:collage2/Data/News.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Add_Department.dart';
import 'Add_News.dart';
import 'Add_Student.dart';
import 'Add_admin.dart';
import 'Add_professor.dart';
import 'Show_Department.dart';
import 'Show_Student.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class mainforadmin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return mainpageforadmin();
  }
}

final notesReference = FirebaseDatabase.instance.reference().child('News');

class mainpageforadmin extends State<mainforadmin> {
  //that method to change the sharedpreferences which called loginasadmin to equal no
  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('loginasadmin', 'no');
    Navigator.of(context).pushNamedAndRemoveUntil(
        '/Pro_admin_login', (Route<dynamic> route) => false);
  }

  void initState() {
    super.initState();
    nameinadminpage();
    items = new List();
  }

  //to get the data which in shared preferences and add it in adminname
  String adminname;
  nameinadminpage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      adminname = prefs.getString('adminname');
    });
  }

  List<News> items;

  @override
  void dispose() {
    super.dispose();
  }

  var _firebaseRef = FirebaseDatabase().reference().child('News');

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
                  'MR:' + '$adminname',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Divider(),
              ListTile(
                title: Text('Add News'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddNews()));
                },
              ),
              Divider(),
              ListTile(
                title: Text('Add Departent'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddDepartment()));
                },
              ),
              Divider(),
              ListTile(
                title: Text('Add Admin'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddAdmin()));
                },
              ),
              Divider(),
              ListTile(
                title: Text('Add Student'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Addstudent()));
                },
              ),
              Divider(),
              ListTile(
                title: Text('Add Professor'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Addprofessor()));
                },
              ),
              Divider(),
              ListTile(
                title: Text('Show Departent'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ShowDepartment()));
                },
              ),
              Divider(),
              ListTile(
                title: Text('Show Student'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Showstudent()));
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
          //dbcdc3
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
                  //   reverse: true,
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
                                child: Wrap(
                                  direction: Axis.horizontal,
                                  children: <Widget>[
                                    Text(item[index]['Title'],
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
                                    Text(item[index]['Description'],
                                        style: TextStyle(fontSize: 17))
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 10),
                                child: Wrap(
                                  direction: Axis.horizontal,
                                  children: <Widget>[
                                    item[index]['Details'] != ''
                                        ? Linkify(
                                            onOpen: (link) async {
                                              if (await canLaunch(
                                                  item[index]['Details'])) {
                                                await launch(
                                                    item[index]['Details']);
                                              } else {
                                                throw 'Could not launch ${item[index]['Details']}';
                                              }
                                            },
                                            text: "For more details: " +
                                                "${item[index]['Details']}",
                                            style:
                                                TextStyle(color: Colors.blue),
                                            linkStyle:
                                                TextStyle(color: Colors.blue),
                                          )
                                        : Container(),
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
