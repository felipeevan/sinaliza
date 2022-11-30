import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ParametroManager extends ChangeNotifier {

  ParametroManager(){
    _loadParametros();
  }

  Map<String, dynamic>? levelling = {};
  final FirebaseFirestore firestore = FirebaseFirestore .instance;

  Future<void> _loadParametros() async {
    await firestore.collection('parametros').doc("levelling").snapshots().listen((event) {
      levelling = event.data();
      notifyListeners();
    });
  }
}