import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/common/constants.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/common/state_enum.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:core/domain/entities/tv_show_detail.dart';
import 'package:tv_show/presentation/pages/tv_show_season_episodes_page.dart';
import 'package:tv_show/presentation/provider/tv_show_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class TvShowDetailPage extends StatefulWidget {
  static const routeName = '/detail-tvShow';

  final int id;
  TvShowDetailPage({required this.id});

  @override
  _TvShowDetailPageState createState() => _TvShowDetailPageState();
}

class _TvShowDetailPageState extends State<TvShowDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<TvShowDetailNotifier>(context, listen: false)
          .fetchTvShowDetail(widget.id);
      Provider.of<TvShowDetailNotifier>(context, listen: false)
          .loadWatchlistStatus(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TvShowDetailNotifier>(
        builder: (context, provider, child) {
          if (provider.tvShowState == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (provider.tvShowState == RequestState.Loaded) {
            final tvShow = provider.tvShow;
            return SafeArea(
              child: DetailContent(
                tvShow,
                provider.tvShowRecommendations,
                provider.isAddedToWatchlist,
              ),
            );
          } else {
            return Center(
              child: Text(provider.message, style: kSubtitle)
            );
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final TvShowDetail tvShow;
  final List<TvShow> recommendations;
  final bool isAddedWatchlist;

  DetailContent(this.tvShow, this.recommendations, this.isAddedWatchlist);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tvShow.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tvShow.name,
                              style: kHeading5,
                            ),
                            Row(
                              mainAxisAlignment : MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  key: Key('watchlistButtonTvShow'),
                                  onPressed: () async {
                                    if (!isAddedWatchlist) {
                                      await Provider.of<TvShowDetailNotifier>(
                                              context,
                                              listen: false)
                                          .addWatchlist(tvShow);
                                    } else {
                                      await Provider.of<TvShowDetailNotifier>(
                                              context,
                                              listen: false)
                                          .removeFromWatchlist(tvShow);
                                    }

                                    final message =
                                        Provider.of<TvShowDetailNotifier>(context,
                                                listen: false)
                                            .watchlistMessage;

                                    if (message ==
                                            TvShowDetailNotifier
                                                .watchlistAddSuccessMessage ||
                                        message ==
                                            TvShowDetailNotifier
                                                .watchlistRemoveSuccessMessage) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text(message)));
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              content: Text(message),
                                            );
                                          });
                                    }
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      isAddedWatchlist
                                          ? Icon(Icons.check)
                                          : Icon(Icons.add),
                                      Text('Watchlist'),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      RatingBarIndicator(
                                        rating: tvShow.voteAverage / 2,
                                        itemCount: 5,
                                        itemBuilder: (context, index) => Icon(
                                          Icons.star,
                                          color: kMikadoYellow,
                                        ),
                                        itemSize: 24,
                                      ),
                                      Text('${tvShow.voteAverage}')
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Text(
                              _showGenres(tvShow.genres),
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              tvShow.overview,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Seasons',
                              style: kHeading6,
                            ),
                            Container(
                              height: 185,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: tvShow.seasons.length,
                                itemBuilder: (context, index) {
                                  final season = tvShow.seasons[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context, 
                                          TvShowSeasonEpisodesPage.routeName,
                                          arguments: <String, dynamic> {
                                            "id": tvShow.id,
                                            "seasonNumber": season.seasonNumber
                                          }
                                        );
                                      },
                                      child: 
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 135,
                                              width: 96,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(10),
                                                child: ShaderMask(
                                                  shaderCallback: (rect) {
                                                    return LinearGradient(
                                                      colors: [
                                                        Colors.transparent,
                                                        Colors.black.withOpacity(0.4),
                                                      ],
                                                      begin: Alignment.topCenter,
                                                      end: Alignment.bottomCenter,
                                                    ).createShader(
                                                      Rect.fromLTRB(0, 0, rect.width, rect.bottom),
                                                    );
                                                  },
                                                  blendMode: BlendMode.darken,
                                                  child: Container(
                                                    child: CachedNetworkImage(
                                                      imageUrl:
                                                        season.posterPath == null
                                                        ? 'https://titan-autoparts.com/development/wp-content/uploads/2019/09/no.png'
                                                        : 'https://image.tmdb.org/t/p/w500${season.posterPath}',
                                                      placeholder: (context, url) =>
                                                        Center(
                                                          child:
                                                            CircularProgressIndicator(),
                                                        ),
                                                      errorWidget:
                                                        (context, url, error) =>
                                                            Icon(Icons.error),
                                                      imageBuilder: (context, imageProvider) {
                                                        return Container(
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(10),
                                                            image: DecorationImage(
                                                              image: imageProvider,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Text('Season ${season.seasonNumber}'),
                                            Text('${season.episodeCount} Episodes')
                                          ],
                                        ),
                                    ),
                                  );
                                }
                              ),
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            Consumer<TvShowDetailNotifier>(
                              builder: (context, data, child) {
                                if (data.recommendationState ==
                                    RequestState.Loading) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (data.recommendationState ==
                                    RequestState.Error) {
                                  return Text(data.message);
                                } else if (data.recommendationState ==
                                    RequestState.Loaded) {
                                  return Container(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final tvShow = recommendations[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                TvShowDetailPage.routeName,
                                                arguments: tvShow.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${tvShow.posterPath}',
                                                placeholder: (context, url) =>
                                                    Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: recommendations.length,
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }
}
