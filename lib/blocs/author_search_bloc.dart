import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../views/models/author_model.dart';

part 'author_search_event.dart';
part 'author_search_state.dart';

class AuthorSearchBloc extends Bloc<AuthorSearchEvent, AuthorSearchState> {
  final Dio dio = Dio();

  AuthorSearchBloc() : super(AuthorSearchInitial()) {
    on<SearchAuthor>((event, emit) async {
      emit(AuthorSearchLoading());
      try {
        final author = await _fetchAuthor(event.query);
        emit(AuthorSearchLoaded(author: author));
      } catch (e) {
        emit(AuthorSearchError(message: e.toString()));
      }
    });
  }

  @override
  Stream<AuthorSearchState> mapEventToState(AuthorSearchEvent event) async* {
    if (event is SearchAuthor) {
      yield AuthorSearchLoading();
      try {
        final author = await _fetchAuthor(event.query);
        yield AuthorSearchLoaded(author: author);
      } catch (e) {
        yield AuthorSearchError(message: e.toString());
        print(e.toString());
      }
    }
  }

  Future<List<Author>> _fetchAuthor(String query) async {
    final response =
        await dio.get('https://openlibrary.org/search/authors.json?q=$query');
    if (response.statusCode == 200) {
      final data = response.data['docs'] as List<dynamic>;
      final List<Author> authors = [];
      for (var authorData in data) {
        authors.add(Author(
          id: authorData['key'] ?? 'N/A',
          name: authorData['name'] ?? 'N/A',
          birthDate: authorData['birth_date'] ?? 'N/A',
          deathDate: authorData['death_date'] ?? 'N/A',
          topWork: authorData['top_work'] ?? 'N/A',
        ));
      }
      return authors;
    } else {
      throw Exception('Failed to load authors');
    }
  }
}
