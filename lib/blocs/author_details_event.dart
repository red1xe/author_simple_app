part of 'author_details_bloc.dart';

abstract class AuthorDetailsEvent {}

class LoadAuthorWorks extends AuthorDetailsEvent {
  final String authorId;

  LoadAuthorWorks(this.authorId);
}
