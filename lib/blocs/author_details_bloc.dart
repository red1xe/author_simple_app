import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import '../views/models/author_model.dart';

part 'author_details_event.dart';
part 'author_details_state.dart';

class AuthorDetailsBloc extends Bloc<AuthorDetailsEvent, AuthorDetailsState> {
  final Dio dio;

  AuthorDetailsBloc({required this.dio}) : super(AuthorDetailsInitial()) {
    on<LoadAuthorWorks>((event, emit) async {
      emit(AuthorDetailsLoading());
      try {
        final works = await fetchWorks(event.authorId);
        emit(AuthorDetailsLoaded(works));
      } catch (e) {
        emit(AuthorDetailsError('Failed to load works ' + e.toString()));
      }
    });
  }

  @override
  Stream<AuthorDetailsState> mapEventToState(AuthorDetailsEvent event) async* {
    if (event is LoadAuthorWorks) {
      yield AuthorDetailsLoading();
      try {
        final works = await fetchWorks(event.authorId);
        yield AuthorDetailsLoaded(works);
      } catch (e) {
        yield AuthorDetailsError('Failed to load works');
      }
    }
  }

  Future<Map<String, Work>> fetchWorks(String authorKey) async {
    final response =
        await dio.get('https://openlibrary.org/authors/$authorKey/works.json');
    if (response.statusCode == 200) {
      final data = response.data['entries'] as List<dynamic>;
      final Map<String, Work> works = {};
      for (var workData in data) {
        works[workData['title'] ?? 'Unknown'] = Work(
          title: workData['title'] ?? 'Unknown',
        );
      }
      return works;
    } else {
      throw Exception('Failed to load works');
    }
  }
}
