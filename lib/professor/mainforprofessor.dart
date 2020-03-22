import 'package:collage2/Data/Post.dart';
import '../Admin/Add_News.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Add_Posts.dart';

class mainforprofessor extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return mainpageforprofessor();
  }
}

final notesReference = FirebaseDatabase.instance.reference().child('Posts');

class mainpageforprofessor extends State<mainforprofessor> {
  //that method to change the sharedpreferences which called loginasadmin to equal no
  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('loginasprofessor', 'no');
    Navigator.of(context).pushNamedAndRemoveUntil(
        '/Pro_admin_login', (Route<dynamic> route) => false);
  }

  String professorname;
  nameinprofessorpage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      professorname = prefs.getString('professorname');
    });
  }

  List<Post> items;

  @override
  void initState() {
    super.initState();
    nameinprofessorpage();

    items = new List();
  }

  @override
  void dispose() {
    super.dispose();
  }

  var _firebaseRef = FirebaseDatabase().reference().child('Posts');
  Deletepost(String x) {
    _firebaseRef.child(x).remove();
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
                  'DR:' + '$professorname',
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
                title: Text('Add Posts'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddPosts()));
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
            stream: _firebaseRef
                .orderByChild('Name')
                .equalTo('$professorname')
                .onValue,
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
                              Card(
                                color: Color(0xfff74883),
                                child: FlatButton(
                                    child: Container(
                                      alignment: Alignment.center,
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      child: Text(
                                        "Delete Post",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 17),
                                      ),
                                    ),
                                    onPressed: () {
                                      Deletepost(item[index]['key']);
                                    }),
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
