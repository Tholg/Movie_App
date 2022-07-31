import 'package:flutter/material.dart';
import 'package:movie_app/Widget/genres_list.dart';
import 'package:movie_app/bloc/get_genre_bloc.dart';
import 'package:movie_app/model/genre_response.dart';

import '../model/genre.dart';

class GenresScreen extends StatefulWidget {
  const GenresScreen({super.key});

  @override
  State<GenresScreen> createState() => _GenresScreenState();
}

class _GenresScreenState extends State<GenresScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    genresBloc..getGenres();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<GenreResponse>(
        stream: genresBloc.subject.stream,
        builder: (context, AsyncSnapshot<GenreResponse> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.error != null &&
                snapshot.data!.error.length > 0) {
              return _buildErrorWidget(snapshot.data?.error as String);
            }
            return _buildGenresWidget(snapshot.data);
          } else if (snapshot.hasError) {
            return _buildErrorWidget(snapshot.error as String);
          } else {
            return _buildLoadingWidget();
          }
        });
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 25,
            width: 25,
            child: CircularProgressIndicator(),
          )
        ],
      ),
    );
  }

  Widget _buildErrorWidget(String error) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Text("Error occured: $error")]),
    );
  }

  Widget _buildGenresWidget(GenreResponse? data) {
    List<Genre> genres = data!.genres;
    if (genres.length == 0) {
      return Container(
        child: Text("no genre"),
      );
    } else
      return GenresList(genres: genres);
  }
}
