import 'package:firebase_database/firebase_database.dart';

class News {
  String key;
  String title;
  String description;
  String details;

  News(this.title, this.description, this.details);

  News.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        title = snapshot.value["Title"],
        description = snapshot.value["Description"],
        details = snapshot.value["details"];
  News.map(dynamic obj) {
    this.title = obj['Title'];
    this.description = obj['Description'];
    this.details = obj['details'];
  }
  String get details1 => details;
  String get description1 => description;
  String get title1 => title;

  toJson() {
    return {
      "details": details,
      "Description": description,
      "Title": title,
    };
  }
}
