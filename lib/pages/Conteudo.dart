import 'package:aplicativo_libras/services/learn_manager.dart';
import 'package:aplicativo_libras/services/user_manager.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import '../configuration.dart';

class ConteudoPage extends StatefulWidget {
  @override
  State<ConteudoPage> createState() => _ConteudoPageState();
}

class _ConteudoPageState extends State<ConteudoPage> {
  List videoPlayerController = [];

  @override
  void dispose() {
    videoPlayerController.forEach((element) {
      element.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        body: Consumer2<UserManager, LearnManager>(
          builder: (_, userManager, learnManager, __) {
            List conteudo = learnManager.unidadeAtual['conteudo'];

            videoPlayerController.forEach((element) {
              element.dispose();
            });
            videoPlayerController = [];

            return Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        Theme(
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
                                Navigator.pop(context);
                              },
                              label: Text("Voltar", style: const TextStyle(fontSize: 14, color: Config.COR_SECUNDARIA)
                              )
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.only(bottom: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset("assets/brasao.png"),
                            SizedBox(height: 16,),
                            ...conteudo.map((e) {
                              var controller = VideoPlayerController.network(e['video']);
                              videoPlayerController.add(controller);
                              var chewieController = ChewieController(
                                  videoPlayerController: controller,
                                  autoPlay: false,
                                  autoInitialize: true,
                                  looping: false,
                                  showControls: true,
                                  allowFullScreen: false,
                              );

                              return Container(
                                padding: EdgeInsets.only(bottom: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(e['titulo'], style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 20),),
                                    Text(e['conteudo'], style: GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 14),),
                                    SizedBox(height: 20,),
                                    AspectRatio(
                                      aspectRatio: controller.value.aspectRatio,
                                      child: Chewie(controller: chewieController)
                                    )
                                  ],
                                ),
                              );
                            })
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }
        )
      ),
    );
  }
}
