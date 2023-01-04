import 'package:dabbabi_service/screens/admin%20screens/admin_home_panel.dart';
import 'package:dabbabi_service/screens/splash.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../providers/app_provider.dart';
import '../util/categories.dart';
import '../util/comments.dart';
import '../util/const.dart';
import '../util/foods.dart';
import '../widgets/badge.dart';
import '../widgets/cart_item.dart';
import '../widgets/grid_product.dart';
import '../widgets/home_category.dart';
import '../widgets/slider_item.dart';
import '../widgets/smooth_star_rating.dart';
import 'dishes.dart';

import 'main_screen.dart';
import 'notifications.dart';

import 'package:carousel_slider/carousel_slider.dart';


class ApplicationInfoScreen extends StatefulWidget {
  @override
  _ApplicationInfoScreenState createState() => _ApplicationInfoScreenState();
}

class _ApplicationInfoScreenState extends State<ApplicationInfoScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0,0,10.0,0),

        child: ListView(
          children: <Widget>[

            Divider(),
            Container(height: 15.0),

            Padding(
              padding: EdgeInsets.all(5.0),
              child: Text(
                "Application Information ".toUpperCase(),
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            ListTile(
              title: Text(
               " Version ",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),

              subtitle: Text(
                Constants.appVersion,
              ),

              trailing: IconButton(
                icon: Icon(
                  Icons.refresh_sharp,
                  size: 20.0,
                ),
                onPressed: (){
                },
                tooltip: "Check for update",
              ),
            ),

            ListTile(
              title: Text(
                "User Token",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),

              subtitle: Text(
                "This token is private.don't share it",
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.remove_red_eye_outlined,
                  size: 20.0,
                ),
                onPressed: (){
                },
                tooltip: "display Token",
              ),

            ),

            ListTile(
              title: Text(
                "Version Serial key",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),

              subtitle: Text(
                "C876-81TC-98RCZ-F5G7E-T5GWV-2080V-FF",
              ),
            ),


          ],
        ),
      ),
    );
  }



}
