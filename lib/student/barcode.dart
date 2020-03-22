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

class barcode extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return barcodepage();
  }
}

class barcodepage extends State<barcode> {
  GlobalKey qrkey = GlobalKey();
  GlobalState _store = GlobalState.instance;

  var isButtonDisabled = false;
  var qrText = "";
  QRViewController controller;
  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    gettime();
  }

  int time;
  gettime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getInt('timenow') == DateTime.now().hour) {
    } else {}
  }

  add_attendance(String in2) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int i = 0;
    String q;
    if (prefs.getInt('timenow') == DateTime.now().hour ||
        prefs.getInt('timenow') < DateTime.now().hour) {
      FirebaseDatabase.instance
          .reference()
          .child('Studentattendance')
          .child('${prefs.getString('Studentkeys')}')
          .child(in2)
          .once()
          .then((DataSnapshot snapshot) {
        if (snapshot.value == null) {
          FirebaseDatabase.instance
              .reference()
              .child('Studentattendance')
              .child('${prefs.getString('Studentkeys')}')
              .child(in2)
              .set({
            'Name': prefs.getString('studentname'),
            'attended': "1",
          }).whenComplete(() {
            Toast.Toast.show("you attend 1 lecture", context,
                duration: Toast.Toast.LENGTH_SHORT,
                gravity: Toast.Toast.BOTTOM);

            int k = DateTime.now().hour + 2;
            if (prefs.getInt('timenow') == 25) {
              prefs.setInt('timenow', 1);
            } else if (prefs.getInt('timenow') == 26) {
              prefs.setInt('timenow', 2);
            } else {
              prefs.setInt('timenow', k);
            }
          });
          print("11111111111" + "${snapshot.value}");
        } else if (snapshot.value != null) {
          Query _firebaseRef = FirebaseDatabase()
              .reference()
              .child('Studentattendance')
              .child('${prefs.getString('Studentkeys')}')
              .child(in2)
              .orderByChild('attended');
          _firebaseRef.once().then((DataSnapshot snapshot) {
            i = int.parse(snapshot.value['attended']);
            i = i + 1;
            _store.set('count1', i.toString());
            print("mmmmm" +
                "${snapshot.value['attended']}" +
                "${_store.get('count1')}");
            q = "${snapshot.value['attended']}";
          }).whenComplete(() {
            print("${_store.get('count1')}");
            Toast.Toast.show(_store.get('count1'), context,
                duration: Toast.Toast.LENGTH_SHORT,
                gravity: Toast.Toast.BOTTOM);

            FirebaseDatabase.instance
                .reference()
                .child('Studentattendance')
                .child('${prefs.getString('Studentkeys')}')
                .child(in2)
                .set({
              'Name': prefs.getString('studentname'),
              'attended': "${_store.get('count1')}",
            }).whenComplete(() {
              int k = DateTime.now().hour + 2;
              if (prefs.getInt('timenow') == 25) {
                prefs.setInt('timenow', 1);
              } else if (prefs.getInt('timenow') == 26) {
                prefs.setInt('timenow', 2);
              } else {
                prefs.setInt('timenow', k);
              }

              //prefs.getInt('timenow')
              Toast.Toast.show(
                  "${prefs.getInt('timenow')}you attend ${_store.get('count1')} lecture",
                  context,
                  duration: Toast.Toast.LENGTH_SHORT,
                  gravity: Toast.Toast.BOTTOM);
            });
          });
        }
      });
    } else {
      Toast.Toast.show("you attend ${_store.get('count1')} lecture", context,
          duration: Toast.Toast.LENGTH_SHORT, gravity: Toast.Toast.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: QRView(
                  key: qrkey,
                  overlay: QrScannerOverlayShape(
                      borderRadius: 10,
                      borderColor: Colors.red,
                      borderLength: 30,
                      borderWidth: 10,
                      cutOutSize: 300),
                  onQRViewCreated: _onQRviewcreate),
            ),
            Expanded(
                child: Column(
              children: <Widget>[
                Text(
                  '$qrText',
                  style: TextStyle(fontSize: 20),
                ),
                Card(
                  color: Color(0xfff74883),
                  child: FlatButton(
                      autofocus: false,
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width / 2,
                        child: Text(
                          "Done",
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                      ),
                      onPressed: () {
                        add_attendance(qrText);
                        print("object");
                      }),
                )
              ],
            )),
          ],
        ),
      ),
    );
  }

  void _onQRviewcreate(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        qrText = scanData;
      });
    });
  }
}
