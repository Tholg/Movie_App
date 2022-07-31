import 'package:flutter/material.dart';
import 'package:movie_app/Widget/genres_movie.dart';
import 'package:movie_app/bloc/get_movies_byGenres_bloc.dart';
import 'package:movie_app/model/genre.dart';
import 'package:movie_app/style/theme.dart' as Style;

class GenresList extends StatefulWidget {
  final List<Genre> genres;
  const GenresList({required this.genres, super.key});

  @override
  State<GenresList> createState() => _GenresListState(genres);
}

class _GenresListState extends State<GenresList> with TickerProviderStateMixin {
  final List<Genre> genres;
  TabController? _tabController;
  _GenresListState(this.genres);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(
      vsync: this,
      length: genres.length,
    );
    _tabController!.addListener(() {
      if (_tabController!.indexIsChanging) {
        moviesByGenreBloc..drainStream();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 307.0,
      child: DefaultTabController(
          length: genres.length,
          child: Scaffold(
            backgroundColor: Style.Colors.mainColor,
            appBar: PreferredSize(
                child: AppBar(
                  backgroundColor: Style.Colors.mainColor,
                  bottom: TabBar(
                    controller: _tabController,
                    indicatorColor: Style.Colors.secondColor,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorWeight: 3.0,
                    unselectedLabelColor: Style.Colors.titleColor,
                    labelColor: Colors.white,
                    isScrollable: true,
                    tabs: genres.map((Genre genre) {
                      return Container(
                        padding: EdgeInsets.only(bottom: 15.0, top: 10.0),
                        child: Text(
                          genre.name.toUpperCase(),
                          style: TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.bold),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                preferredSize: Size.fromHeight(50.0)),
            body: TabBarView(
                controller: _tabController,
                physics: NeverScrollableScrollPhysics(),
                children: genres.map((Genre genre) {
                  return GenreMovie(genreID: genre.id);
                }).toList()),
          )),
    );
  }
}
