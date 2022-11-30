import 'dart:ui';

import 'package:aplicativo_libras/configuration.dart';
import 'package:aplicativo_libras/pages/aprender.dart';
import 'package:aplicativo_libras/pages/home.dart';
import 'package:aplicativo_libras/pages/tabs.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../services/user_manager.dart';

class IntroducaoPage extends StatefulWidget {
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<IntroducaoPage> with SingleTickerProviderStateMixin{

  final pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        pageController.previousPage(duration: Duration(milliseconds: 400), curve: Curves.fastOutSlowIn);
        return Future.value(false);
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: <Widget>[
                page1(),
                page2(),
                page3(),
              ],
            ),
          ),
      ),
    );
  }

  Widget page1(){
    return Container(
      padding: EdgeInsets.all(30),
      width: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 20),
            child: Column(
              children: [
                Container(
                  child: Text("A aventura começa!",
                    style: GoogleFonts.poppins(
                      fontSize: 36, color: Config.COR_SECUNDARIA,  height: 38/36,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Image.asset("assets/intro1.png"),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text("Lorem ipsum dolor sit amet consectetur. Egestas habitant eu urna elementum phasellus. Faucibus consequat integer gravida eleifend ac hendrerit amet rhoncus nulla. Risus aliquet congue vel urna fames nisi odio vel. Semper placerat imperdiet tellus duis maecenas quam libero netus.",
                    style: GoogleFonts.poppins(
                      fontSize: 14, color: Config.COR_NEUTRA2,  height: 16/14,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(child: TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          minimumSize: const Size(0,40),
                          backgroundColor: Config.COR_SECUNDARIA,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)
                          ),
                        ),
                        onPressed: () {
                          pageController.nextPage(duration: Duration(milliseconds: 400), curve: Curves.fastOutSlowIn);
                        },
                        child: Text("PRÓXIMO", style: TextStyle(fontSize: 14, color: Colors.white), )
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
                          showPularDialog();
                        },
                        child: Text("PULAR INTRODUÇÃO", style: const TextStyle(fontSize: 14, color: Config.COR_SECUNDARIA) )
                    )),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget page2(){
    return voltarPage(
        Container(
          padding: EdgeInsets.all(30),
          width: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 20),
                child: Column(
                  children: [
                    Container(
                      child: Text("Aprenda e se divirta!",
                        style: GoogleFonts.poppins(
                          fontSize: 36, color: Config.COR_SECUNDARIA,  height: 38/36,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: Image.asset("assets/intro2.png"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Text("Lorem ipsum dolor sit amet consectetur. Egestas habitant eu urna elementum phasellus. Faucibus consequat integer gravida eleifend ac hendrerit amet rhoncus nulla. Risus aliquet congue vel urna fames nisi odio vel. Semper placerat imperdiet tellus duis maecenas quam libero netus.",
                        style: GoogleFonts.poppins(
                          fontSize: 14, color: Config.COR_NEUTRA2,  height: 16/14,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              minimumSize: const Size(0,40),
                              backgroundColor: Config.COR_SECUNDARIA,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)
                              ),
                            ),
                            onPressed: () {
                              pageController.nextPage(duration: Duration(milliseconds: 400), curve: Curves.fastOutSlowIn);
                            },
                            child: Text("PRÓXIMO", style: TextStyle(fontSize: 14, color: Colors.white), )
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
                              showPularDialog();
                            },
                            child: Text("PULAR INTRODUÇÃO", style: const TextStyle(fontSize: 14, color: Config.COR_SECUNDARIA) )
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

  Widget page3(){
    return voltarPage(
      Container(
        padding: EdgeInsets.all(30),
        width: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 20),
              child: Column(
                children: [
                  Container(
                    child: Text("Por um mundo mais acessível!",
                      style: GoogleFonts.poppins(
                        fontSize: 36, color: Config.COR_SECUNDARIA,  height: 38/36,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Image.asset("assets/intro3.png"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text("Lorem ipsum dolor sit amet consectetur. Egestas habitant eu urna elementum phasellus. Faucibus consequat integer gravida eleifend ac hendrerit amet rhoncus nulla. Risus aliquet congue vel urna fames nisi odio vel. Semper placerat imperdiet tellus duis maecenas quam libero netus.",
                      style: GoogleFonts.poppins(
                        fontSize: 14, color: Config.COR_NEUTRA2,  height: 16/14,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            minimumSize: const Size(0,40),
                            backgroundColor: Config.COR_SECUNDARIA,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)
                            ),
                          ),
                          onPressed: () {
                            salvarLeuComeco();
                          },
                          child: Text("COMEÇAR", style: TextStyle(fontSize: 14, color: Colors.white), )
                      )),
                    ],
                  ),
                  SizedBox(height: 56,),
                ],
              ),
            )
          ],
        ),
      )
    );
  }

  Widget voltarPage(Widget child){
    return Stack(
      children: [
        Positioned(
          top: 25,
          left: 25,
          child: Theme(
            data: ThemeData(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent
            ),
            child: TextButton.icon(
                icon: Icon(Icons.arrow_back_ios, color: Config.COR_SECUNDARIA),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.all(5),
                  minimumSize: Size(0,40),
                  splashFactory: NoSplash.splashFactory,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)
                  ),
                ),
                onPressed: () {
                  pageController.previousPage(duration: Duration(milliseconds: 400), curve: Curves.fastOutSlowIn);
                },
                label: Text("Voltar", style: const TextStyle(fontSize: 14, color: Config.COR_SECUNDARIA)
                )
            ),
          )
        ),
        child
      ],
    );
  }

  showPularDialog(){
    showGeneralDialog(
      barrierDismissible: false,
      barrierLabel: '',
      barrierColor: Colors.grey.withAlpha(200),
      transitionDuration: Duration(milliseconds: 200),
      pageBuilder: (ctx, anim1, anim2) {
        return Stack(
          alignment: Alignment.center,
          children: [
            AlertDialog(
              insetPadding: EdgeInsets.all(10),
              contentPadding: EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0))),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Aviso", style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600, fontSize: 20, letterSpacing: 0.01, color: Config.COR_SECUNDARIA
                  ),),
                  SizedBox(height: 20,),
                  Text("Você poderá rever a introdução em “História” no menu Configurações.", style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400, fontSize: 16, letterSpacing: 0.01, color: Config.COR_NEUTRA2
                  ),),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Expanded(child: TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            minimumSize: const Size(0,40),
                            backgroundColor: Config.COR_SECUNDARIA,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)
                            ),
                          ),
                          onPressed: () {
                            salvarLeuComeco();
                          },
                          child: Text("Pular introdução", style: TextStyle(fontSize: 14, color: Colors.white), )
                      )),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(child: TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size(0,40),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                                side: BorderSide(width: 2, color: Config.COR_SECUNDARIA)
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("Cancelar", style: const TextStyle(fontSize: 14, color: Config.COR_SECUNDARIA) )
                      ))
                    ],
                  )
                ],
              ),
              elevation: 5,
            ),
            Positioned(
              bottom: 30,
              child: Material(
                color: Colors.transparent,
                child: GestureDetector(
                  child: Icon(Icons.close, size: 40,),
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                ),
              )
            )
          ],
        );
      },
      transitionBuilder: (ctx, anim1, anim2, child){
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10 * anim1.value, sigmaY: 10 * anim1.value),
          child: FadeTransition(
            child: child,
            opacity: anim1,
          ),
        );
      },
      context: context,
    );
  }

  salvarLeuComeco(){
    showLoaderDialog(context);
    UserManager userManager = context.read<UserManager>();
    userManager.salvarPassouIntroducao(onSaved, onError);
  }

  showLoaderDialog(BuildContext context){
    AlertDialog alert=  AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Container(
        child: const Center(
          child: CircularProgressIndicator(color: Colors.white,),
        ),
      ),
    );
    showDialog(
      barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }

  onSaved(){
    Navigator.pop(context);
    Navigator.push(context, createRoute(Tabs()));
  }
  onError(error) {
    Navigator.pop(context);
    showDialog(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(error, style: GoogleFonts.poppins(fontSize: 20),),
        );
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