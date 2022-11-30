import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:aplicativo_libras/pages/login.dart';
import 'package:aplicativo_libras/pages/signup.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../configuration.dart';

class FirstViewPage extends StatefulWidget {
  @override
  _FirstViewPageState createState() => _FirstViewPageState();
}

class _FirstViewPageState extends State<FirstViewPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Config.COR_SECUNDARIA,
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 40),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width*0.3,
                      child: Image.asset(
                          "assets/logo.png"
                      ),
                    ),
                    Text("Sinaliza",
                        style: GoogleFonts.poppins(
                          fontSize: 48, color: Colors.white, fontWeight: FontWeight.bold
                        )
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width*0.5,
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: GoogleFonts.poppins(fontSize: 14, color: Colors.white, height: 16/14,
                              fontWeight: FontWeight.w400, ),
                          children: const [
                            TextSpan(text: "Aprenda "),
                            TextSpan(text: "Libras", style: TextStyle(fontWeight: FontWeight.w600)),
                            TextSpan(text: " de forma rápida, divertida e eficaz."),
                          ]
                        ),
                      )
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            minimumSize: const Size(0,40),
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(context, createRoute(SignUpPage()));
                          },
                          child: Text("COMEÇAR", style: TextStyle(fontSize: 14, color: Config.COR_SECUNDARIA), )
                      )),
                    ],
                  ),
                  SizedBox(height: 16,),
                  Row(
                    children: [
                      Expanded(child: TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size(0,40),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            shape: RoundedRectangleBorder(

                                borderRadius: BorderRadius.circular(30)
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(context, createRoute(LoginPage()));
                          },
                          child: Text("JÁ TENHO UMA CONTA", style: const TextStyle(fontSize: 14, color: Colors.white) )
                      )),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      )

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
