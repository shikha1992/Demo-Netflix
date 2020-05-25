import 'package:flutter/cupertino.dart';

import '../modal.dart';

//action for popular movie list
class PopularMovieAction {

  PopularMovieAction();
}

//response fetched here
class PopularMovieApiResponseAction {
  UpcomingMoviesModel responsePopular;

  PopularMovieApiResponseAction(this.responsePopular);
}