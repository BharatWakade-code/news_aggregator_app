import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_aggregator_app/Screens/category/category_cubit.dart';
import 'package:news_aggregator_app/Screens/home/home_cubit.dart';
import 'package:news_aggregator_app/Screens/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CategoryCubit(),
        ),
        BlocProvider(
          create: (context) => HomeCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Insta Clone',
        home: HomeScreen(),
      ),
    );
  }
}
