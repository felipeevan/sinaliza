import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore  firestore = FirebaseFirestore .instance;

  Future<User?> login(email, pass) async{
    return await _auth.signInWithEmailAndPassword(email: email, password: pass).then((value) async {
      return getUser();
    }).catchError((error) {
      throw error;
    });
  }

  Future<User?> cadastrar(email, pass) async{
    return await _auth.createUserWithEmailAndPassword(email: email, password: pass).then((value) async {
      return getUser();
    }).catchError((error) {
      throw error;
    });
  }

  Future<User?> getUser() async {
    return _auth.currentUser;
  }

  Future<DocumentSnapshot> getUserMap(uid) async {
    return await firestore.collection("users").doc(uid).get().then((value) {
       return value;
    });
  }

  Future<void> setUserValue(id, use, value) async {
    return await firestore.collection("users").doc(id).update({use: value});
  }

  Future<void> setUserValues(id, values) async {
    return await firestore.collection("users").doc(id).update(values);
  }

  Future<void> setUserMap(Map<String, dynamic> userData) async {
    var id  = userData['id'];
    userData.remove('id');
    return await firestore.collection("users").doc(id).set(userData);
  }
}