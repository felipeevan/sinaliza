import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';


class LearnManager extends ChangeNotifier {

  LearnManager(){
    _loadParametros();
  }

  List<dynamic> unidades = [];

  Map<String, dynamic> unidadeAtual = new Map();
  String actualPage = "";

  final FirebaseFirestore firestore = FirebaseFirestore .instance;

  Future<void> _loadParametros() async {
    await firestore.collection('unidades').snapshots().listen((event) {
      unidades = event.docs.map((event){
        return  event.data();
      }).toList();
      notifyListeners();
    });
  }

  Future<void> setUnidadeAtual(doc, codigo) async{
    await firestore.collection('licoes').doc(doc).get().then((event) {
      Map<String, dynamic> map = event.data() as Map<String, dynamic>;
      this.unidadeAtual = map;
      this.actualPage = codigo;
      print(actualPage);
      notifyListeners();
    });
  }
}