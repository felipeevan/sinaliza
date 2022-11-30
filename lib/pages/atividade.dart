import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../Widgets/appbar_game.dart';
import '../services/learn_manager.dart';
import '../services/user_manager.dart';

class Atividade extends StatefulWidget {

  @override
  State<Atividade> createState() => _AtividadeState();
}

class _AtividadeState extends State<Atividade> {
  final videoPlayerController = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4');

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      looping: true,
    );

    double width = MediaQuery
        .of(context)
        .size
        .width;

    return AppBarGame(child:
      Consumer2<UserManager, LearnManager>(
        builder: (_, userManager, learnManager, __){
          return Center(
              child: Chewie(controller: chewieController,),
          );
      })
    );

  }
}
