import 'package:collage2/professor/mainforprofessor.dart';
import 'package:collage2/student/mainforstudent.dart';
import 'package:flutter/material.dart';
import 'Admin/mainforadmin.dart';
import 'login/choose_in_login.dart';
import 'login/pro_admin_login.dart';
import 'login/studentlogin.dart';

main() => runApp(hometime());

class hometime extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Collage',
      //search about it
//      theme: defaultTargetPlatform==TargetPlatform.android:kDefaultTheme,
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/mainforadmin': (BuildContext context) => new mainforadmin(),
        '/mainforstudent': (BuildContext context) => new mainforstudent(),
        '/LoginStudent': (BuildContext context) => new LoginStudent(),
        '/mainforprofessor': (BuildContext context) => new mainforprofessor(),
        '/Pro_admin_login': (BuildContext context) => new Pro_admin_login(),
      },
      home: Chooselogin(),
    );
  }
}
