import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:toast/toast.dart' as Toast;

class AddDepartment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddDepartmentPage();
  }
}

class AddDepartmentPage extends State<AddDepartment> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode departmentname = FocusNode();
  final FocusNode departmentcapacity = FocusNode();
  final FocusNode departmentdescription = FocusNode();
  final FocusNode departmentmindegree = FocusNode();
  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  TextEditingController controllerdepartmentname;
  TextEditingController controllerdepartmentmindegree;
  TextEditingController controllerdepartmentcapacity;
  TextEditingController controllerdepartmentdescription;
  String departmentnamesave,
      departmentcapacitysave,
      departmentdescriptionsave,
      departmentmindegreesave;
  void initState() {
    super.initState();
    controllerdepartmentname = new TextEditingController();
    controllerdepartmentmindegree = new TextEditingController();
    controllerdepartmentcapacity = new TextEditingController();
    controllerdepartmentdescription = new TextEditingController();
  }

  //to send the department data to firebase
  submitdepartment(String in1, String in2, String in3, String in4) {
    if (_formKey.currentState.validate()) {
      DateTime now = new DateTime.now();
      FirebaseDatabase.instance.reference().child('Department').push().set({
        'Name': in1,
        'Capacity': in2,
        'Min Degree': in3,
        'Description': in4,
        'Time': "$now"
      }).whenComplete(() {
         Toast.Toast.show("that department added", context,
            duration: Toast.Toast.LENGTH_SHORT, gravity: Toast.Toast.BOTTOM);
       
        controllerdepartmentdescription.text = '';
        controllerdepartmentmindegree.text = '';
        controllerdepartmentname.text = '';
        controllerdepartmentcapacity.text = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("image_gif/same.jpg"),
              fit: BoxFit.fill,
            ),
          ),
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
                          margin: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height / 60),
                          child: TextFormField(
                            cursorColor: Colors.white,
                            keyboardType: TextInputType.text,
                            controller: controllerdepartmentname,
                            textInputAction: TextInputAction.next,
                            focusNode: departmentname,
                            onSaved: (input) => departmentnamesave = input,
                            onFieldSubmitted: (term) {
                              _fieldFocusChange(
                                  context, departmentname, departmentcapacity);
                            },
                            decoration: new InputDecoration(
                              labelStyle: TextStyle(color: Colors.grey),
                              labelText: "Department Name",
                              hintText: "Enter Department Name",
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter Department Name';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height / 60),
                          child: TextFormField(
                            cursorColor: Colors.white,
                            keyboardType: TextInputType.number,
                            controller: controllerdepartmentcapacity,
                            textInputAction: TextInputAction.next,
                            focusNode: departmentcapacity,
                            onSaved: (input) => departmentcapacitysave = input,
                            onFieldSubmitted: (term) {
                              _fieldFocusChange(context, departmentcapacity,
                                  departmentmindegree);
                            },
                            decoration: new InputDecoration(
                              labelStyle: TextStyle(color: Colors.grey),
                              labelText: "Department Capacity",
                              hintText: "Enter Department Capacity",
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter Department Capacity';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height / 60),
                          child: TextFormField(
                            cursorColor: Colors.white,
                            keyboardType: TextInputType.number,
                            controller: controllerdepartmentmindegree,
                            textInputAction: TextInputAction.next,
                            focusNode: departmentmindegree,
                            onSaved: (input) => departmentmindegreesave = input,
                            onFieldSubmitted: (term) {
                              _fieldFocusChange(context, departmentmindegree,
                                  departmentdescription);
                            },
                            decoration: new InputDecoration(
                              labelStyle: TextStyle(color: Colors.grey),
                              labelText: "Min Degree",
                              hintText: "Enter Min Degree",
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter Min Degree';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height / 60),
                          child: TextFormField(
                            cursorColor: Colors.white,
                            keyboardType: TextInputType.text,
                            controller: controllerdepartmentdescription,
                            textInputAction: TextInputAction.done,
                            focusNode: departmentdescription,
                            onSaved: (input) =>
                                departmentdescriptionsave = input,
                            onFieldSubmitted: (value) {
                              departmentdescription.unfocus();
                            },
                            decoration: new InputDecoration(
                              labelStyle: TextStyle(color: Colors.grey),
                              labelText: "Department Description",
                              hintText: "Enter Department Description",
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter Department Description';
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
                                  "Add Department",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17),
                                ),
                              ),
                              onPressed: () {
                                submitdepartment(
                                    controllerdepartmentname.text,
                                    controllerdepartmentcapacity.text,
                                    controllerdepartmentmindegree.text,
                                    controllerdepartmentdescription.text);
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
