import 'package:flutter/cupertino.dart';

import '../modal.dart';

//action for upcoming movie list
class UpComingMovieAction {
  BuildContext contextUpComing;

  UpComingMovieAction(this.contextUpComing);
}

//reposnse fetched
class UpComingMovieApiResponseAction {
  UpcomingMoviesModel responseUpComing;

  UpComingMovieApiResponseAction(this.responseUpComing);
}


//for loading screen init
class MoviesLoaderAction {
  bool loaderMovies;

  MoviesLoaderAction(this.loaderMovies);
}