import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'auth_service.dart';

class UserManager extends ChangeNotifier {

  UserManager(){
    _loadCurrentUser();
  }

  bool loaded = false;
  bool isLoading = false;

  Map<String, dynamic> userData = Map();
  User? firebaseUser;

  Future<void> signUp(Map<String, dynamic> userData, String pass, onSucess, onError)  async {
    isLoading = true;
    notifyListeners();
    await AuthService().cadastrar(userData['email'], pass).then((result) async {
      firebaseUser = result;
      userData['id'] = firebaseUser?.uid;
      await _saveUserData(userData);
      await _loadCurrentUser();
      onSucess();
      notifyListeners();
    }).catchError((e){
      onError();
      isLoading = false;
      notifyListeners();
    }
    );
  }

  Future<void> salvarPassouIntroducao(onSaved, onError) async {
    isLoading = true;
    notifyListeners();
    userData['passouComeco'] = true;
    await AuthService().setUserValue(userData['id'], "passouComeco", true).then((value) {
      isLoading = false;
      notifyListeners();
      onSaved();
    }).catchError((error){
      isLoading = false;
      notifyListeners();
      onError("Erro ao salvar.");
    });
  }

  Future<Null> saveSomeValues(Map<String, dynamic> values) async{
    await AuthService().setUserValues(userData['id'], values);
    await this.reloadUserData();
  }

  Future<void> reloadUserData() async {
    await AuthService().getUserMap(firebaseUser?.uid).then((value){
      if(value.exists){
        Map<String, dynamic> map = value.data() as Map<String, dynamic>;
        userData = map;
        this.userData['id'] = value.id;
        notifyListeners();
      }
    });
  }

  Future<Null> _saveUserData(Map<String, dynamic> userData) async{
    this.userData = userData;
    await AuthService().setUserMap(this.userData);
    notifyListeners();
  }

  Future<Null> login(email, pass, onSucess, onError) async {
    isLoading = true;
    notifyListeners();
    await AuthService().login(email, pass).then((result) async {
      firebaseUser = result;
      isLoading = false;
      await this._loadCurrentUser();
      onSucess(userData);
    }).catchError((error){
      isLoading = false;
      notifyListeners();
      print(error.code);
      switch (error.code) {
        case 'invalid-email':
          onError('Seu e-mail é inválido.');
          break;
        case 'invalid-password':
          onError('Sua senha é inválida.');
          break;
        case 'ERROR_WRONG_PASSWORD':
          onError('Sua senha está incorreta.');
          break;
        case 'user-not-found':
          onError('Não há usuário com este e-mail.');
          break;
        case 'operation-not-allowed':
          onError('Operação não permitida.');
          break;
        case 'wrong-password':
          onError("Senha incorreta");
          break;
        default:
          onError('Um erro indefinido ocorreu.');
      }
    });
  }

  bool isLoggedIn(){
    return firebaseUser!=null;
  }

  User? returnUser(){
    return firebaseUser;
  }

  Future<Null> _loadCurrentUser() async {
    if (firebaseUser == null) {
      firebaseUser = await AuthService().getUser();
      notifyListeners();
    }
    if (firebaseUser != null) {
      firebaseUser = await AuthService().getUser();
      await AuthService().getUserMap(firebaseUser?.uid).then((value){
        if(value.exists){
          Map<String, dynamic> map = value.data() as Map<String, dynamic>;
          userData = map;
          this.userData['id'] = value.id;
          notifyListeners();
        }
      });
    }
  }
}