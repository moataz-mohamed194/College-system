import 'dart:ui';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:core';
import 'package:flutter/material.dart' as prefix0;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart' as Toast;
import 'dart:async';
import 'package:flutter_lottie/flutter_lottie.dart';

class LoginStudent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new LoginStudentPage();
  }
}

class LoginStudentPage extends State<LoginStudent> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode studentidnode = FocusNode();
  final FocusNode studentpasswordnode = FocusNode();
  TextEditingController studentid;
  TextEditingController studentpassword;
  String studentidsave, studentpasswordsave;
  bool checkstudent = false;

  //when you check it will create shared preferences to save you loged in
  sharedpreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('loginasstudent', 'yes');
  }

  void checkstudentChanged(bool value) {
    setState(() {
      checkstudent = value;
      sharedpreferences();
    });
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  //when click on eye change the icon and show the password
  bool _isHidden = true;
  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  void initState() {
    studentid = new TextEditingController();
    studentpassword = new TextEditingController();
  }

//login to admin to check if id is in database and if yes check if it's his password
  loginstudent(String ID, String Password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Query _firebaseRef = FirebaseDatabase()
        .reference()
        .child('Student')
        .orderByChild('ID')
        .equalTo(ID);

    _firebaseRef.once().then((DataSnapshot snapshot) {
      final value = snapshot.value as Map;
      for (final key in value.keys) {
        if (value[key]['seatnumber'] == Password) {
          prefs.setString('studentname', '${value[key]['name']}');
          prefs.setString('StudentID', '${value[key]['ID']}');
          prefs.setString('StudentPassword', '${value[key]['seatnumber']}');
          prefs.setString('Studentphonenumber', '${value[key]['phonenumber']}');
          prefs.setString('Studentkeys', '${value.keys}');
          if (checkstudent == true) {
            prefs.setString('loginasstudent', 'yes');
          }
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/mainforstudent', (Route<dynamic> route) => false);
          Toast.Toast.show("Welcome to our app", context,
              duration: Toast.Toast.LENGTH_SHORT, gravity: Toast.Toast.BOTTOM);
        } else {
          Toast.Toast.show("Check your Password ", context,
              duration: Toast.Toast.LENGTH_SHORT, gravity: Toast.Toast.BOTTOM);
        }
      }
    }).catchError((Object error) {
      Toast.Toast.show("Check your ID  ", context,
          duration: Toast.Toast.LENGTH_SHORT, gravity: Toast.Toast.BOTTOM);
    });
  }

  LottieController controller;
  StreamController<double> newProgressStream;

  LoginStudentPage() {
    newProgressStream = new StreamController<double>();
  }
  void onViewCreatedFile(LottieController controller) {
    this.controller = controller;
    newProgressStream.stream.listen((double progress) {
      this.controller.setAnimationProgress(progress);
    });
  }

  void dispose() {
    super.dispose();
    newProgressStream.close();
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
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xff000000), Color(0xff254660)]),
          ),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  // margin: EdgeInsets.only(top: 100),
                  child: LottieView.fromFile(
                    filePath: "image_gif/finalprof.json",
                    autoPlay: true,
                    loop: true,
                    reverse: true,
                    onViewCreated: onViewCreatedFile,
                  ),
                  //  Image.asset("image_gif/12335-jeremy-corbyn.gif"),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: <Widget>[
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            cursorColor: Colors.white,
                            keyboardType: TextInputType.emailAddress,
                            controller: studentid,
                            textInputAction: TextInputAction.next,
                            focusNode: studentidnode,
                            style: TextStyle(color: Colors.white),
                            onSaved: (input) => studentidsave = input,
                            onFieldSubmitted: (term) {
                              _fieldFocusChange(
                                  context, studentidnode, studentpasswordnode);
                            },
                            decoration: new InputDecoration(
                              icon: new Icon(
                                Icons.alternate_email,
                                color: Colors.grey,
                              ),
                              labelStyle: prefix0.TextStyle(color: Colors.grey),
                              labelText: "Your ID",
                              hintText: "Enter your ID",
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter your ID';
                              } else {
                                return null;
                              }
                            },
                          ),
                          TextFormField(
                            controller: studentpassword,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            focusNode: studentpasswordnode,
                            style: TextStyle(color: Colors.white),
                            onSaved: (input) => studentpasswordsave = input,
                            onFieldSubmitted: (value) {
                              studentpasswordnode.unfocus();
                            },
                            decoration: InputDecoration(
                              icon: new Icon(
                                Icons.lock,
                                color: Colors.grey,
                              ),
                              labelStyle: prefix0.TextStyle(color: Colors.grey),
                              labelText: "Your Password",
                              hintText: "Enter your password",
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 16.0,
                              ),
                              suffixIcon: "Password" == "Password"
                                  ? IconButton(
                                      onPressed: _toggleVisibility,
                                      icon: _isHidden
                                          ? Icon(Icons.visibility)
                                          : Icon(Icons.visibility_off),
                                      color: Colors.grey,
                                    )
                                  : null,
                            ),
                            obscureText:
                                "Password" == "Password" ? _isHidden : false,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter your password';
                              }
                              /*if (value.length < 6) {
                          return 'your password must more than 6';
                        }*/
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    CheckboxListTile(
                      value: checkstudent,
                      checkColor: Colors.grey,
                      onChanged: checkstudentChanged,
                      title: new Text(
                        'Remember me',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                      activeColor: Colors.white,
                    ),
                    //_resultList(),
                    Card(
                      color: Color(0xfff74883),
                      child: FlatButton(
                          child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              "Student Login",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            ),
                          ),
                          onPressed: () {
                            loginstudent(studentid.text, studentpassword.text);
                          }),
                    )
                  ],
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
