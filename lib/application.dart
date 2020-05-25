import 'package:demoneosoft/ui/drawer_page.dart';
import 'package:demoneosoft/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class Application extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }

}

class _MyAppState extends State<Application> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
//    ScreenUtil.instance = ScreenUtil(width: 375, height: 664)..init(context);
    SystemChrome.setPreferredOrientations([
      //orientation of app(currently portrait supported)
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      color: AppColors.colorWhite,
      darkTheme: ThemeData(
        brightness: Brightness.dark, //theme of app
        primaryColor: Colors.white,
      ),

      //key navigator for app to be used globally throughout app
      debugShowCheckedModeBanner: false,
      //debug tag - as false
      home: DrawerPage(),
      //list all routes to be used in app
      routes: <String, WidgetBuilder>{

      },
    );
  }
}

