//import 'package:collage2/login/sign_up.dart';
import 'package:collage2/login/pro_admin_login.dart';
import 'package:collage2/login/studentlogin.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:flutter_lottie/flutter_lottie.dart';

class Chooselogin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ChooseLoginPage();
  }
}

class ChooseLoginPage extends State<Chooselogin> {
  //when click on button professor or admin login go professor_admin_login page
  Future pAloginpage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //if admin or professor is loged in before and logout go to professor_admin_login
    if (prefs.getString('loginasadmin') == 'no' &&
        prefs.getString('loginasprofessor') == 'no') {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Pro_admin_login()));
    }
    //if admin login before go to admin page
    else if (prefs.getString('loginasadmin') == 'yes') {
      Navigator.of(context).pushNamedAndRemoveUntil(
          '/mainforadmin', (Route<dynamic> route) => false);
    }
    //if admin professor before go to professor page
    else if (prefs.getString('loginasprofessor') == 'yes') {
      Navigator.of(context).pushNamedAndRemoveUntil(
          '/mainforprofessor', (Route<dynamic> route) => false);
    }
    // if it's your first time to use app go to professor_admin_login
    else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Pro_admin_login()));
    }
  }

  //when click on button student login go student_login page
  Future studentloginpage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //if admin or professor is loged in before and logout go to professor_admin_login
    if (prefs.getString('loginasstudent') == 'no') {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginStudent()));
    }
    //if admin login before go to admin page
    else if (prefs.getString('loginasstudent') == 'yes') {
      Navigator.of(context).pushNamedAndRemoveUntil(
          '/mainforstudent', (Route<dynamic> route) => false);
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginStudent()));
    }
//    Navigator.push(
    //      context, MaterialPageRoute(builder: (context) => LoginStudent()));
  }

  LottieController controller2;
  StreamController<double> newProgressStream;

  ChooseLoginPage() {
    newProgressStream = new StreamController<double>();
  }
  void onViewCreatedFile(LottieController controller) {
    this.controller2 = controller;
    newProgressStream.stream.listen((double progress) {
      this.controller2.setAnimationProgress(progress);
    });
  }

  void dispose() {
    super.dispose();
    newProgressStream.close();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xff000000), Color(0xff254660)]),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
                flex: 2,
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 100),
                  child: LottieView.fromFile(
                    filePath: "image_gif/books_animi.json",
                    autoPlay: true,
                    loop: true,
                    reverse: true,
                    onViewCreated: onViewCreatedFile,
                  ),
                  //Image.asset("image_gif/3151-books.gif"),
                )),
            Expanded(
              flex: 1,
              child: Container(),
            ),
            Expanded(
                flex: 1,
                child: Container(
                    alignment: Alignment.center,
                    child: Column(
                      children: <Widget>[
                        Card(
                          color: Color(0xfff74883),
                          child: FlatButton(
                            child: Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Student",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
                              ),
                            ),
                            onPressed: studentloginpage,
                          ),
                        ),
                        Card(
                          color: Color(0xfff74883),
                          child: FlatButton(
                            child: Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Professor and admin",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
                              ),
                            ),
                            onPressed: pAloginpage,
                          ),
                        )
                      ],
                    )))
          ],
        ),
      )),
    );
  }
}
