import 'package:flutter/cupertino.dart';

import 'modal.dart';

//store state for application
@immutable
class AppState {
  final BuildContext contextUpComing;  //context movies page
  final UpcomingMoviesModel responseUpComing;  //list of data for upcoming movies
  final UpcomingMoviesModel responsePopular;  //list of data for popular movies
  final UpcomingMoviesModel responseTopRated;  //list of data for top R movies
  final bool loader;  //list of data for top R movies

  const AppState({
  this.contextUpComing,
  this.responseUpComing,
  this.responsePopular,
  this.responseTopRated,
  this.loader,
  });
}
