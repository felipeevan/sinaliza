import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:aplicativo_libras/pages/first_view.dart';
import 'package:aplicativo_libras/pages/introducao.dart';
import 'package:aplicativo_libras/pages/tabs.dart';
import 'package:aplicativo_libras/services/user_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'configuration.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: const MediaQueryData(),
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Consumer<UserManager>(
                builder: (_, userManager, __){
                  Widget getPagina() {
                    if(userManager.isLoggedIn()){
                      if(userManager.userData.length!=0){
                        if(userManager.userData['passouComeco']!=null && userManager.userData['passouComeco']){
                          return Tabs();
                        }else{
                          return IntroducaoPage();
                        }
                      }else{
                        return Tabs();
                      }
                    }
                    return FirstViewPage();
                  }
                  return AnimatedSplashScreen(
                      duration: 1000,
                      splash: null,
                      nextScreen: getPagina(),
                      splashTransition: SplashTransition.scaleTransition,
                      pageTransitionType: PageTransitionType.bottomToTop,
                      backgroundColor: Config.COR_SECUNDARIA
                  );
                }
            ),
            Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/logo.png"),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16,),
                    Text("Sinaliza", style: GoogleFonts.poppins(
                        fontSize: 48, color: Colors.white, fontWeight: FontWeight.w700, letterSpacing: 0.01, height: 60/48
                    ), textHeightBehavior: const TextHeightBehavior(
                      applyHeightToFirstAscent: false,
                      applyHeightToLastDescent: true,

                    ),
                    )
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}
