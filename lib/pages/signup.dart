import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:aplicativo_libras/pages/introducao.dart';
import 'package:aplicativo_libras/pages/tabs.dart';
import 'package:aplicativo_libras/services/auth_service.dart';
import 'package:aplicativo_libras/services/game_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../configuration.dart';
import '../services/user_manager.dart';


class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var nomeController = TextEditingController();
  var emailController = TextEditingController();
  var senhaController = TextEditingController();
  var senhaConfirmaController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;

    return Consumer<UserManager>(
        builder: (_, userManager, __){
          return Scaffold(
              key: _scaffoldKey,
              backgroundColor: Config.COR_SECUNDARIA,
              body: Center(
                child: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: [
                        Expanded(
                          child: Center(
                            child: SingleChildScrollView(
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
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(28),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text("Cadastrar",
                                    style: GoogleFonts.poppins(
                                      fontSize: 36, color: Config.COR_SECUNDARIA,  height: 38/36,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text("Digite suas informações abaixo",
                                      style: GoogleFonts.poppins(
                                          fontSize: 14, color: Config.COR_SECUNDARIA, fontWeight: FontWeight.w400, letterSpacing: 0.01
                                      )
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                      controller: nomeController,
                                      style: TextStyle(fontSize: 18, color: Colors.black),
                                      keyboardType: TextInputType.text,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Preencha corretamente o nome';
                                        }
                                        return null;
                                      },
                                      decoration: decoration("Nome")
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  TextFormField(
                                      controller: emailController,
                                      style: TextStyle(fontSize: 18, color: Colors.black),
                                      keyboardType: TextInputType.text,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Preencha corretamente o email';
                                        }
                                        return null;
                                      },
                                      decoration: decoration("Email")
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  TextFormField(
                                      controller: senhaController,
                                      style: TextStyle(fontSize: 18, color: Colors.black),
                                      keyboardType: TextInputType.text,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Preencha corretamente a senha';
                                        }
                                        return null;
                                      },
                                      decoration: decoration("Senha")
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  TextFormField(
                                      controller: senhaConfirmaController,
                                      style: TextStyle(fontSize: 18, color: Colors.black),
                                      keyboardType: TextInputType.text,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Preencha corretamente a confirmação de senha';
                                        }
                                        if (value!=senhaController.text) {
                                          return 'Senhas não coincidem';
                                        }
                                        return null;
                                      },
                                      decoration: decoration("Confirme a Senha")
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
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
                                            if(_formKey.currentState!.validate()){
                                              showLoaderDialog(context);

                                              Map<String, dynamic> userData = GameService().novoUserMap(nomeController.text, emailController.text);
                                              userManager.signUp(userData, senhaController.text, onSucess, onError);
                                            }
                                          },
                                          child: Text("CADASTRAR", style: TextStyle(fontSize: 14, color: Colors.white), )
                                      )),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ),
                ),
              )
          );

        }
    );
  }

  InputDecoration decoration(label){
    Color cor = Colors.grey;

    return InputDecoration(
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
                color: cor,
                width: 2
            )
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
                color: cor,
                width: 2
            )
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
                color: cor,
                width: 2
            )
        ),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
                color: cor,
                width: 2
            )
        ),
        focusedErrorBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
                color: cor,
                width: 2
            )
        ),
        labelText: label,
        labelStyle: TextStyle(fontSize: 16, color: cor),
        errorStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.red)
    );
  }
  onSucess(){
    Navigator.pop(context);
    Navigator.push(context, createRoute(IntroducaoPage()));
  }
  onError(error) {
    Navigator.pop(context);
    showDialog<void>(
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
}