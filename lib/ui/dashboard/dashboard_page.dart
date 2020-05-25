import 'package:cached_network_image/cached_network_image.dart';
import 'package:demoneosoft/redux/action/upcoming_action.dart';
import 'package:demoneosoft/redux/app_state.dart';
import 'package:demoneosoft/redux/modal.dart';
import 'package:demoneosoft/utils/app_colors.dart';
import 'package:demoneosoft/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:redux/redux.dart';


class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Store<AppState> store;
  var currentPageValueUp = 0.0;  //for animation at up coming movie

  //page viewer controllers
  PageController pageControllerCategory =
      PageController(viewportFraction: 0.3, initialPage: 2, keepPage: false);
  PageController pageControllerPopular =
      PageController(viewportFraction: 0.65, initialPage: 2);
  PageController pageControllerTopR =
      PageController(viewportFraction: 0.3, initialPage: 2, keepPage: true);
  PageController pageControllerUpcoming =
      PageController(viewportFraction: 0.85, initialPage: 2);


  //adding listener for animation controller
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageControllerUpcoming.addListener(() {
      setState(() {
        currentPageValueUp = pageControllerUpcoming.page;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 375, height: 664)..init(context);
    return StoreConnector<AppState, _DashBoardModel>(
        converter: (Store<AppState> store) {
      this.store = store;
      return _DashBoardModel.create(store, context);
    }, onInit: (Store store) async {
      store.dispatch(MoviesLoaderAction(true));
      store.dispatch(UpComingMovieAction(context)); //api
    }, onDidChange: (data) {
      if (data.dataUpTopR != null && data.dataUpTopR.results.length > 0) {
        pageControllerTopR.jumpToPage(2);
      }
      if (data.dataUpComing != null && data.dataUpComing.results.length > 0) {
        pageControllerCategory.jumpToPage(2);
      }
      if (data.dataUpPopular != null && data.dataUpPopular.results.length > 0) {
        pageControllerPopular.jumpToPage(2);
      }
    }, builder: (BuildContext context, _DashBoardModel data) {
      return Scaffold(
        backgroundColor: AppColors.colorWhite,
        body:
        data.loader ?
        Container(
          color: Colors.transparent,
          height: double.infinity,
          width: double.infinity,
          child: Center(
            child: CircularProgressIndicator(
              valueColor:
              AlwaysStoppedAnimation<Color>(Colors.black),
            ),
          ),
        )
          :
          SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                _upcomingView(data),
                SizedBox(
                  height: ScreenUtil.getInstance().setHeight(20),
                ),
                _popularView(data),
                SizedBox(
                  height: ScreenUtil.getInstance().setHeight(20),
                ),
                Row(
//                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                          left: ScreenUtil.getInstance().setWidth(10)),
                      child: Text(
                        StringLiteral.myList,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.openSans(
                          textStyle: Theme.of(context).textTheme.display1,
                          fontSize: ScreenUtil.getInstance().setSp(13),
                          color: AppColors.colorBlack,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          right: ScreenUtil.getInstance().setWidth(10)),
                      child: Icon(
                        Icons.arrow_forward,
                        color: AppColors.colorBlack,
                      ),
                    )
                  ],
                ),
                _topRatedView(data),

                SizedBox(
                  height: ScreenUtil.getInstance().setHeight(20),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                          left: ScreenUtil.getInstance().setWidth(10)),
                      child: Text(
                        StringLiteral.popularNet,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.openSans(
                          textStyle: Theme.of(context).textTheme.display1,
                          fontSize: ScreenUtil.getInstance().setSp(13),
                          color: AppColors.colorBlack,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.only(
                          right: ScreenUtil.getInstance().setWidth(10)),
                      child: Icon(
                        Icons.arrow_forward,
                        color: AppColors.colorBlack,
                      ),
                    )
                  ],
                ),
                _categoryView(data),
                SizedBox(
                  height: ScreenUtil.getInstance().setHeight(20),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  //upcoming view widget
  Widget _upcomingView(_DashBoardModel data) {
    return Container(
      height: ScreenUtil.getInstance().setWidth(200),
      child: PageView.builder(
        itemBuilder: (context, position) {
          if (position == currentPageValueUp.floor()) {
            return Transform(
              transform: Matrix4.identity()
                ..rotateX(currentPageValueUp - position),
              child: _itemUpComing(data, position),
            );
          } else if (position == currentPageValueUp.floor() + 1) {
            return Transform(
              transform: Matrix4.identity()
                ..rotateX(currentPageValueUp - position),
              child: _itemUpComing(data, position),
            );
          } else {
            return _itemUpComing(data, position);
          }
        },
        itemCount:
            data.dataUpComing != null ? data.dataUpComing.results.length : 0,
        pageSnapping: false,
        controller: pageControllerUpcoming,
      ),
    );
  }

  //***single item for upcoming lis >>> item pager (upcoming)*****
  Widget _itemUpComing(_DashBoardModel data, int position) {
    return Stack(
      children: <Widget>[
        Container(
          width: ScreenUtil.getInstance().setWidth(300),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: CachedNetworkImage(
              imageUrl:
                  'https://image.tmdb.org/t/p/w185${data.dataUpComing.results[position].posterPath}',
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            margin: EdgeInsets.only(
                right: ScreenUtil.getInstance().setWidth(10),
                left: ScreenUtil.getInstance().setWidth(10),
                bottom: ScreenUtil.getInstance().setWidth(10)),
            child: Text(
              data.dataUpComing.results[position].originalTitle.toUpperCase(),
              textAlign: TextAlign.left,
              maxLines: 3,
              style: GoogleFonts.poppins(
                textStyle: Theme.of(context).textTheme.display1,
                fontSize: ScreenUtil.getInstance().setSp(16),
                color: AppColors.colorWhite,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  //popular view widget**
  Widget _popularView(_DashBoardModel data) {
    return Container(
      height: 60,
      child: PageView.builder(
        itemBuilder: (context, position) {
          return Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(5),
                width: ScreenUtil.getInstance().setWidth(250),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://image.tmdb.org/t/p/w185${data.dataUpPopular.results[position].posterPath}',
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: EdgeInsets.all(5),
                  width: ScreenUtil.getInstance().setWidth(250),
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    color: Color.fromRGBO(255, 0, 0, 0.29),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: EdgeInsets.all(5),
                  width: ScreenUtil.getInstance().setWidth(250),
                  child: Text(
                    data.dataUpPopular.results[position].originalTitle
                        .toUpperCase(),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: GoogleFonts.poppins(
                      textStyle: Theme.of(context).textTheme.display1,
                      fontSize: ScreenUtil.getInstance().setSp(13),
                      color: AppColors.colorWhite,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
        itemCount:
            data.dataUpPopular != null ? data.dataUpPopular.results.length : 0,
        pageSnapping: false,
        controller: pageControllerPopular,
      ),
    );
  }

  //**top rated view pager**
  Widget _topRatedView(_DashBoardModel data) {
    return Container(
      height: 200,
      margin: EdgeInsets.only(right: ScreenUtil.getInstance().setWidth(10)),
      child: PageView.builder(
        itemBuilder: (context, position) {
          return Container(
            width: ScreenUtil.getInstance().setWidth(230),
            margin:
                EdgeInsets.only(right: ScreenUtil.getInstance().setWidth(10)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: CachedNetworkImage(
                imageUrl:
                    'https://image.tmdb.org/t/p/w185${data.dataUpTopR.results[position].posterPath}',
                fit: BoxFit.fill,
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          );
        },
        itemCount: data.dataUpTopR != null ? data.dataUpTopR.results.length : 0,
        pageSnapping: false,
        controller: pageControllerTopR,
      ),
    );
  }

  //**category pager view widget**
  Widget _categoryView(_DashBoardModel data) {
    return Container(
      height: 200,
      margin: EdgeInsets.only(right: ScreenUtil.getInstance().setWidth(10)),
      child: PageView.builder(
        itemBuilder: (context, position) {
          return Container(
            width: ScreenUtil.getInstance().setWidth(230),
            margin:
                EdgeInsets.only(right: ScreenUtil.getInstance().setWidth(10)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: CachedNetworkImage(
                imageUrl:
                    'https://image.tmdb.org/t/p/w185${data.dataUpComing.results[position].posterPath}',
                fit: BoxFit.fill,
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          );
        },
        itemCount:
            data.dataUpComing != null ? data.dataUpComing.results.length : 0,
        pageSnapping: false,
        controller: pageControllerCategory,
      ),
    );
  }
}

class _DashBoardModel {
  final Store<AppState> store;
  final UpcomingMoviesModel dataUpComing;
  final UpcomingMoviesModel dataUpPopular;
  final UpcomingMoviesModel dataUpTopR;
  final bool loader;

  _DashBoardModel(
      this.store, this.dataUpComing, this.dataUpPopular, this.dataUpTopR, this.loader);

  factory _DashBoardModel.create(Store<AppState> store, BuildContext context) {
    return _DashBoardModel(store, store.state.responseUpComing,
        store.state.responsePopular, store.state.responseTopRated, store.state.loader);
  }
}
