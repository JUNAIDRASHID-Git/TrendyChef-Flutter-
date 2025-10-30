part of 'search_bloc.dart';

abstract class SearchEvent {}

class Searching extends SearchEvent {
  final String query;

  Searching(this.query);
}
