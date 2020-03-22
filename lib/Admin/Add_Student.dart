import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart' as Toast;

class Addstudent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Addstudentpage();
  }
}

class Addstudentpage extends State<Addstudent> {
  final _formKey = GlobalKey<FormState>();
  final _formKeyjson = GlobalKey<FormState>();
  final FocusNode studentname = FocusNode();
  final FocusNode studentaddress = FocusNode();
  final FocusNode studenthighschool = FocusNode();
  final FocusNode studentNationalid = FocusNode();
  final FocusNode studentphonebumber = FocusNode();
  final FocusNode studentdegree = FocusNode();
  final FocusNode seatnumber = FocusNode();

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  String studentnamesave,
      studentaddresssave,
      studenthighschoolsave,
      studentNationalidsave,
      studentseatnumbersave,
      studentphonebumbersave,
      studentdegreesave;
  TextEditingController controllerstudentname;
  TextEditingController controllerstudentaddress;
  TextEditingController controllerstudenthighschool;
  TextEditingController controllerstudentseatnumber;
  TextEditingController controllerstudentNationalid;
  TextEditingController controllerstudentphonenumber;
  TextEditingController controllerstudentdegree;
  void initState() {
    super.initState();
    controllerstudentname = new TextEditingController();
    controllerstudentaddress = new TextEditingController();
    controllerstudenthighschool = new TextEditingController();
    controllerstudentseatnumber = new TextEditingController();
    controllerstudentNationalid = new TextEditingController();
    controllerstudentphonenumber = new TextEditingController();
    controllerstudentdegree = new TextEditingController();
  }

  //to send student data to database
  submitStudent(String in1, String in2, String in3, String in4, String in5,
      String in6, String in7) {
    if (_formKey.currentState.validate()) {
      DateTime now = new DateTime.now();
      FirebaseDatabase.instance.reference().child('Student').push().set({
        'name': in1,
        'address': in3,
        'phonenumber': in4,
        'ID': in2,
        'seatnumber': in7,
        'high school': in5,
        'degree': in6,
        'Time': "$now"
      }).whenComplete(() {
        Toast.Toast.show("That student is added", context,
            duration: Toast.Toast.LENGTH_SHORT, gravity: Toast.Toast.BOTTOM);
        controllerstudentaddress.text = '';
        controllerstudentdegree.text = '';
        controllerstudentname.text = '';
        controllerstudentphonenumber.text = '';
        controllerstudentNationalid.text = '';
        controllerstudenthighschool.text = '';
        controllerstudentseatnumber.text = '';
      });
    }
  }

  submitStudentjson() {}
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xff002633),
              flexibleSpace: TabBar(
                indicatorColor: Colors.white,
                tabs: [
                  Tab(
                    child: Text("File"),
                  ),
                  Tab(
                    child: Text("Manual"),
                  ),
                ],
              ),
            ),
            body: SingleChildScrollView(
                child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("image_gif/same.jpg"),
                  fit: BoxFit.fill,
                ),
              ),
              child: TabBarView(
                children: [
                  Container(
                      child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Form(
                          key: _formKeyjson,
                          child: Container(
                            width: MediaQuery.of(context).size.width / 1.4,
                            child: Column(
                              children: <Widget>[
                                Card(
                                  color: Color(0xfff74883),
                                  child: FlatButton(
                                      child: Container(
                                        alignment: Alignment.center,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        child: Text(
                                          "Add Students",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17),
                                        ),
                                      ),
                                      onPressed: () {
                                        submitStudentjson();
                                      }),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
                  Container(
                    child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                          Form(
                            key: _formKey,
                            child: Container(
                              width: MediaQuery.of(context).size.width / 1.4,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    child: TextFormField(
                                      cursorColor: Colors.white,
                                      keyboardType: TextInputType.text,
                                      controller: controllerstudentname,
                                      textInputAction: TextInputAction.next,
                                      focusNode: studentname,
                                      onSaved: (input) =>
                                          studentnamesave = input,
                                      onFieldSubmitted: (term) {
                                        _fieldFocusChange(context, studentname,
                                            studentaddress);
                                      },
                                      decoration: new InputDecoration(
                                        labelStyle:
                                            TextStyle(color: Colors.grey),
                                        labelText: "Student Name",
                                        hintText: "Enter Student Name",
                                      ),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Enter Student Name';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                  ),
                                  Container(
                                    child: TextFormField(
                                      cursorColor: Colors.white,
                                      keyboardType: TextInputType.text,
                                      controller: controllerstudentaddress,
                                      textInputAction: TextInputAction.next,
                                      focusNode: studentaddress,
                                      onSaved: (input) =>
                                          studentaddresssave = input,
                                      onFieldSubmitted: (term) {
                                        _fieldFocusChange(context,
                                            studentaddress, studenthighschool);
                                      },
                                      decoration: new InputDecoration(
                                        labelStyle:
                                            TextStyle(color: Colors.grey),
                                        labelText: "Student address",
                                        hintText: "Enter address",
                                      ),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Enter address';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                  ),
                                  Container(
                                    child: TextFormField(
                                      cursorColor: Colors.white,
                                      keyboardType: TextInputType.text,
                                      controller: controllerstudenthighschool,
                                      textInputAction: TextInputAction.next,
                                      focusNode: studenthighschool,
                                      onSaved: (input) =>
                                          studenthighschoolsave = input,
                                      onFieldSubmitted: (term) {
                                        _fieldFocusChange(
                                            context,
                                            studenthighschool,
                                            studentphonebumber);
                                      },
                                      decoration: new InputDecoration(
                                        labelStyle:
                                            TextStyle(color: Colors.grey),
                                        labelText: "Student high school",
                                        hintText: "Enter high school Name",
                                      ),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Enter high school Name';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                  ),
                                  Container(
                                    child: TextFormField(
                                      cursorColor: Colors.white,
                                      keyboardType: TextInputType.text,
                                      controller: controllerstudentphonenumber,
                                      textInputAction: TextInputAction.next,
                                      focusNode: studentphonebumber,
                                      onSaved: (input) =>
                                          studentphonebumbersave = input,
                                      onFieldSubmitted: (term) {
                                        _fieldFocusChange(
                                            context,
                                            studentphonebumber,
                                            studentNationalid);
                                      },
                                      decoration: new InputDecoration(
                                        labelStyle:
                                            TextStyle(color: Colors.grey),
                                        labelText: "Student phone number",
                                        hintText: "Enter phone number",
                                      ),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Enter phone number';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                  ),
                                  Container(
                                    child: TextFormField(
                                      cursorColor: Colors.white,
                                      keyboardType: TextInputType.text,
                                      controller: controllerstudentNationalid,
                                      textInputAction: TextInputAction.next,
                                      focusNode: studentNationalid,
                                      onSaved: (input) =>
                                          studentNationalidsave = input,
                                      onFieldSubmitted: (term) {
                                        _fieldFocusChange(context,
                                            studentNationalid, studentdegree);
                                      },
                                      decoration: new InputDecoration(
                                        labelStyle:
                                            TextStyle(color: Colors.grey),
                                        labelText: "Student National id",
                                        hintText: "Enter National id",
                                      ),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Enter National id';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                  ),
                                  Container(
                                    child: TextFormField(
                                      cursorColor: Colors.white,
                                      keyboardType: TextInputType.text,
                                      controller: controllerstudentdegree,
                                      textInputAction: TextInputAction.next,
                                      focusNode: studentdegree,
                                      onSaved: (input) =>
                                          studentdegreesave = input,
                                      onFieldSubmitted: (term) {
                                        studentdegree.unfocus();
                                      },
                                      decoration: new InputDecoration(
                                        labelStyle:
                                            TextStyle(color: Colors.grey),
                                        labelText: "Student degree",
                                        hintText: "Enter degree",
                                      ),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Enter degree';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                  ),
                                  Container(
                                    child: TextFormField(
                                      cursorColor: Colors.white,
                                      keyboardType: TextInputType.text,
                                      controller: controllerstudentseatnumber,
                                      textInputAction: TextInputAction.done,
                                      focusNode: seatnumber,
                                      onSaved: (input) =>
                                          studentseatnumbersave = input,
                                      onFieldSubmitted: (term) {
                                        studentdegree.unfocus();
                                      },
                                      decoration: new InputDecoration(
                                        labelStyle:
                                            TextStyle(color: Colors.grey),
                                        labelText: "Student seat number",
                                        hintText: "Enter seat number",
                                      ),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Enter seat number';
                                        } else {
                                          return null;
                                        }
                                      },
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
                                            "Add Student",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17),
                                          ),
                                        ),
                                        onPressed: () {
                                          submitStudent(
                                              controllerstudentname.text,
                                              controllerstudentNationalid.text,
                                              controllerstudentphonenumber.text,
                                              controllerstudentaddress.text,
                                              controllerstudenthighschool.text,
                                              controllerstudentdegree.text,
                                              controllerstudentseatnumber.text);
                                        }),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ])),
                  ),
                ],
              ),
            ))),
      ),
    );
  }
}
