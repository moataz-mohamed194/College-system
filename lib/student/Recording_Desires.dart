import 'package:collage2/Data/Desires.dart';
import '../Admin/Add_News.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart' as Toast;

class Recording extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Recordingpage();
  }
}

class Recordingpage extends State<Recording> {
  Query _firebaseRef =
      FirebaseDatabase().reference().child('Department').orderByChild('Name');

  List<String> department = <String>[];
  @override
  void initState() {
    super.initState();
    getdepartment();
  }

  getdepartment() {
    _firebaseRef.once().then((DataSnapshot snapshot) {
      final value = snapshot.value as Map;
      for (final key in value.keys) {
        setState(() {
          department.add(value[key]['Name']);
        });
      }
    });
  }

  addyourdesires(List desires) async {
    Map<String, String> add = new Map();
    print(desires);
    int count = 1;
    for (int i = 0; i < desires.length; i++) {
      add["$count"] = "${desires[i]}";

      count++;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String q = prefs.getString('Studentkeys');
    q = q.substring(1, q.length - 1);

    FirebaseDatabase.instance
        .reference()
        .child('student_desires')
        .child("($q)")
        .set(add)
        .whenComplete(() {
      FirebaseDatabase.instance
          .reference()
          .child('student_department')
          .child("(${add['1']})")
          .child("($q)")
          .set({
        'Name': '${prefs.getString('studentname')}',
        'National ID': '${prefs.getString('StudentID')}',
        'phonenumber': '${prefs.getString('Studentphonenumber')}'
      });

      Navigator.of(context).pushNamedAndRemoveUntil(
          '/mainforstudent', (Route<dynamic> route) => false);

      Toast.Toast.show("that news added", context,
          duration: Toast.Toast.LENGTH_SHORT, gravity: Toast.Toast.BOTTOM);
    });

    print(add);
  }

  Future<void> _neverSatisfied() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Remember'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure about your desires?'),
                Text('You can\'t change your desires after click sure'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Sure'),
              onPressed: () {
                addyourdesires(department);
              },
            ),
          ],
        );
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
        title: Text("Add your desires "),
      ),
      body: ReorderableListView(
        children: List.generate(department.length, (index) {
          return ListTile(
            key: ValueKey("value$index"),
            subtitle: Text(
              department[index],
            ),
          );
        }),
        header: Card(
          color: Color(0xfff74883),
          child: FlatButton(
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width / 2,
                child: Text(
                  "Done",
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
              ),
              onPressed: () {
                _neverSatisfied();
//                addyourdesires(department);
              }),
        ),
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            _updateMyItems(oldIndex, newIndex);
          });
        },
      ),
    ));
  }

  void _updateMyItems(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }

    final String item = department.removeAt(oldIndex);
    department.insert(newIndex, item);
  }
}
