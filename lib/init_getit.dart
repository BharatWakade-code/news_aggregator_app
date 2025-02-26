import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:news_aggregator_app/init_getit.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() => getIt.init;
