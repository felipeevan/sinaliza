import 'dart:math';

import 'package:aplicativo_libras/services/parametros_manager.dart';
import 'package:aplicativo_libras/services/user_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameService{
  passarFase(BuildContext context, idFase){
    var parametroManager = context.read<ParametroManager>();
    var userManager = context.read<UserManager>();
    var actualExp = userManager.userData['exp'];
    var proximoExp = actualExp + parametroManager.levelling?['exp'];
    var totalExp = userManager.userData['expTotal'] + parametroManager.levelling?['exp'];
    var level = userManager.userData['level'];

    var proximoLevelExp = parametroManager.levelling?['levelUpExpBase'] * ((parametroManager.levelling?['levelGrow']*(userManager.userData['level']-1))+1);
    if(proximoExp>=proximoLevelExp){
      level++;
      proximoExp -= proximoLevelExp;
    }
    List fasesConcluidas = List.from(userManager.userData['fasesConcluidas']);
    fasesConcluidas.add(idFase);

    userManager.saveSomeValues(
      {
        'level': level,
        'exp': proximoExp,
        'expTotal': totalExp,
        'fasesConcluidas': fasesConcluidas
      }
    );
  }

  lerFase(context){

  }

  novoUserMap(nome, email){
    return {
      "nome": nome,
      "email": email,
      "fasesConcluidas": [],
      "fasesFeitas": [],
      "fasesLidas": [],
      "pontos": {
        "chamas": 0,
        "medalhas": 0,
        "vidas": 10
      },
      "passouComeco": false,
      "exp": 0,
      "expTotal": 0,
      "level": 1,
    };
  }
}