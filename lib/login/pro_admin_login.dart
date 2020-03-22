import 'package:collage2/gobal_values/globals.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart' as Toast;
import 'dart:async';
import 'package:flutter_lottie/flutter_lottie.dart';

class Pro_admin_login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new Pro_admin_loginpage();
  }
}

class Pro_admin_loginpage extends State<Pro_admin_login> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode studentidnode = FocusNode();
  final FocusNode studentpasswordnode = FocusNode();
  TextEditingController studentid;
  TextEditingController studentpassword;
  String studentidsave, studentpasswordsave;
  bool checkprofessoradminlogin = false;
  void initState() {
    super.initState();
    studentid = new TextEditingController();
    studentpassword = new TextEditingController();
  }

  GlobalState _store = GlobalState.instance;
  //that method to when click on next button in keyboard go to next textfield
  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  //when click on eye icon change the icon and make the text be able to see
  bool _isHidden = true;
  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  String buttontext = "Professor Login";
  String logintext = "Professor";
  String textanotherpage = "Admin";

  //that method to change values of checkprofessoradminlogin when click
  void checkprofessoradminChanged(bool value) {
    setState(() {
      checkprofessoradminlogin = value;
    });
  }

  LottieController controller21;
  StreamController<double> newProgressStream1;

  Pro_admin_loginpage() {
    newProgressStream1 = new StreamController<double>();
  }
  void onViewCreatedFile(LottieController controller) {
    this.controller21 = controller;
    newProgressStream1.stream.listen((double progress) {
      this.controller21.setAnimationProgress(progress);
    });
  }

  void dispose() {
    super.dispose();
    newProgressStream1.close();
  }

  // to login as admin or as professor where search about the id and get hs data
  loginadmin(String ID, String Password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Query _firebaseRef = FirebaseDatabase()
        .reference()
        .child('Admin')
        .orderByChild('ID')
        .equalTo(ID);

    _firebaseRef.once().then((DataSnapshot snapshot) {
      final value = snapshot.value as Map;
      for (final key in value.keys) {
        if (value[key]['Password'] == Password) {
          prefs.setString('adminname', '${value[key]['realName']}');
          prefs.setString('adminID', '${value[key]['ID']}');
          prefs.setString('adminPassword', '${value[key]['Password']}');
          prefs.setString('adminPhonenumber', '${value[key]['Phonenumber']}');
          prefs.setString('adminkeys', '${value.keys}');
          if (checkprofessoradminlogin == true) {
            prefs.setString('loginasadmin', 'yes');
          }

          Navigator.of(context).pushNamedAndRemoveUntil(
              '/mainforadmin', (Route<dynamic> route) => false);
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

  loginProfessor(String ID, String Password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Query _firebaseRef = FirebaseDatabase()
        .reference()
        .child('Professor')
        .orderByChild('ID')
        .equalTo(ID);

    _firebaseRef.once().then((DataSnapshot snapshot) {
      final value = snapshot.value as Map;
      for (final key in value.keys) {
        if (value[key]['Password'] == Password) {
          prefs.setString('professorname', '${value[key]['realName']}');
          prefs.setString('professorID', '${value[key]['ID']}');
          prefs.setString('professorPassword', '${value[key]['Password']}');
          prefs.setString('professorkey', '${value.keys}');
          if (checkprofessoradminlogin == true) {
            prefs.setString('loginasprofessor', 'yes');
          }

          Navigator.of(context).pushNamedAndRemoveUntil(
              '/mainforprofessor', (Route<dynamic> route) => false);

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

  @override
  Widget build(BuildContext context) {
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
                  // Image.asset("image_gif/12335-jeremy-corbyn.gif"),
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
                              labelStyle: TextStyle(color: Colors.grey),
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
                              labelStyle: TextStyle(color: Colors.grey),
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
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    CheckboxListTile(
                      value: checkprofessoradminlogin,
                      checkColor: Colors.grey,
                      onChanged: checkprofessoradminChanged,
                      title: new Text(
                        'Remember me',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                      activeColor: Colors.white,
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 15),
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        child: Text(
                          "I'm " + textanotherpage,
                          style: TextStyle(color: Colors.grey, fontSize: 20),
                        ),
                        onTap: () {
                          setState(() {
                            if (textanotherpage != "Professor") {
                              textanotherpage = "Professor";
                              buttontext = "Admin Login";
                              logintext = "Admin";
                            } else if (textanotherpage == "Professor") {
                              textanotherpage = "Admin";
                              logintext = "Professor";
                              buttontext = "Professor Login";
                            }
                          });
                        },
                      ),
                    ),
                    //_resultList(),
                    //_resultList1(),
                    Card(
                      color: Color(0xfff74883),
                      child: FlatButton(
                          child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              buttontext,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            ),
                          ),
                          onPressed: () {
                            if (logintext == "Professor") {
                              loginProfessor(
                                  studentid.text, studentpassword.text);
                            } else if (logintext == "Admin") {
                              loginadmin(studentid.text, studentpassword.text);
                            }
//                            studentloginpage(
                            //                              studentid.text, studentpassword.text);
                          }),
                    ),
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
