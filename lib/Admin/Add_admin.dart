import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart' as Toast;

class AddAdmin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddAdminpage();
  }
}

class AddAdminpage extends State<AddAdmin> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode adminname = FocusNode();
  final FocusNode adminNationalid = FocusNode();
  final FocusNode adminphonebumber = FocusNode();
  final FocusNode adminPassword = FocusNode();

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  String adminnamesave,
      adminNationalidsave,
      adminphonebumbersave,
      adminPasswordsave;
  TextEditingController controlleradminname;
  TextEditingController controlleradminPassword;
  TextEditingController controlleradminNationalid;
  TextEditingController controlleradminphonenumber;
  void initState() {
    super.initState();
    controlleradminname = new TextEditingController();
    controlleradminPassword = new TextEditingController();
    controlleradminNationalid = new TextEditingController();
    controlleradminphonenumber = new TextEditingController();
  }

  //that method to send the admin data to firebase
  submitadmin(String in1, String in2, String in3, String in4) {
    if (_formKey.currentState.validate()) {
      DateTime now = new DateTime.now();
      FirebaseDatabase.instance.reference().child('Admin').push().set({
        'realName': in1,
        'ID': in2,
        'Password': in3,
        'Phonenumber': in4,
        'Time': "$now"
      }).whenComplete(() {
        Toast.Toast.show("That admin is added", context,
            duration: Toast.Toast.LENGTH_SHORT, gravity: Toast.Toast.BOTTOM);
        controlleradminname.text = '';
        controlleradminNationalid.text = '';
        controlleradminPassword.text = '';
        controlleradminphonenumber.text = '';
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
                            controller: controlleradminname,
                            textInputAction: TextInputAction.next,
                            focusNode: adminname,
                            onSaved: (input) => adminnamesave = input,
                            onFieldSubmitted: (term) {
                              _fieldFocusChange(
                                  context, adminname, adminNationalid);
                            },
                            decoration: new InputDecoration(
                              labelStyle: TextStyle(color: Colors.grey),
                              labelText: "admin Name",
                              hintText: "Enter admin Name",
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter admin Name';
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
                            controller: controlleradminNationalid,
                            textInputAction: TextInputAction.next,
                            focusNode: adminNationalid,
                            onSaved: (input) => adminNationalidsave = input,
                            onFieldSubmitted: (term) {
                              _fieldFocusChange(
                                  context, adminNationalid, adminphonebumber);
                            },
                            decoration: new InputDecoration(
                              labelStyle: TextStyle(color: Colors.grey),
                              labelText: "admin Nationalid",
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
                            controller: controlleradminphonenumber,
                            textInputAction: TextInputAction.next,
                            focusNode: adminphonebumber,
                            onSaved: (input) => adminphonebumbersave = input,
                            onFieldSubmitted: (term) {
                              _fieldFocusChange(
                                  context, adminphonebumber, adminPassword);
                            },
                            decoration: new InputDecoration(
                              labelStyle: TextStyle(color: Colors.grey),
                              labelText: "admin phonebumber",
                              hintText: "Enter admin phonebumber",
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter admin phonebumber';
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
                            controller: controlleradminPassword,
                            textInputAction: TextInputAction.done,
                            focusNode: adminPassword,
                            onSaved: (input) => adminPasswordsave = input,
                            onFieldSubmitted: (term) {
                              adminPassword.unfocus();
                            },
                            decoration: new InputDecoration(
                              labelStyle: TextStyle(color: Colors.grey),
                              labelText: "admin Password",
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
                                  "Add Admin",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17),
                                ),
                              ),
                              onPressed: () {
                                submitadmin(
                                    controlleradminname.text,
                                    controlleradminNationalid.text,
                                    controlleradminPassword.text,
                                    controlleradminphonenumber.text);
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
