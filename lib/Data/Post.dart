import 'package:firebase_database/firebase_database.dart';

class Post {
  String key;
  String title;
  String description;
  String name;

  Post(this.title, this.description, this.name);

  Post.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        title = snapshot.value["Title"],
        description = snapshot.value["Description"],
        name = snapshot.value["Name"];
  Post.map(dynamic obj) {
    this.title = obj['Title'];
    this.description = obj['Description'];
    this.name = obj['Name'];
  }
  String get name1 => name;
  String get description1 => description;
  String get title1 => title;

  toJson() {
    return {
      "Name": name,
      "Description": description,
      "Title": title,
    };
  }
}
