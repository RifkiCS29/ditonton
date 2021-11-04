// Mocks generated by Mockito 5.0.16 from annotations
// in tv_show/test/presentation/pages/top_rated_tv_shows_page_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i6;
import 'dart:ui' as _i7;

import 'package:core/common/state_enum.dart' as _i4;
import 'package:core/domain/entities/tv_show.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;
import 'package:tv_show/domain/usecases/get_top_rated_tv_shows.dart' as _i2;
import 'package:tv_show/presentation/provider/top_rated_tv_shows_notifier.dart'
    as _i3;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeGetTopRatedTvShows_0 extends _i1.Fake
    implements _i2.GetTopRatedTvShows {}

/// A class which mocks [TopRatedTvShowsNotifier].
///
/// See the documentation for Mockito's code generation for more information.
class MockTopRatedTvShowsNotifier extends _i1.Mock
    implements _i3.TopRatedTvShowsNotifier {
  MockTopRatedTvShowsNotifier() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.GetTopRatedTvShows get getTopRatedTvShows =>
      (super.noSuchMethod(Invocation.getter(#getTopRatedTvShows),
          returnValue: _FakeGetTopRatedTvShows_0()) as _i2.GetTopRatedTvShows);
  @override
  _i4.RequestState get state => (super.noSuchMethod(Invocation.getter(#state),
      returnValue: _i4.RequestState.Empty) as _i4.RequestState);
  @override
  List<_i5.TvShow> get tvShows =>
      (super.noSuchMethod(Invocation.getter(#tvShows),
          returnValue: <_i5.TvShow>[]) as List<_i5.TvShow>);
  @override
  String get message =>
      (super.noSuchMethod(Invocation.getter(#message), returnValue: '')
          as String);
  @override
  bool get hasListeners =>
      (super.noSuchMethod(Invocation.getter(#hasListeners), returnValue: false)
          as bool);
  @override
  _i6.Future<void> fetchTopRatedTvShows() =>
      (super.noSuchMethod(Invocation.method(#fetchTopRatedTvShows, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i6.Future<void>);
  @override
  void addListener(_i7.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#addListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void removeListener(_i7.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#removeListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void dispose() => super.noSuchMethod(Invocation.method(#dispose, []),
      returnValueForMissingStub: null);
  @override
  void notifyListeners() =>
      super.noSuchMethod(Invocation.method(#notifyListeners, []),
          returnValueForMissingStub: null);
  @override
  String toString() => super.toString();
}
