import 'package:core/common/constants.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/presentation/bloc/search_bloc.dart';
import 'package:core/presentation/widgets/movie_card_list.dart';
import 'package:core/presentation/widgets/tv_show_card_list.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  static const routeName = '/search';
  final List<String> _tabTitle = ['Movies', 'Tv Shows'];
  final List<Widget> _bodyPage = [const _SearchMovieResult(), const _SearchTvShowResult()];

  SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Search'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                onChanged: (query) {
                  context.read<SearchMovieBloc>().add(OnQueryChanged(query));
                  context.read<SearchTvShowBloc>().add(OnQueryChanged(query));
                },
                decoration: InputDecoration(
                    hintText: 'Search Title',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),),
                    contentPadding: const EdgeInsets.all(12),),
                textInputAction: TextInputAction.search,
              ),
              const SizedBox(height: 16),
              Text(
                'Search Result',
                style: kHeading6,
              ),
              TabBar(
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(50), // Creates border
                    color: Colors.lightGreen[600],),
                tabs: [
                  Tab(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.movie),
                        const SizedBox(width: 8),
                        Text(_tabTitle[0], style: kSubtitle),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.tv),
                        const SizedBox(width: 8),
                        Text(_tabTitle[1], style: kSubtitle),
                      ],
                    ),
                  ),
                ],
              ),
              Flexible(child: TabBarView(children: _bodyPage))
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
    return BlocBuilder<SearchMovieBloc, SearchState>(
      builder: (context, state) {
        if (state is SearchLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SearchHasData<Movie>) {
          final result = state.searchResult;
          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemBuilder: (context, index) {
              final movie = result[index];
              return MovieCard(movie);
            },
            itemCount: result.length,
          );
        } else if (state is SearchEmpty) {
          return Center(
            child: Text(state.message, style: kSubtitle),
          );
        } else if (state is SearchError) {
          return Center(
            child: Text(state.message, style: kSubtitle),
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
    return BlocBuilder<SearchTvShowBloc, SearchState>(
      builder: (context, state) {
        if (state is SearchLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SearchHasData<TvShow>) {
          final result = state.searchResult;
          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemBuilder: (context, index) {
              final tvShow = result[index];
              return TvShowCard(tvShow);
            },
            itemCount: result.length,
          );
        } else if (state is SearchEmpty) {
          return Center(
            child: Text(state.message, style: kSubtitle),
          );
        } else if (state is SearchError) {
          return Center(
            child: Text(state.message, style: kSubtitle),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
