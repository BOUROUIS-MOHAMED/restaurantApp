import 'dart:math';

import 'package:dabbabi_service/screens/application_info_screen.dart';
import 'package:dabbabi_service/screens/settings_screen.dart';
import 'package:dabbabi_service/screens/splash.dart';
import 'package:dabbabi_service/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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


class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  @override
  Widget build(BuildContext context) {

    List<Color> randomColor= [
      AppColors.yellowColor,
      AppColors.mainColor,
      AppColors.purpleColor,
      AppColors.darkGreen,
      AppColors.colorPack1,
      AppColors.colorPack2

    ];

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0,0,10.0,0),

        child: ListView(
          padding: EdgeInsets.only(top: 20),
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: randomColor[Random().nextInt(randomColor.length)],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 0.0, right: 0.1.sw),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(500),
                      child: Image.asset(

                        "assets/dev_info/profile.jpg",
                        fit: BoxFit.fill,
                        width: 100.0,
                        height: 100.0,
                      ),
                    ),
                  ),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Bourouis Mohamed",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 5.0),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "moha.amine.bou@gmail.com",
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            InkWell(
                              onTap: (){
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context){
                                      return SplashScreen();
                                    },
                                  ),
                                );
                              },
                              child: Text("Logout",
                                style: TextStyle(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context).accentColor,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),
                    flex: 3,
                  ),
                ],
              ),
            ),

            Divider(),
Container(
decoration: BoxDecoration(
    color: AppColors.darkGreen,
    borderRadius: BorderRadius.circular(25)
),
  child:
  Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(height: 15.0),

      Padding(
        padding: EdgeInsets.all(5.0),
        child: Text(
          "Account Information".toUpperCase(),
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      ListTile(
        title: Text(
          "Full Name",
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),

        subtitle: Text(
          "Bourouis Mohamed Amine",
        ),

        trailing: IconButton(
          icon: Icon(
            Icons.edit,
            size: 20.0,
          ),
          onPressed: (){
          },
          tooltip: "Edit",
        ),
      ),

      ListTile(
        title: Text(
          "Email",
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),

        subtitle: Text(
          "moha.amine.bou@gmail.com",
        ),
      ),

      ListTile(
        title: Text(
          "Phone",
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),

        subtitle: Text(
          "000000000",
        ),
      ),

      ListTile(
        title: Text(
          "Address",
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),

        subtitle: Text(
          "3221 Tataouine Ksar Mguebla",
        ),
      ),

      ListTile(
        title: Text(
          "Gender",
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),

        subtitle: Text(
          "Male",
        ),
      ),

      ListTile(
        title: Text(
          "Date of Birth",
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),

        subtitle: Text(
          "-----------",
        ),
      ),
    ],
  ),
),
            Divider(),
Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(25),
    color: AppColors.darkGreen,

  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ListTile(
        onTap: (){
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context){
                return SettingsScreen();
              },
            ),
          );
        },
        title: Text(
          "Settings",
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),

        trailing: Icon(FontAwesomeIcons.chevronRight,size: 15,),

        subtitle: Text(
          "Change the application Settings",
        ),
      ),
      ListTile(
        onTap: (){
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context){
                return ApplicationInfoScreen();
              },
            ),
          );
        },
        title: Text(
          "App Information",
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
        trailing: Icon(FontAwesomeIcons.chevronRight,size: 15,),

        subtitle: Text(
          "some information about the application",
        ),
      ),


      MediaQuery.of(context).platformBrightness == Brightness.dark
          ? SizedBox()
          : ListTile(
        title: Text(
          "Dark Theme",
          style: TextStyle(
            fontSize: 17,
            color: Colors.redAccent,
            fontWeight: FontWeight.w700,
          ),
        ),

        trailing: Switch(
          value: Provider.of<AppProvider>(context).theme == Constants.lightTheme
              ? false
              : true,
          onChanged: (v) async{
            if (v) {
              Provider.of<AppProvider>(context, listen: false)
                  .setTheme(Constants.darkTheme, "dark");
            } else {
              Provider.of<AppProvider>(context, listen: false)
                  .setTheme(Constants.lightTheme, "light");
            }
          },
          activeColor: Theme.of(context).accentColor,
        ),
      ),
    ],
  ),
)
          ],
        ),
      ),
    );
  }
}
