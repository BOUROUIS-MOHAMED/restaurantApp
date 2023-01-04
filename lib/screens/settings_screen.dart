import 'package:dabbabi_service/coffe_section/controller/coffee_bloc.dart';
import 'package:dabbabi_service/screens/admin%20screens/admin_home_panel.dart';
import 'package:dabbabi_service/screens/splash.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../coffe_section/widgets/coffee_concept_home.dart';
import '../pizza_section/widgets/pizza_order_details.dart';
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


class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}
final bloc=CoffeeBLoC();

class _SettingsScreenState extends State<SettingsScreen> {

  @override
  void dispose() {
  bloc.dispose();
    super.dispose();
  }
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
                "Application Settings".toUpperCase(),
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            ListTile(
              title: Text(
                "Language",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),

              subtitle: Text(
                "Notifications",
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
                "Donwload data with cellular connexion",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),

              subtitle: Text(
                "---",
              ),
            ),
            ListTile(
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
            ListTile(
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context){
                      return AdminControlPanel();
                    },
                  ),
                );
              },
              title: Text(
                "Admin Panel",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),

              subtitle: Text(
                "Add,modify,delete,manage data in your application",
              ),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context){
    return CoffeeProvider(bloc: bloc,
    child: MaterialApp(home: CoffeeConceptHome()));
    },


                  ),
                );
              },
              title: Text(
                "Coffe Concept Section",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),



              subtitle: Text(
                "---Bourouis Mohamed---",
              ),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context){
                      return PizzaOrderDetails();
                    },

                  ),
                );
              },
              title: Text(
                "Pizza section",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),

              subtitle: Text(
                "--Bourouis Mohamed--",
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
      ),
    );
  }
}
