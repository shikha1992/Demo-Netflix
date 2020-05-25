import 'package:demoneosoft/redux/action/popular_action.dart';
import 'package:demoneosoft/redux/action/top_rated_action.dart';
import 'package:demoneosoft/redux/action/upcoming_action.dart';
import 'package:demoneosoft/redux/app_state.dart';
import 'package:demoneosoft/redux/modal.dart';
import 'package:http/http.dart';
import 'package:redux/redux.dart';
import 'dart:convert';
import 'dart:io';


enum Environment { DEV, PROD }

class ApiProvider {
  String _baseUrl = "";
  Client client = Client();
  final _apiKey = "f55fbda0cb73b855629e676e54ab6d8e";

  static final ApiProvider _apiProvider = ApiProvider._internal();
  static final Environment _setEnv = Environment.DEV;

  ApiProvider._internal() {
    // initialization logic here
    if(_setEnv == Environment.DEV){
      _baseUrl = 'http://api.themoviedb.org/3/movie';
    }else{
      _baseUrl = 'http://api.themoviedb.org/3/movie';
    }


  }

  factory ApiProvider() {
    return _apiProvider;
  }

  Future<int> getUpComingList(
      Store<AppState> store, UpComingMovieAction action) async {
    Client client = Client();
    UpcomingMoviesModel _upComingResponse;
    int _status = 0;
    store.dispatch(UpComingMovieApiResponseAction(null));

    try {
      final response = await client.get("$_baseUrl/upcoming?api_key=$_apiKey");
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("response upcoming: ${response.body}");

        _upComingResponse = UpcomingMoviesModel.fromJSON(json.decode(response.body));
        store.dispatch(UpComingMovieApiResponseAction(_upComingResponse));
        return response.statusCode;
      }  else {
        return 500;
      }
    } catch (e) {
      return 500;
    }

  }


  Future<int> getPopularList(
      Store<AppState> store, PopularMovieAction action) async {
    Client client = Client();
    UpcomingMoviesModel _upComingResponse;
    int _status = 0;
    store.dispatch(PopularMovieApiResponseAction(null));

    try {
      final response = await client.get("$_baseUrl/popular?api_key=$_apiKey");
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("response popular: ${response.body}");

        _upComingResponse = UpcomingMoviesModel.fromJSON(json.decode(response.body));
        store.dispatch(PopularMovieApiResponseAction(_upComingResponse));
        return response.statusCode;
      }  else {
        return 500;
      }
    } catch (e) {
      return 500;
    }

  }

  Future<int> getTopRatedList(
      Store<AppState> store, TopRatedMovieAction action) async {
    Client client = Client();
    UpcomingMoviesModel _upComingResponse;
    int _status = 0;
    store.dispatch(TopRatedMovieApiResponseAction(null));

    try {
      final response = await client.get("$_baseUrl/top_rated?api_key=$_apiKey");
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("response top rated: ${response.body}");

        _upComingResponse = UpcomingMoviesModel.fromJSON(json.decode(response.body));
        store.dispatch(TopRatedMovieApiResponseAction(_upComingResponse));
        return response.statusCode;
      }  else {
        return 500;
      }
    } catch (e) {
      return 500;
    }

  }

}

