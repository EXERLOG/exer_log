
class UserClass {
  String username;
  double weight;
  double height;
  String system;
  int age;
  String firstname;
  String lastname;
  String email;
  String userID;


  UserClass(this.username, this.height, this.weight, this.age, this.email, this.firstname, this.lastname, this.system, this.userID);

  Map<String, Object?> toJson() {
    return { 
      "username": username, 
      "weight": weight, 
      "height": height, 
      "age" : age,
      "firstname" : firstname,
      "lastname" : lastname,
      "email" : email,
      "system" : system,
      };
  }

  void setUserID(String id) {
    this.userID = id;
  }

UserClass.fromJson(Map<String, Object?> user) :
      this.username = user['username']! as String, 
      this.height = user['height']! as double, 
      this.weight = user['weight']! as double, 
      this.age = user['age']! as int, 
      this.email = user['email']! as String, 
      this.firstname = user['firstname']! as String, 
      this.lastname = user['lastname'] as String, 
      this.system = user['system']! as String,
      this.userID = user['userID']! as String;
}

