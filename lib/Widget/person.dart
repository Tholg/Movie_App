import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_app/bloc/get_person_bloc.dart';
import 'package:movie_app/model/pesion_respnse.dart';
import 'package:movie_app/style/theme.dart' as Style;
import 'package:movie_app/model/persion.dart';

class PersonList extends StatefulWidget {
  const PersonList({super.key});

  @override
  State<PersonList> createState() => _PersonListState();
}

class _PersonListState extends State<PersonList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    personsBloc..getPerson();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 10, top: 20),
          child: Text(
            "TRENDING PERSON ON THIS WEEK",
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
        StreamBuilder<PersionResponse>(
            stream: personsBloc.subject.stream,
            builder: (context, AsyncSnapshot<PersionResponse> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.error != null &&
                    snapshot.data!.error.length > 0) {
                  return _buildErrorWidget(snapshot.data?.error as String);
                }
                return _buildPersionWidget(snapshot.data);
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

  Widget _buildErrorWidget(String error) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Text("Error occured: $error")]),
    );
  }

  Widget _buildPersionWidget(PersionResponse? data) {
    List<Person>? persons = data!.persions;
    return Container(
      height: 130.0,
      padding: EdgeInsets.only(left: 10),
      child: ListView.builder(
        itemCount: persons.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (contex, index) {
          return Container(
            width: 100,
            padding: EdgeInsets.only(
              top: 10.0,
              right: 10.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                persons[index].profileImg == null
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
                              image: NetworkImage(
                                  "https://image.tmdb.org/t/p/w200" +
                                      persons[index].profileImg!),
                              fit: BoxFit.cover,
                            )),
                      ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  persons[index].name,
                  maxLines: 2,
                  style: TextStyle(
                    height: 1.4,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 9.0,
                  ),
                ),
                SizedBox(
                  height: 3.0,
                ),
                Text(
                  "Trending for ${persons[index].known}",
                  style: TextStyle(
                    color: Style.Colors.titleColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 7.0,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
