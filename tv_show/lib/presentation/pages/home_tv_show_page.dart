import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/common/constants.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_show/presentation/bloc/tv_show_list_bloc/tv_show_list_bloc.dart';
import 'package:tv_show/presentation/pages/airing_today_tv_show_page.dart';
import 'package:tv_show/presentation/pages/popular_tv_shows_page.dart';
import 'package:tv_show/presentation/pages/top_rated_tv_shows_page.dart';
import 'package:tv_show/presentation/pages/tv_show_detail_page.dart';
import 'package:flutter/material.dart';

class HomeTvShowPage extends StatefulWidget {
  @override
  _HomeTvShowPageState createState() => _HomeTvShowPageState();
}

class _HomeTvShowPageState extends State<HomeTvShowPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSubHeading(
              title: 'Airing Today',
              onTap: () => Navigator.pushNamed(
                  context, AiringTodayTvShowsPage.routeName),
            ),
            BlocBuilder<AiringTodayTvShowListBloc, TvShowListState>(
                builder: (context, state) {
              if (state is TvShowListLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TvShowListLoaded) {
                return TvShowList(state.tvShows);
              } else {
                return Text('Failed');
              }
            }),
            _buildSubHeading(
              title: 'Popular',
              onTap: () =>
                  Navigator.pushNamed(context, PopularTvShowsPage.routeName),
            ),
            BlocBuilder<PopularTvShowListBloc, TvShowListState>(
                builder: (context, state) {
              if (state is TvShowListLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TvShowListLoaded) {
                return TvShowList(state.tvShows);
              } else {
                return Text('Failed');
              }
            }),
            _buildSubHeading(
              title: 'Top Rated',
              onTap: () =>
                  Navigator.pushNamed(context, TopRatedTvShowsPage.routeName),
            ),
            BlocBuilder<TopRatedTvShowListBloc, TvShowListState>(
                builder: (context, state) {
              if (state is TvShowListLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TvShowListLoaded) {
                return TvShowList(state.tvShows);
              } else {
                return Text('Failed');
              }
            }),
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

class TvShowList extends StatelessWidget {
  final List<TvShow> tvShows;

  TvShowList(this.tvShows);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key('tvShowItem'),
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tvShow = tvShows[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TvShowDetailPage.routeName,
                  arguments: tvShow.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$baseImageUrl${tvShow.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvShows.length,
      ),
    );
  }
}
