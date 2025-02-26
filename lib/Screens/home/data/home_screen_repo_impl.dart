import 'package:either_dart/src/either.dart';
import 'package:news_aggregator_app/Services/common_services.dart';
import 'package:news_aggregator_app/models/news_response_model.dart';
import 'package:news_aggregator_app/utils/contstants.dart';

class HomeRepositoryImpl {
  Future<Either<Exception, NewsResponseModel>> getNewsData(request) async {
    try {
      final response = await ApiService().getApi(Constanst.everything,  request);
      final responseData = NewsResponseModel.fromJson(response.data);
      return Right(responseData);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}
