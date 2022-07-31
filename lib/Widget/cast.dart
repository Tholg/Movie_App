import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_app/bloc/get_cast_bloc.dart';
import 'package:movie_app/model/cast.dart';
import 'package:movie_app/model/cast_response.dart';
import 'package:movie_app/style/theme.dart' as Style;

class Casts extends StatefulWidget {
  final int id;
  const Casts({required this.id, super.key});

  @override
  State<Casts> createState() => _CastsState(id);
}

class _CastsState extends State<Casts> {
  final int id;
  _CastsState(this.id);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    castBloc..getCasts(id);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    castBloc..drainStream();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 10.0, top: 20.0),
          child: Text(
            "CASTS",
            style: TextStyle(
              color: Style.Colors.titleColor,
              fontWeight: FontWeight.w500,
              fontSize: 12.0,
            ),
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        StreamBuilder<CastResponse?>(
            stream: castBloc.subject.stream,
            builder: (context, AsyncSnapshot<CastResponse?> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.error != null &&
                    snapshot.data!.error.length > 0) {
                  return _buildErrorWidget(snapshot.data?.error as String);
                }
                return _buildCastsWidget(snapshot.data);
              } else if (snapshot.hasError) {
                return _buildErrorWidget(snapshot.error as String);
              } else {
                return _buildLoadingWidget();
              }
            })
      ],
    );
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

  Widget _buildErrorWidget(Object error) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Text("Error occured: $error")]),
    );
  }

  Widget _buildCastsWidget(CastResponse? data) {
    List<Cast>? casts = data!.casts;
    return Container(
      height: 150.0,
      padding: EdgeInsets.only(left: 10.0),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: casts.length,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.only(
                top: 10.0,
                right: 8.0,
              ),
              width: 100.0,
              child: GestureDetector(
                onTap: () {},
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    casts[index].img == null
                        ? Container(
                            width: 70.0,
                            height: 70.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Style.Colors.secondColor),
                            child: Icon(
                              FontAwesomeIcons.userAlt,
                              color: Colors.white,
                            ),
                          )
                        : Container(
                            width: 70.0,
                            height: 70.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        "https://image.tmdb.org/t/p/w300/" +
                                            casts[index].img))),
                          ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      casts[index].name,
                      maxLines: 2,
                      style: TextStyle(
                          height: 1.4,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 9.0),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      casts[index].character,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Style.Colors.titleColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 7.0),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
