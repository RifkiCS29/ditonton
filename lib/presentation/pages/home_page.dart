import 'package:ditonton/common/constants.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/home_movie_page.dart';
import 'package:ditonton/presentation/pages/home_tv_show_page.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:ditonton/presentation/pages/watchlist_page.dart';
import 'package:ditonton/presentation/provider/movie_list_notifier.dart';
import 'package:ditonton/presentation/provider/tv_show_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;
  final List<String> _tabTitle = ['Movies', 'Tv Shows'];
  final List<Widget> _page = [HomeMoviePage(), HomeTvShowPage()];
  void _onSelectedPage(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => Provider.of<MovieListNotifier>(context, listen: false)
          ..fetchNowPlayingMovies()
          ..fetchPopularMovies()
          ..fetchTopRatedMovies());
    Future.microtask(
        () => Provider.of<TvShowListNotifier>(context, listen: false)
          ..fetchAiringTodayTvShows()
          ..fetchPopularTvShows()
          ..fetchTopRatedTvShows());
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton', style: kHeading6.copyWith(fontSize: 17)),
              accountEmail: Text('ditonton@dicoding.com', style: kSubtitle),
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text(_tabTitle[0], style: kSubtitle),
              onTap: () {
                _onSelectedPage(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.tv),
              title: Text(_tabTitle[1], style: kSubtitle),
              onTap: () {
                _onSelectedPage(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist', style: kSubtitle),
              onTap: () {
                Navigator.pushNamed(context, WatchlistPage.ROUTE_NAME);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About', style: kSubtitle),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('${_tabTitle[_index]}'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchPage.ROUTE_NAME);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: _page[_index],
    );
  }
}