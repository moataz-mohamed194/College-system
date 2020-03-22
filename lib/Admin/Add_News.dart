import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:toast/toast.dart' as Toast;

class AddNews extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddNewspage();
  }
}

class AddNewspage extends State<AddNews> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode Newstitle = FocusNode();
  final FocusNode Newsdescription = FocusNode();
  final FocusNode Newsdetails = FocusNode();
  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  TextEditingController controllerNewstitle;
  TextEditingController controllerNewsdescription;
  TextEditingController controllerNewsdetails;
  void initState() {
    super.initState();
    controllerNewstitle = new TextEditingController();
    controllerNewsdescription = new TextEditingController();
    controllerNewsdetails = new TextEditingController();
  }

  String Newstitlesave, Newsdescriptionsave, Newsdetailssave;

//to send the news to databaseS
  submitnews(String in1, String in2, String in3) {
    if (_formKey.currentState.validate()) {
      DateTime now = new DateTime.now();
      FirebaseDatabase.instance.reference().child('News').push().set({
        'Title': in1,
        'Description': in2,
        'Details': in3,
        'Time': "$now"
      }).whenComplete(() {
        Toast.Toast.show("that news added", context,
            duration: Toast.Toast.LENGTH_SHORT, gravity: Toast.Toast.BOTTOM);

        controllerNewstitle.text = '';
        controllerNewsdescription.text = '';
        controllerNewsdetails.text = '';
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
                          margin: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height / 60),
                          child: TextFormField(
                            cursorColor: Colors.white,
                            keyboardType: TextInputType.text,
                            controller: controllerNewstitle,
                            textInputAction: TextInputAction.next,
                            focusNode: Newstitle,
                            onSaved: (input) => Newstitlesave = input,
                            onFieldSubmitted: (term) {
                              _fieldFocusChange(
                                  context, Newstitle, Newsdescription);
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
                            controller: controllerNewsdescription,
                            textInputAction: TextInputAction.next,
                            focusNode: Newsdescription,
                            onSaved: (input) => Newsdescriptionsave = input,
                            onFieldSubmitted: (term) {
                              _fieldFocusChange(
                                  context, Newsdescription, Newsdetails);
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
                        Container(
                          margin: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height / 60),
                          child: TextFormField(
                            cursorColor: Colors.white,
                            keyboardType: TextInputType.text,
                            controller: controllerNewsdetails,
                            textInputAction: TextInputAction.done,
                            focusNode: Newsdetails,
                            onSaved: (input) => Newsdetailssave = input,
                            onFieldSubmitted: (term) {
                              Newsdetails.unfocus();
                            },
                            decoration: new InputDecoration(
                              labelStyle: TextStyle(color: Colors.grey),
                              labelText: "News details (Optional)",
                              hintText: "Enter News details",
                            ),
                          ),
                        ),
                        Card(
                          color: Color(0xfff74883),
                          child: FlatButton(
                              child: Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  "Add News",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17),
                                ),
                              ),
                              onPressed: () {
                                submitnews(
                                    controllerNewstitle.text,
                                    controllerNewsdescription.text,
                                    controllerNewsdetails.text);
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
