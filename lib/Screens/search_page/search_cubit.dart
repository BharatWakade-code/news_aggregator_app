import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:meta/meta.dart';
import 'package:news_aggregator_app/Screens/home/data/home_screen_repo_impl.dart';
import 'package:news_aggregator_app/models/news_request_model.dart';
import 'package:news_aggregator_app/models/news_response_model.dart';
import 'package:news_aggregator_app/utils/contstants.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  HomeRepositoryImpl repository = HomeRepositoryImpl();

  void searchQueryOnTap(String searchValue) {
    getNewsMainData(value: searchValue);
  }

  Future<void> getNewsMainData({String? value}) async {
    emit(SearchLoading());
    final json = NewsRequest(
      apiKey: Constanst.apiKey,
      // fromDate: "2025-01-26",
      // to: "2025-02-21",
      query: value ?? 'India',
      sortBy: 'publishedAt',
    );

    Either<Exception, NewsResponseModel> either =
        await repository.getNewsMainData(json.toJson());
    either.fold((failuire) => emit(NewsDataError(msg: 'News data fetch error')),
        (response) => newsMainResponse(response));
  }

  List<Articles>? mainArticles = [];

  void newsMainResponse(NewsResponseModel response) {
    if (response.status == "ok") {
      mainArticles = response.articles;
      emit(NewsDataSuccess(msg: 'News data fetch succesfully'));
    } else {
      emit(NewsDataError(msg: 'News data fetch error'));
    }
  }
}
