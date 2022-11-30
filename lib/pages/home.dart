import 'package:aplicativo_libras/configuration.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../Widgets/appbar_game.dart';
import '../services/user_manager.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;

    return Consumer<UserManager>(
        builder: (_, userManager, __) {
          return Container(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Olá, " + userManager.userData['nome'], style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 20, color: Config.COR_PRIMARIA_ESCURA),),
                  Row(
                    children: [
                      Expanded(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: const [
                              BoxShadow(color: Config.COR_PRIMARIA_SHADOW, spreadRadius: 0, offset: Offset(0, 3))
                            ]
                          ),
                          child: TextButton(
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                minimumSize: const Size(0,40),
                                backgroundColor: Config.COR_PRIMARIA,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              onPressed: () {
                              },
                              child: const Text("JOGAR", style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w700, letterSpacing: 1.01), )
                          ),
                        )
                      )
                    ],
                  )
                ],
              ),
            )
          );
        }
    );
  }
}