part of 'author_search_bloc.dart';

abstract class AuthorSearchState extends Equatable {
  const AuthorSearchState();

  @override
  List<Object> get props => [];
}

class AuthorSearchInitial extends AuthorSearchState {}

class AuthorSearchLoading extends AuthorSearchState {}

class AuthorSearchLoaded extends AuthorSearchState {
  final List<Author> author;

  const AuthorSearchLoaded({required this.author});

  @override
  List<Object> get props => [author];
}

class AuthorSearchError extends AuthorSearchState {
  final String message;

  const AuthorSearchError({required this.message});

  @override
  List<Object> get props => [message];
}
