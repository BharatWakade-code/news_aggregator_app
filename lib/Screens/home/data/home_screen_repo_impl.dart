import 'package:either_dart/src/either.dart';
import 'package:news_aggregator_app/Services/common_services.dart';
import 'package:news_aggregator_app/models/NewsHeadLineCategoryResponseModel.dart';
import 'package:news_aggregator_app/models/news_response_model.dart';
import 'package:news_aggregator_app/utils/contstants.dart';

class HomeRepositoryImpl {
  Future<Either<Exception, NewsResponseModel>> getNewsHeadLineData(
      request) async {
    try {
      final response = await ApiService().getApi(Constanst.headLine, request);
      final responseData = NewsResponseModel.fromJson(response.data);
      return Right(responseData);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  Future<Either<Exception, NewsResponseModel>> getNewsMainData(request) async {
    try {
      final response = await ApiService().getApi(Constanst.everything, request);
      final responseData = NewsResponseModel.fromJson(response.data);
      return Right(responseData);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  Future<Either<Exception, NewsHeadLineCategoryResponseModel>>
      getNewsMainCategoryData(request) async {
    try {
      final response =
          await ApiService().getApi(Constanst.headLineCategory, request);
      final responseData =
          NewsHeadLineCategoryResponseModel.fromJson(response.data);
      return Right(responseData);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}
