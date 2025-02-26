part of 'search_cubit.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}

final class SearchLoading extends SearchState {}

final class NewsDataSuccess extends SearchState {
  final String? msg;
  NewsDataSuccess({this.msg});
}

final class NewsDataError extends SearchState {
  final String? msg;
  NewsDataError({this.msg});
}
