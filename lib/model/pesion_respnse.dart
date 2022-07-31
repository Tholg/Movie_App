import 'package:movie_app/model/persion.dart';

class PersionResponse {
  final List<Person> persions;
  final String error;
  PersionResponse(this.persions, this.error);
  PersionResponse.fromJson(Map<String, dynamic> json)
      : persions = (json["results"] as List)
            .map((i) => new Person.fromJson(i))
            .toList(),
        error = "";
  PersionResponse.withError(String errorValue)
      : persions = [], // persions = List();
        error = errorValue;
}
