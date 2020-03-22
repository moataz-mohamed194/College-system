import 'package:firebase_database/firebase_database.dart';

class Department {
  String key;
  String capacity;
  String description;
  String min_degree;
  String name;

  Department(this.capacity, this.description, this.min_degree, this.name);

  Department.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        capacity = snapshot.value["Capacity"],
        description = snapshot.value["Description"],
        min_degree = snapshot.value["Min Degree"],
        name = snapshot.value["Name"];
  Department.map(dynamic obj) {
    this.capacity = obj['Capacity'];
    this.description = obj['Description'];
    this.min_degree = obj['Min Degree'];
    this.name = obj['Name'];
  }
  String get name1 => name;
  String get min_degree1 => min_degree;
  String get description1 => description;
  String get capacity1 => capacity;

  toJson() {
    return {
      "Name": name,
      "Description": description,
      "Min degree": min_degree,
      "Capacity": capacity,
    };
  }
}
