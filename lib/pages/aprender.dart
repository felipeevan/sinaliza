import 'package:aplicativo_libras/pages/Conteudo.dart';
import 'package:aplicativo_libras/services/learn_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:super_tooltip/super_tooltip.dart';

import '../Widgets/appbar_game.dart';
import '../configuration.dart';
import '../services/user_manager.dart';
import 'dart:math';

class AprenderPage extends StatefulWidget {
  @override
  _AprenderPageState createState() => _AprenderPageState();
}

class _AprenderPageState extends State<AprenderPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  List keys = [];
  GlobalKey keyContainer = GlobalKey();
  SuperTooltip? tooltip;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;

    return Container(
      key: keyContainer,
      child: AppBarGame(child:
      Consumer2<UserManager, LearnManager>(
          builder: (_, userManager, learnManager, __) {

            learnManager.unidades.forEach((element) {
              element['liçoes'].forEach((el) {
                keys.add({
                  'codigo': el['codigo'],
                  'key' : new GlobalKey()
                });
              });
            });

            //Lista de Lições
            List fasesConcluidasPeloUser = [];
            if(userManager.userData['fasesConcluidas']!=null){
              fasesConcluidasPeloUser = userManager.userData['fasesConcluidas'];
            }
            fasesConcluidasPeloUser.sort();

            int ultimaFase = fasesConcluidasPeloUser.length>0?fasesConcluidasPeloUser[fasesConcluidasPeloUser.length-1]:0;

            Column listOfLicoes(licoes){
              List<dynamic> licoesMapped = [];

              for(int i = 0; i<licoes.length; i++){
                if(i==0){
                  licoesMapped.add({licoes[i]});
                }else{
                  if(i+1<licoes.length){
                    licoesMapped.add({licoes[i], licoes[i+1]});
                    i++;
                  }else {
                    licoesMapped.add({licoes[i]});
                  }
                }
              }

              return Column(
                children: [
                  ...licoesMapped.map((f) {
                    List listInRow = f.toList();
                    return Container(
                      padding: EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ...listInRow.map((e) {
                            bool faseConcluida = fasesConcluidasPeloUser.contains(e['codigo']);
                            bool faseDisponivel = e['codigo']<=(ultimaFase+1);

                            int key = keys.indexWhere((element) {
                              return element['codigo'] == e['codigo'];
                            });

                            return GestureDetector(
                              key: keys[key]['key'],
                              onTap: !faseDisponivel?null:(){
                                onTap(keys[key]['key'], e, userManager.userData, learnManager);
                              },
                              child: Column(
                                children: [
                                  Container(
                                    width: width*0.25,
                                    height: width*0.30,
                                    decoration: BoxDecoration(
                                        color: faseDisponivel?Config.COR_PRIMARIA_SHADOW:Config.COR_BORDA,
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(color: faseConcluida?
                                          Config.COR_ALTERNATIVA_AMARELA:
                                          Config.COR_BORDA, spreadRadius:
                                          10, offset: Offset(0, 0)),
                                          BoxShadow(color: Colors.white, spreadRadius:
                                          5, offset: Offset(0, 0)),
                                        ]
                                    ),
                                    child: Center(
                                      child: SvgPicture.network(
                                        e['icon'],
                                        width: width*0.12,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 12,),
                                  Text(e['titulo'], style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 14, height: 1, color: Config.COR_PRIMARIA_ESCURA),)
                                ],
                              ),
                            );
                          })
                        ],
                      ),
                    );
                  })
                ],
              );
            }

            //Lista de Unidades
            List<Widget> listOfUnidades(){
              List<Widget> unidades = [];
              unidades = learnManager.unidades.map((e) {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Unidade " + e['codigo'].toString() + " - " + e['titulo'],
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 20, height: 1, color: Config.COR_PRIMARIA_ESCURA),),
                      SizedBox(height: 5,),
                      Text(e['descricao'],
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 14, color: Config.COR_NEUTRA),),
                      listOfLicoes(e['liçoes']),
                    ],
                  ),
                );
              }).toList();
              return unidades;
            }

            return Container(
              height: 100,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Image.asset("assets/brasao.png"),
                            ...listOfUnidades()
                          ],
                        )
                    )
                  ],
                ),
              ),
            );
          }
      )),
    );
  }

  void onTap(key, e, userData, LearnManager learnManager) {
    List fasesLidas = userData['fasesLidas'];
    List fasesDesteModulo = fasesLidas.where((element) {
      String fase = element;
      return fase.split("-")[0]==e['codigo'];
    }).toList();
    fasesDesteModulo.sort();
    int actualFase = fasesDesteModulo.length>0?fasesDesteModulo[fasesDesteModulo.length-1].split('-')[1]:1;


    AlertDialog alert=  AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Config.COR_SECUNDARIA,
          borderRadius: BorderRadius.circular(15)
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(e['titulo'], style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),),
            Text("Parte 0" + actualFase.toString() + " de 0" + e['unidades'].length.toString(), style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 14),),
            SizedBox(height: 10,),
            Row(
              children: [
                Expanded(child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Config.COR_ALTERNATIVA_VERDE,
                      padding: EdgeInsets.zero,
                      minimumSize: Size(0,40),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)
                      ),
                    ),
                    onPressed: () {
                      learnManager.setUnidadeAtual(e['unidades'][actualFase-1], e['codigo'].toString() + "-" + actualFase.toString()).then((value){
                        Navigator.pop(context);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ConteudoPage()));
                      });
                    },
                    child: Text("Ir para o conteúdo", style: const TextStyle(fontSize: 14, color: Colors.white) )
                )),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Expanded(child: TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size(0,40),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                          side: BorderSide(width: 2, color: Colors.white),
                          borderRadius: BorderRadius.circular(30)
                      ),
                    ),
                    onPressed: () {
                    },
                    child: Text("Ir para o conteúdo", style: const TextStyle(fontSize: 14, color: Colors.white) )
                )),
              ],
            ),
          ],
        ),
      )
    );
    showDialog(
      barrierDismissible: true,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }

  Route createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset(0.0, 0.0);
        const curve = Curves.easeInQuad;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

}