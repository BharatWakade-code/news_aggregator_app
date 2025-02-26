import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_aggregator_app/Screens/home/home_cubit.dart';
import 'package:news_aggregator_app/utils/common_loader.dart';
import 'package:news_aggregator_app/utils/contstants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<String> tabTitile = [
    'business',
    'entertainment',
    'sports',
    'technology'
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabTitile.length, vsync: this);
    _tabController.addListener(handleOnTabChange);
    final cubit = context.read<HomeCubit>();
    cubit.getNewsHeadLineData();
    cubit.getNewsHeadLineCategoryData(tabTitile[_tabController.index]);
  }

  void handleOnTabChange() {
    final cubit = context.read<HomeCubit>();
    cubit.getNewsHeadLineCategoryData(tabTitile[_tabController.index]);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          print('state is $state');
        },
        builder: (context, state) {
          if (state is HomeLoading) {
            return const CommonLoader();
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  'Headlines',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                height: 300,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: cubit.articles?.length ?? 0,
                  itemBuilder: (context, index) {
                    final article = cubit.articles?[index];
                    return Container(
                      width: 250,
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(15),
                            ),
                            child: Image.network(
                              article?.urlToImage ?? '',
                              height: 150,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  height: 150,
                                  width: double.infinity,
                                  color: Colors.grey[300],
                                  child: const Icon(Icons.broken_image,
                                      color: Colors.grey),
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  article?.title ?? '',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  article?.publishedAt ?? '',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  article?.author ?? '',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  dividerColor: Colors.transparent,
                  tabs: const [
                    Tab(
                      text: 'business',
                    ),
                    Tab(
                      text: 'entertainment',
                    ),
                    Tab(
                      text: 'sports',
                    ),
                    Tab(
                      text: 'technology',
                    )
                  ],
                  tabAlignment: TabAlignment.start,
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.grey[200],
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      tabCategoryMethod(cubit),
                      tabCategoryMethod(cubit),
                      tabCategoryMethod(cubit),
                      tabCategoryMethod(cubit),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  ListView tabCategoryMethod(HomeCubit cubit) {
    return ListView.builder(
      itemCount: cubit.sources?.length ?? 0,
      itemBuilder: (context, index) => Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cubit.sources?[index].name ?? '',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                cubit.sources?[index].description ?? '',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.language, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    cubit.sources?[index].language ?? '',
                  ),
                  const SizedBox(width: 10),
                  const Icon(Icons.flag, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    cubit.sources?[index].country ?? '',
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  launchWebsiteUrl(
                    cubit.sources?[index].url ?? '',
                  );
                },
                child: const Text('Know More'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
