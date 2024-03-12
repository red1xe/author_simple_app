part of 'author_search_bloc.dart';

abstract class AuthorSearchEvent extends Equatable {
  const AuthorSearchEvent();

  @override
  List<Object> get props => [];
}

class SearchAuthor extends AuthorSearchEvent {
  final String query;

  const SearchAuthor({required this.query});

  @override
  List<Object> get props => [query];
}
