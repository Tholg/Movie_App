import 'package:movie_app/model/pesion_respnse.dart';
import 'package:movie_app/repository/respository.dart';
import 'package:rxdart/rxdart.dart';

class PersonsListBloc {
  final MovieRepository _repository = MovieRepository();
  final BehaviorSubject<PersionResponse> _subject =
      BehaviorSubject<PersionResponse>();

  getPerson() async {
    PersionResponse response = await _repository.getPresons();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<PersionResponse> get subject => _subject;
}

final personsBloc = PersonsListBloc();
