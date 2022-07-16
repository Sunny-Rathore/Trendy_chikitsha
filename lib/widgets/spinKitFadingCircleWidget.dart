import 'package:doctor/utils/color_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';



class SpinKitFadingCircleWidget extends StatelessWidget implements PreferredSizeWidget {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  late String text;
 late bool isLoading;
  SpinKitFadingCircleWidget(bool isLoading){
    this.isLoading=isLoading;

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Visibility(visible:isLoading,child:  SpinKitFadingCircle(
      itemBuilder: (BuildContext context, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: index.isEven ? ColorUtils.headerTextColor : ColorUtils.gradientColor3,
          ),
        );
      },
    ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);

}