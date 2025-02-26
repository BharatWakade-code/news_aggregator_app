import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:news_aggregator_app/Screens/home/data/home_screen_repo_impl.dart';
import 'package:news_aggregator_app/models/NewsHeadLineCategoryResponseModel.dart';
import 'package:news_aggregator_app/models/news_request_model.dart';
import 'package:news_aggregator_app/models/news_response_model.dart';
import 'package:news_aggregator_app/utils/contstants.dart';

part 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  HomeRepositoryImpl repository = HomeRepositoryImpl();

  Future<void> getNewsHeadLineData() async {
    emit(HomeLoading());
    final json = NewsRequest(
      apiKey: Constanst.apiKey,
      country: 'us',
      sortBy: 'publishedAt',
    );

    Either<Exception, NewsResponseModel> either =
        await repository.getNewsHeadLineData(json.toJson());
    either.fold((failuire) => emit(NewsDataError(msg: 'News data fetch error')),
        (response) => newsHeadLineResponse(response));
  }

  List<Articles>? articles = [];

  void newsHeadLineResponse(NewsResponseModel response) {
    if (response.status == "ok") {
      articles = response.articles;
      emit(NewsDataSuccess(msg: 'News data fetch succesfully'));
    } else {
      emit(NewsDataError(msg: 'News data fetch error'));
    }
  }

  Future<void> getNewsHeadLineCategoryData(String? catergory) async {
    emit(HomeLoading());
    final json = NewsRequest(
      apiKey: Constanst.apiKey,
      category: catergory,
    );

    Either<Exception, NewsHeadLineCategoryResponseModel> either =
        await repository.getNewsMainCategoryData(json.toJson());
    either.fold((failuire) => emit(NewsDataError(msg: 'News data fetch error')),
        (response) => newsMainCategoryResponse(response));
  }

  List<Sources>? sources = [];

  void newsMainCategoryResponse(NewsHeadLineCategoryResponseModel response) {
    if (response.status == "ok") {
      sources = response.sources;
      emit(NewsDataSuccess(msg: 'News data fetch succesfully'));
    } else {
      emit(NewsDataError(msg: 'News data fetch error'));
    }
  }
}
