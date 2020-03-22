import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart' as Toast;

class AddPosts extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddPostspage();
  }
}

class AddPostspage extends State<AddPosts> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode Poststitle = FocusNode();
  final FocusNode Postsdescription = FocusNode();
  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  TextEditingController controllerPoststitle;
  TextEditingController controllerPostsdescription;
  void initState() {
    super.initState();
    controllerPoststitle = new TextEditingController();
    controllerPostsdescription = new TextEditingController();
    nameinprofessorpage();
  }

  String professorname;
  nameinprofessorpage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      professorname = prefs.getString('professorname');
    });
//    return Text(prefs.getString('professorname'));
  }

  String Poststitlesave, Postsdescriptionsave;
  //to send the post data to database
  submitnews(String in1, String in2) {
    if (_formKey.currentState.validate()) {
      DateTime now = new DateTime.now();
      FirebaseDatabase.instance.reference().child('Posts').push().set({
        'Title': in1,
        'Description': in2,
        'Name': '$professorname',
        'Time': "$now"
      }).whenComplete(() {
        Toast.Toast.show("that post added", context,
            duration: Toast.Toast.LENGTH_SHORT, gravity: Toast.Toast.BOTTOM);
        controllerPoststitle.text = '';
        controllerPostsdescription.text = '';
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
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: <
                    Widget>[
              Form(
                  key: _formKey,
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.4,
                    child: Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height / 60),
                          child: Text(
                            'DR:' + '$professorname',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height / 60),
                          child: TextFormField(
                            cursorColor: Colors.white,
                            keyboardType: TextInputType.text,
                            controller: controllerPoststitle,
                            textInputAction: TextInputAction.next,
                            focusNode: Poststitle,
                            onSaved: (input) => Poststitlesave = input,
                            onFieldSubmitted: (term) {
                              _fieldFocusChange(
                                  context, Poststitle, Postsdescription);
                            },
                            decoration: new InputDecoration(
                              labelStyle: TextStyle(color: Colors.grey),
                              labelText: "News Title",
                              hintText: "Enter News Title",
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter News Title';
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
                            controller: controllerPostsdescription,
                            textInputAction: TextInputAction.done,
                            focusNode: Postsdescription,
                            onSaved: (input) => Postsdescriptionsave = input,
                            onFieldSubmitted: (term) {
                              Postsdescription.unfocus();
                            },
                            decoration: new InputDecoration(
                              labelStyle: TextStyle(color: Colors.grey),
                              labelText: "News description",
                              hintText: "Enter News description",
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter News description';
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
                                  "Add Posts",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17),
                                ),
                              ),
                              onPressed: () {
                                submitnews(controllerPoststitle.text,
                                    controllerPostsdescription.text);
                              }),
                        ),
                      ],
                    ),
                  ))
            ]),
          ),
        ),
      ),
    );
  }
}
