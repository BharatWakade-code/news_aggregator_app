import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_aggregator_app/Screens/home/home_cubit.dart';
import 'package:news_aggregator_app/utils/common_loader.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    final cubit = context.read<HomeCubit>();
    cubit.getNewsData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    return Scaffold(
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          print('state is $state');
        },
        builder: (context, state) {
          if (state is HomeLoading) {
            return const CommonLoader();
          }
          return Center(
            child: Text('${cubit.articles?.length.toString()}'),
          );
        },
      ),
    );
  }
}
