import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/common/constants.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/movie_list_bloc/movie_list_bloc.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';
import 'package:movie/presentation/pages/popular_movies_page.dart';
import 'package:movie/presentation/pages/top_rated_movies_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeMoviePage extends StatefulWidget {
  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  'Now Playing',
                  style: kHeading6,
                ),
              ),
              BlocBuilder<NowPlayingMovieListBloc, MovieListState>(
                builder: (context, state) {
                  if (state is MovieListLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is MovieListLoaded) {
                    return MovieList(state.movies);
                  } else {
                    return Text('Failed');
                  }
                }
              ),
              _buildSubHeading(
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, PopularMoviesPage.routeName),
              ),
              BlocBuilder<PopularMovieListBloc, MovieListState>(
                builder: (context, state) {
                  if (state is MovieListLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is MovieListLoaded) {
                    return MovieList(state.movies);
                  } else {
                    return Text('Failed');
                  }
                }
              ),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedMoviesPage.routeName),
              ),
              BlocBuilder<TopRatedMovieListBloc, MovieListState>(
                builder: (context, state) {
                  if (state is MovieListLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is MovieListLoaded) {
                    return MovieList(state.movies);
                  } else {
                    return Text('Failed');
                  }
                }
              ),
            ],
          ),
        ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            title,
            style: kHeading6,
          ),
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  MovieList(this.movies);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key('movieItem'),
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MovieDetailPage.routeName,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$baseImageUrl${movie.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
