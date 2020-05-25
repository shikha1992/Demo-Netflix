import 'package:flutter/cupertino.dart';

import '../modal.dart';

//action for top rated movie list
class TopRatedMovieAction {

  TopRatedMovieAction();
}

//response fetched here
class TopRatedMovieApiResponseAction {
  UpcomingMoviesModel responseTopRated;

  TopRatedMovieApiResponseAction(this.responseTopRated);
}