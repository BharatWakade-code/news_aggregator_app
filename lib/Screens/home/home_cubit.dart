import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:news_aggregator_app/Screens/home/data/home_screen_repo_impl.dart';
import 'package:news_aggregator_app/models/news_request_model.dart';
import 'package:news_aggregator_app/models/news_response_model.dart';
import 'package:news_aggregator_app/utils/contstants.dart';

part 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  HomeRepositoryImpl repository = HomeRepositoryImpl();

  Future<void> getNewsData() async {
    emit(HomeLoading());
    final json = NewsRequest(
      apiKey: Constanst.apiKey,
      fromDate: "2025-01-26",
      to: "2025-02-21",
      query: "india",
      sortBy: 'publishedAt',
    );

    Either<Exception, NewsResponseModel> either =
        await repository.getNewsData(json.toJson());
    either.fold((failuire) => emit(NewsDataError(msg: 'News data fetch error')),
        (response) => newsResponse(response));
  }

  List<Articles>? articles = [];

  void newsResponse(NewsResponseModel response) {
    if (response.status == "ok") {
      articles = response.articles;
      emit(NewsDataSuccess(msg: 'News data fetch succesfully'));
    } else {
      emit(NewsDataError(msg: 'News data fetch error'));
    }
  }
}
