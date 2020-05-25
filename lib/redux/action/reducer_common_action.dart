//This class takes the current state and an action, and returns the next state >>>>> Reducer
import 'package:demoneosoft/redux/reducer/app_reducer.dart';

import '../app_state.dart';

AppState appReducer(AppState state, action) {
  return AppState(
    contextUpComing: contextMovieReducer(state.contextUpComing, action), //context for movie page
    responseUpComing: listUpcomingReducer(state.responseUpComing, action), //list up coming for movie page
    responsePopular: listPopularReducer(state.responsePopular, action), //list popular for movie page
    responseTopRated: listTopRatedReducer(state.responseTopRated, action), //list top R for movie page
    loader: loaderReducer(state.loader, action), //loader for  movie page
  );
}


