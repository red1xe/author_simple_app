part of 'author_details_bloc.dart';

abstract class AuthorDetailsState {}

class AuthorDetailsInitial extends AuthorDetailsState {}

class AuthorDetailsLoading extends AuthorDetailsState {}

class AuthorDetailsLoaded extends AuthorDetailsState {
  final Map<String, Work> works;

  AuthorDetailsLoaded(this.works);
}

class AuthorDetailsError extends AuthorDetailsState {
  final String error;

  AuthorDetailsError(this.error);
}
