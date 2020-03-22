import 'package:firebase_database/firebase_database.dart';

class Student {
  String key;
  String id;
  String seatnumber;
  String address;
  String highschool;
  String degree;
  String name;
  String phonenumber;

  Student(this.id, this.seatnumber, this.address, this.highschool, this.name,
      this.phonenumber, this.degree);

  Student.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        id = snapshot.value["ID"],
        seatnumber = snapshot.value["seatnumber"],
        address = snapshot.value["address"],
        highschool = snapshot.value["high school"],
        name = snapshot.value["name"],
        degree = snapshot.value["degree"],
        phonenumber = snapshot.value["phonenumber"];
  Student.map(dynamic obj) {
    this.degree = obj['Student'];
    this.highschool = obj['high school'];
    this.id = obj['ID'];
    this.address = obj['address'];
    this.name = obj['name'];
    this.seatnumber = obj['seatnumber'];
    this.phonenumber = obj['phonenumber'];
  }
  String get id1 => highschool;
  String get degree1 => degree;
  String get highschool1 => highschool;
  String get address1 => address;
  String get name1 => name;
  String get seatnumber1 => seatnumber;
  String get phonenumber1 => phonenumber;

  toJson() {
    return {
      "ID": id,
      "seatnumber": seatnumber,
      "address": address,
      "degree": degree,
      "name": name,
      "phonenumber": phonenumber,
      "high school": highschool,
    };
  }
}
