import 'package:flutter/material.dart';
import 'package:movie_app/Widget/genres.dart';
import 'package:movie_app/Widget/now_playing.dart';
import 'package:movie_app/Widget/person.dart';
import 'package:movie_app/Widget/top_movie.dart';
import 'package:movie_app/style/theme.dart' as Style;
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      backgroundColor: Style.Colors.mainColor,
      appBar: AppBar(
        backgroundColor: Style.Colors.mainColor,
        centerTitle: true,
        leading: Icon(
          EvaIcons.menu2Outline,
          color: Colors.white,
        ),
        title: Text("Movie App"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              EvaIcons.searchOutline,
              color: Colors.white,
            ),
            onPressed: null,
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          NowPlaying(),
          GenresScreen(),
          PersonList(),
          TopMovies(),
        ],
      ),
    );
  }
}
