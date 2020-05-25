import 'package:demoneosoft/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dashboard/dashboard_page.dart';

class DrawerItem {
  String title;

  DrawerItem(this.title);
}

class DrawerPage extends StatefulWidget {
  final drawerItems = [
    new DrawerItem("Dashboard"),
  ];

  @override
  State<StatefulWidget> createState() {
    return new DrawerPageState();
  }
}

class DrawerPageState extends State<DrawerPage> {
  int _selectedDrawerIndex = 0;
  List<DrawerItem> drawerItems;
  var drawerOptions;

  _getDrawerItemWidget(int pos, BuildContext context) {
    switch (pos) {
      case 0:
        return new DashboardPage();  //page for movies

      default:
        return new Text("In progress"); //no other view!!
    }
  }

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }


  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 375, height: 664)..init(context);
    return Theme(
        data: ThemeData(
          primaryIconTheme: IconThemeData(color: AppColors.colorBlack), //hamburger icon color
        ), // use this
        child: Scaffold(
          appBar: _appBar(),
          drawer: Theme(
              data: Theme.of(context).copyWith(
                canvasColor: AppColors
                    .colorWhite, //This will change the drawer background to white.
              ),
              child: Drawer(
                child: Container(
                  margin: EdgeInsets.only(
                      top: ScreenUtil.getInstance().setWidth(40),
                      right: ScreenUtil.getInstance().setWidth(20),
                      left: ScreenUtil.getInstance().setWidth(20)),
                  child: SingleChildScrollView(
                    child: SingleChildScrollView(
                      physics: NeverScrollableScrollPhysics(),
                      child: ListView.builder(
                          itemCount: widget.drawerItems.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder:
                              (BuildContext context, int index) {
                            return Column(
                              children: <Widget>[
                                ListTile(
                                  trailing: new Icon(
                                    _selectedDrawerIndex == index
                                        ? Icons.keyboard_arrow_down
                                        : Icons.keyboard_arrow_right,
                                    color: AppColors.colorBlack,
                                  ),
                                  title: new Text(
                                      widget.drawerItems[index].title
                                          .toUpperCase(),
                                      style: GoogleFonts.roboto(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .display1,
                                        fontSize:
                                        ScreenUtil.getInstance()
                                            .setSp(14),
                                        letterSpacing: 2,
                                        color: AppColors.colorBlack,
                                        fontWeight: FontWeight.w300,
                                      )),
                                  selected:
                                  index == _selectedDrawerIndex,
                                  onTap: () => _onSelectItem(index),
                                )
                              ],
                            );
                          }),
                    ),
                  ),
                ),
              )),
          body: _getDrawerItemWidget(_selectedDrawerIndex, context),
        ));
  }

  //app bar drawer
  Widget _appBar() {
    return new AppBar(
      title: Container(
        child: Text(
          widget.drawerItems[_selectedDrawerIndex].title,
          textAlign: TextAlign.center,
          style: GoogleFonts.robotoMono(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: ScreenUtil.getInstance().setSp(22),
            color: AppColors.colorBlack,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.all(5),
          child: Icon(
            Icons.search,
            color: AppColors.colorBlack,
          ),
        )
      ],
      centerTitle: true,
      backgroundColor: AppColors.colorWhite,
      elevation: 0,
    );
  }
}

