import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exerlog/Models/user.dart';

final firestoreInstance = FirebaseFirestore.instance;

void createUser(UserClass user, String id) {
  firestoreInstance.collection('users').doc(id).set({
    'username': user.username,
    'firstname': user.firstname,
    'lastname': user.lastname,
    'age': user.age,
    'email': user.email,
    'height': user.height,
    'weight': user.weight,
  });
}

void updateUser(UserClass user) {
  firestoreInstance.collection('users').withConverter<UserClass>(
        fromFirestore: (snapshot, _) => UserClass.fromJson(snapshot.data()!),
        toFirestore: (UserClass, _) => user.toJson(),
      );
}

Future<UserClass> getUser(String userID) async {
  var data;
  firestoreInstance.collection('users').doc(userID).get().then((value) {
    data = value.data();
  });
  return UserClass.fromJson(data);
}
