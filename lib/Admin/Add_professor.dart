import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart' as Toast;

class Addprofessor extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Addprofessorpage();
  }
}

class Addprofessorpage extends State<Addprofessor> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode professorname = FocusNode();
  final FocusNode professorNationalid = FocusNode();
  final FocusNode professorphonebumber = FocusNode();
  final FocusNode professorPassword = FocusNode();

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  String professornamesave,
      professorNationalidsave,
      professorphonebumbersave,
      professorPasswordsave;
  TextEditingController controllerprofessorname;
  TextEditingController controllerprofessorPassword;
  TextEditingController controllerprofessorNationalid;
  TextEditingController controllerprofessorphonenumber;
  void initState() {
    super.initState();
    controllerprofessorname = new TextEditingController();
    controllerprofessorPassword = new TextEditingController();
    controllerprofessorNationalid = new TextEditingController();
    controllerprofessorphonenumber = new TextEditingController();
  }

  //to send the professor data to database
  submitStudent(String in1, String in2, String in3, String in4) {
    if (_formKey.currentState.validate()) {
      DateTime now = new DateTime.now();
      FirebaseDatabase.instance.reference().child('Professor').push().set({
        'realName': in1,
        'ID': in2,
        'Password': in3,
        'Phonenumber': in4,
        'Time': "$now"
      }).whenComplete(() {
        Toast.Toast.show("That Professor is added", context,
            duration: Toast.Toast.LENGTH_SHORT, gravity: Toast.Toast.BOTTOM);
        controllerprofessorname.text = '';
        controllerprofessorNationalid.text = '';
        controllerprofessorPassword.text = '';
        controllerprofessorphonenumber.text = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
              child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("image_gif/same.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: Container(
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
                            controller: controllerprofessorname,
                            textInputAction: TextInputAction.next,
                            focusNode: professorname,
                            onSaved: (input) => professornamesave = input,
                            onFieldSubmitted: (term) {
                              _fieldFocusChange(
                                  context, professorname, professorNationalid);
                            },
                            decoration: new InputDecoration(
                              labelStyle: TextStyle(color: Colors.grey),
                              labelText: "Professor Name",
                              hintText: "Enter Professor Name",
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter Professor Name';
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
                            controller: controllerprofessorNationalid,
                            textInputAction: TextInputAction.next,
                            focusNode: professorNationalid,
                            onSaved: (input) => professorNationalidsave = input,
                            onFieldSubmitted: (term) {
                              _fieldFocusChange(context, professorNationalid,
                                  professorphonebumber);
                            },
                            decoration: new InputDecoration(
                              labelStyle: TextStyle(color: Colors.grey),
                              labelText: "Professor Nationalid",
                              hintText: "Enter Nationalid",
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter Nationalid';
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
                            controller: controllerprofessorphonenumber,
                            textInputAction: TextInputAction.next,
                            focusNode: professorphonebumber,
                            onSaved: (input) =>
                                professorphonebumbersave = input,
                            onFieldSubmitted: (term) {
                              _fieldFocusChange(context, professorphonebumber,
                                  professorPassword);
                            },
                            decoration: new InputDecoration(
                              labelStyle: TextStyle(color: Colors.grey),
                              labelText: "Professor phonebumber",
                              hintText: "Enter Professor phonebumber",
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter Professor phonebumber';
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
                            controller: controllerprofessorPassword,
                            textInputAction: TextInputAction.done,
                            focusNode: professorPassword,
                            onSaved: (input) => professorPasswordsave = input,
                            onFieldSubmitted: (term) {
                              professorPassword.unfocus();
                            },
                            decoration: new InputDecoration(
                              labelStyle: TextStyle(color: Colors.grey),
                              labelText: "professor Password",
                              hintText: "Enter Password",
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter Password';
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
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  "Add Professor",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17),
                                ),
                              ),
                              onPressed: () {
                                submitStudent(
                                    controllerprofessorname.text,
                                    controllerprofessorNationalid.text,
                                    controllerprofessorPassword.text,
                                    controllerprofessorphonenumber.text);
                              }),
                        ),
                      ],
                    ),
                  ),
                )
              ])),
        ),
      ))),
    );
  }
}
