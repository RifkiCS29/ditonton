import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/movie_search_notifier.dart';
import 'package:ditonton/presentation/provider/tv_show_search_notifier.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:ditonton/presentation/widgets/tv_show_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  static const ROUTE_NAME = '/search';
  final List<String> _tabTitle = ['Movies', 'Tv Shows'];
  final List<Widget> _bodyPage = [_SearchMovieResult(), _SearchTvShowResult()];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Search'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                onSubmitted: (query) {
                  Provider.of<MovieSearchNotifier>(context, listen: false)
                      .fetchMovieSearch(query);
                  Provider.of<TvShowSearchNotifier>(context, listen: false)
                      .fetchTvShowSearch(query);
                },
                decoration: InputDecoration(
                  hintText: 'Search Title',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24)
                  ),
                  contentPadding: EdgeInsets.all(12)
                ),
                textInputAction: TextInputAction.search,
                
              ),
              SizedBox(height: 16),
              Text(
                'Search Result',
                style: kHeading6,
              ),
              TabBar(
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(50), // Creates border
                  color: Colors.lightGreen[600]),
                tabs: [
                  Tab(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.movie),
                        const SizedBox(width: 8),
                        Text(_tabTitle[0], style: kSubtitle),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.tv),
                        const SizedBox(width: 8),
                        Text(_tabTitle[1], style: kSubtitle),
                      ],
                    ),
                  ),
                ],
              ),
              Flexible(
                child: TabBarView(children: _bodyPage)
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchMovieResult extends StatelessWidget {
  const _SearchMovieResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieSearchNotifier>(
      builder: (context, data, child) {
        if (data.state == RequestState.Loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (data.state == RequestState.Loaded) {
          final result = data.searchResult;
          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemBuilder: (context, index) {
              final movie = data.searchResult[index];
              return MovieCard(movie);
            },
            itemCount: result.length,
          );
        } else if (data.state == RequestState.Empty) {
          return Center(
            child: Text(data.message, style: kSubtitle),
          );
        } else if (data.state == RequestState.Error) {
          return Center(
            child: Text(data.message, style: kSubtitle),
          );
        } else {
          return Container();
        }
      },
    );
  }
}

class _SearchTvShowResult extends StatelessWidget {
  const _SearchTvShowResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TvShowSearchNotifier>(
      builder: (context, data, child) {
        if (data.state == RequestState.Loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (data.state == RequestState.Loaded) {
          final result = data.searchResult;
          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemBuilder: (context, index) {
              final tvShow = data.searchResult[index];
              return TvShowCard(tvShow);
            },
            itemCount: result.length,
          );
        } else if (data.state == RequestState.Empty) {
          return Center(
            child: Text(data.message, style: kSubtitle),
          );
        } else if (data.state == RequestState.Error) {
          return Center(
            child: Text(data.message, style: kSubtitle),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
