import 'package:demoneosoft/redux/action/reducer_common_action.dart';
import 'package:demoneosoft/redux/app_state.dart';
import 'package:demoneosoft/redux/middleware/middleware.dart';
import 'package:demoneosoft/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'application.dart';



void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: AppColors.colorWhite, // status bar color
    statusBarIconBrightness: Brightness.light, //brightness for bar
  ));

  WidgetsFlutterBinding.ensureInitialized();

  //add redux store provider function at app init
  final store = Store<AppState>(appReducer,
      initialState: AppState(responseUpComing: null, responsePopular: null, responseTopRated: null, loader: false ), //initialize value if you want!!
      middleware: createAppMiddleware()  //custom middleware function initialized
  );


  //run application state at first instance
  runApp(StoreProvider(
      store: store, child: Application())
  ); //run main function
}
