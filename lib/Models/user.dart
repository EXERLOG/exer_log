import 'package:cloud_firestore/cloud_firestore.dart';

class UserClass {

  UserClass(this.username, this.height, this.weight, this.age, this.email,
      this.firstname, this.lastname, this.system, this.userID,);

  UserClass.fromJson(Map<String, Object?> user)
      : username = user['username']! as String,
        height = user['height']! as double,
        weight = user['weight']! as double,
        age = user['age']! as int,
        email = user['email']! as String,
        firstname = user['firstname']! as String,
        lastname = user['lastname'] as String,
        system = user['system']! as String,
        userID = user['userID']! as String;
  String username;
  double weight;
  double height;
  String system;
  int age;
  String firstname;
  String lastname;
  String email;
  String userID;

  Map<String, Object?> toJson() {

    return <String, dynamic> {
      'username': username,
      'weight': weight,
      'height': height,
      'age': age,
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'system': system,
      'joined': FieldValue.serverTimestamp()
    };
  }

  void setUserID(String id) {
    userID = id;
  }
}
