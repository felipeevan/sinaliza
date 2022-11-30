
import 'package:aplicativo_libras/Widgets/measure.dart';
import 'package:aplicativo_libras/configuration.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../services/user_manager.dart';

class AppBarGame extends StatefulWidget {
  final Widget child;
  const AppBarGame ({ required this.child });

  @override
  _AppBarGameState createState() => _AppBarGameState();
}

class _AppBarGameState extends State<AppBarGame> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int aberto = 0;
  List titulos = [
    "Chama do Saber",
    "Medalhas",
    "Vidas"
  ];

  @override
  Widget build(BuildContext context) {
    Widget containerGame(icon, numero, int){
      return GestureDetector(
        onTap: (){
          setState(() {
            aberto = aberto==int?0:int;
          });
        },
        child: Container(
          padding: EdgeInsets.all(5),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                      color: Color(0x40777777)
                  ),
                  BoxShadow(
                      color: Colors.white,
                      offset: aberto==int?Offset(1, 1):Offset(-1, -1),
                      blurRadius: 3,
                      spreadRadius: aberto==int?-3:0
                  )
                ]
            ),
            child: Row(
              children: [
                Image.asset("assets/"+icon+".png",width: 32,height: 32,),
                SizedBox(width: 10,),
                Text(numero.toString().length<2 ? "0" + numero.toString(): numero.toString()
                  , style: GoogleFonts.poppins(fontWeight: FontWeight.w800, fontSize: 16, height: 20/16),)
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
        key: _scaffoldKey,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<UserManager>(
              builder: (_, userManager, __) {
                return Container(
                  padding: EdgeInsets.only(bottom: 4),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(18.0),
                          bottomRight: Radius.circular(18.0),
                        ),
                        boxShadow: [
                          BoxShadow(color: Config.COR_PRIMARIA, spreadRadius: 1, offset: Offset(0, 3))
                        ]
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  containerGame("fogo", userManager.userData['pontos']['chamas'], 1),
                                  containerGame("medalha", userManager.userData['pontos']['medalhas'], 2),
                                  containerGame("coracao", userManager.userData['pontos']['vidas'], 3)
                                ],
                              ),),
                            IconButton(
                              icon:  Image.asset("assets/config.png",width: 32,height: 32,),
                              onPressed: () async {
                              },
                            )
                          ],
                        ),
                        aberto==0?Container():
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(titulos[aberto-1].toString(), style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 14),),
                              SizedBox(height: 5,),
                              Text("Lorem IPSUM Lorem IPSUM Lorem IPSUM Lorem IPSUM",
                                style: GoogleFonts.poppins(fontSize: 14),),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
            ),
            Expanded(child: widget.child)
          ],
        )
    );
  }
}
