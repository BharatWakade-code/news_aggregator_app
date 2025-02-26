part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class NewsDataSuccess extends HomeState {
  final String? msg;
  NewsDataSuccess({this.msg});
}

final class NewsDataError extends HomeState {
  final String? msg;
  NewsDataError({this.msg});
}