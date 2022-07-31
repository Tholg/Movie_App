import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayers extends StatefulWidget {
  final YoutubePlayerController controller;
  const VideoPlayers({super.key, required this.controller});

  @override
  State<VideoPlayers> createState() => _VideoPlayersState(controller);
}

class _VideoPlayersState extends State<VideoPlayers> {
  final YoutubePlayerController controller;
  _VideoPlayersState(this.controller);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          Center(
            child: YoutubePlayer(controller: controller),
          ),
          Positioned(
              top: 40.0,
              right: 20.0,
              child: IconButton(
                icon: Icon(EvaIcons.closeCircle),
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                },
              ))
        ],
      ),
    );
  }
}
