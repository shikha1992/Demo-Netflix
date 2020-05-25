import 'package:demoneosoft/redux/action/popular_action.dart';
import 'package:demoneosoft/redux/action/top_rated_action.dart';
import 'package:demoneosoft/redux/action/upcoming_action.dart';
import 'package:demoneosoft/redux/modal.dart';
import 'package:demoneosoft/utils/service/api_service.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import '../app_state.dart';

//This class provides way to interact with actions that have been dispatched to the store before they reach the store's reducer
//here actions for API are dispatched(async requests)

List<Middleware<AppState>> createAppMiddleware() {
  return <Middleware<AppState>>[
    thunkMiddleware,
    TypedMiddleware<AppState, UpComingMovieAction>(_upcomingMovie),
    TypedMiddleware<AppState, PopularMovieAction>(_popularMovie),
    TypedMiddleware<AppState, TopRatedMovieAction>(_topRatedMovie),
  ];
}


//to get list of upcoming moview
void _upcomingMovie(
    Store<AppState> store, UpComingMovieAction action, NextDispatcher next) async {
  next(action);
  ApiProvider()
      .getUpComingList(store, action)
      .then((int status) {
    store.dispatch(PopularMovieAction());

  });
  print(action);
}


//to get list of popular movies
void _popularMovie(
    Store<AppState> store, PopularMovieAction action, NextDispatcher next) async {
  next(action);
  ApiProvider()
      .getPopularList(store, action)
      .then((int status) {
    store.dispatch(TopRatedMovieAction());
  });
  print(action);
}


//to get list of popular movies
void _topRatedMovie(
    Store<AppState> store, TopRatedMovieAction action, NextDispatcher next) async {
  next(action);
  ApiProvider()
      .getTopRatedList(store, action)
      .then((int status) {
        store.dispatch(MoviesLoaderAction(false));
  });
  print(action);
}
