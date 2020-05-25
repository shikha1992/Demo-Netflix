import 'package:demoneosoft/redux/action/popular_action.dart';
import 'package:demoneosoft/redux/action/top_rated_action.dart';
import 'package:demoneosoft/redux/action/upcoming_action.dart';
import 'package:flutter/cupertino.dart';
import 'package:redux/redux.dart';


import '../app_state.dart';
import '../modal.dart';

//This class provides way to interact with actions that have been dispatched to the store before they reach the store's reducer
//here actions for API are dispatched(async requests)

final contextMovieReducer = TypedReducer<BuildContext, UpComingMovieAction>(_contextMovieReducer); // to share context of movie page
final listUpcomingReducer = TypedReducer<UpcomingMoviesModel, UpComingMovieApiResponseAction>(_listUpComingReducer); // response of upcoming movies
final listPopularReducer = TypedReducer<UpcomingMoviesModel, PopularMovieApiResponseAction>(_listPopularReducer); //response of popular movies
final listTopRatedReducer = TypedReducer<UpcomingMoviesModel, TopRatedMovieApiResponseAction>(_listTopRateReducer); //response of top R movies
final loaderReducer = TypedReducer<bool, MoviesLoaderAction>(_loaderReducer); //loader for movies


//All methods declared in reducer are defined here...part of reducer only!


//............................................Reducer..............................................

BuildContext _contextMovieReducer(BuildContext state, UpComingMovieAction action) {
  return action.contextUpComing;
}

UpcomingMoviesModel  _listUpComingReducer(UpcomingMoviesModel data, UpComingMovieApiResponseAction action) {
  return action.responseUpComing;
}

UpcomingMoviesModel  _listPopularReducer(UpcomingMoviesModel data, PopularMovieApiResponseAction action) {
  return action.responsePopular;
}

UpcomingMoviesModel  _listTopRateReducer(UpcomingMoviesModel data, TopRatedMovieApiResponseAction action) {
  return action.responseTopRated;
}

bool  _loaderReducer(bool data, MoviesLoaderAction action) {
  return action.loaderMovies;
}

