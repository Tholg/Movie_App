import 'package:movie_app/model/genre.dart';

class MovieDetail {
  final int? id;
  final bool? adult;
  final int? budget;
  final List<Genre>? genre;
  final String releaseDate;
  final int? runtime;

  MovieDetail(
    this.id,
    this.adult,
    this.budget,
    this.genre,
    this.releaseDate,
    this.runtime,
  );

  MovieDetail.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        adult = json["adult"],
        budget = json["budget"],
        genre = (json["genres"] as List).map((i) => Genre.fromJson(i)).toList(),
        releaseDate = json["release_date"],
        runtime = json["runtime"];
}
