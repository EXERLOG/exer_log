
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exerlog/Models/user.dart';
import 'package:exerlog/main.dart';
import 'package:firebase_auth/firebase_auth.dart';


final firestoreInstance = FirebaseFirestore.instance;

void createUser(UserClass user) {
  firestoreInstance.collection("users").add(
  {
    "username" : user.username,
    "firstname" : user.firstname,
    "lastname" : user.lastname,
    "age" : user.age,
    "email" : user.email,
    "height" : user.height,
    "weight" : user.weight,
    "system" : user.system,
  }).then((value){
    print(value.id);
    user.setUserID(value.id);
  });
}

void updateUser(UserClass user) {
  firestoreInstance.collection("users").withConverter<UserClass>(
    fromFirestore: (snapshot, _) => UserClass.fromJson(snapshot.data()!),
    toFirestore: (UserClass, _) => user.toJson(),
  );
}

Future<UserClass> getUser(String userID) async {
  var data;
  firestoreInstance.collection("users").doc(userID).get().then((value){
      data = value.data();
    }); 
  return UserClass.fromJson(data);
}
