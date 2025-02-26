import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_aggregator_app/Screens/search_page/search_cubit.dart';
import 'package:intl/intl.dart';
import 'package:news_aggregator_app/utils/contstants.dart'; // For date formatting

class SearchNewsPage extends StatefulWidget {
  const SearchNewsPage({super.key});

  @override
  State<SearchNewsPage> createState() => _SearchNewsPageState();
}

class _SearchNewsPageState extends State<SearchNewsPage> {
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    final cubit = context.read<SearchCubit>();
    cubit.getNewsMainData();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SearchCubit>();
    return Scaffold(
      body: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {
          // Handle state changes if needed
        },
        builder: (context, state) {
          if (state is SearchLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (cubit.mainArticles == null ||
              cubit.mainArticles!.isEmpty) {
            return const Center(child: Text('No articles found.'));
          }

          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                TextFormField(
                  controller: searchController,
                  decoration: InputDecoration(
                      hintText: 'Search News',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          cubit.searchQueryOnTap(searchController.text);
                        },
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.black),
                      )),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: cubit.mainArticles?.length ?? 0,
                    itemBuilder: (context, index) {
                      final article = cubit.mainArticles![index];
                      return Card(
                        elevation: 4,
                        color: Colors.white,
                        margin: const EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (article.urlToImage != null)
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(10)),
                                child: Image.network(
                                  article.urlToImage!,
                                  height: 200,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.broken_image),
                                ),
                              ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    article.title ?? 'No Title',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  if (article.description != null)
                                    Text(
                                      article.description!,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  const SizedBox(height: 8),
                                  if (article.source?.name != null)
                                    Row(
                                      children: [
                                        const Icon(Icons.source, size: 16),
                                        const SizedBox(width: 4),
                                        Text(
                                          article.source!.name!,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[800],
                                          ),
                                        ),
                                      ],
                                    ),
                                  const SizedBox(height: 8),
                                  if (article.publishedAt != null)
                                    Row(
                                      children: [
                                        const Icon(Icons.calendar_today,
                                            size: 16),
                                        const SizedBox(width: 4),
                                        Text(
                                          DateFormat('MMM dd, yyyy – hh:mm a')
                                              .format(DateTime.parse(
                                                  article.publishedAt!)),
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[800],
                                          ),
                                        ),
                                      ],
                                    ),
                                  const SizedBox(height: 16),
                                  ElevatedButton(
                                    onPressed: () {
                                      if (article.url != null) {
                                        launchWebsiteUrl(article.url!);
                                      }
                                    },
                                    child: const Text(
                                      'Read More',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      backgroundColor: Colors.blueAccent,
                                    ),
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
              ],
            ),
          );
        },
      ),
    );
  }
}
