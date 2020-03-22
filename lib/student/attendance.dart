import 'package:collage2/gobal_values/globals.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_code_scanner/qr_scanner_overlay_shape.dart';

import '../Admin/Add_News.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart' as Toast;

class attendance extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return attendancepage();
  }
}

class attendancepage extends State<attendance> {
  @override
  void initState() {
    super.initState();
    data();
  }

  var _firebaseRef = FirebaseDatabase().reference().child('Studentattendance');
  String tt;
  data() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      tt = prefs.getString('Studentkeys');
    });
  }

  Widget attend_data() {
    return StreamBuilder(
      stream: _firebaseRef.child('${tt}').onValue,
      builder: (context, snap) {
        if (snap.hasData &&
            !snap.hasError &&
            snap.data.snapshot.value != null) {
          Map data = snap.data.snapshot.value;
          List item = [];

          data.forEach((index, data) => item.add({"key": index, ...data}));

          return Center(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                        child: Text(
                      "Subject",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 18),
                    )),
                    Expanded(
                        child: Text("Attended",
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width / 18)))
                  ],
                ),
                flex: 1,
              ),
              Divider(),
              Expanded(
                flex: 10,
                child: ListView.builder(
                  itemCount: item.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: <Widget>[
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(child: Text(item[index]['key'])),
                              Expanded(child: Text(item[index]['attended'])),
                            ]),
                        Divider(),
                      ],
                    );
                  },
                ),
              ),
            ],
          ));
        } else
          return Text("No data");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff254660),
          title: Text("Attended"),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                child: attend_data(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
