import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dabbabi_service/requests/firebase_requests/firebase_crud.dart';
import 'package:dabbabi_service/screens/admin%20screens/admin_categorie_manager.dart';
import 'package:dabbabi_service/screens/admin%20screens/admin_food_manager.dart';
import 'package:dabbabi_service/util/colors.dart';
import 'package:dabbabi_service/util/error_code_handler.dart';
import 'package:dabbabi_service/widgets/snackbar_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../util/const.dart';
import '../../widgets/badge.dart';
import '../notifications.dart';

class AdminControlPanel extends StatefulWidget {
  @override
  _AdminControlPanelState createState() => _AdminControlPanelState();
}

class _AdminControlPanelState extends State<AdminControlPanel> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          Constants.appName,
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: IconBadge(
              icon: Icons.notifications,
              size: 22.0,
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return Notifications();
                  },
                ),
              );
            },
            tooltip: "Notifications",
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: ListView(
          children: <Widget>[
            Divider(),
            Container(height: 15.0),
            Padding(
              padding: EdgeInsets.all(5.0),
              child: Text(
                "ADMIN PANEL ".toUpperCase(),
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),


            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context){
                        return AdminCategorieManager();
                      },
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    color:AppColors.appGreen,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(child: Text('MANAGE CATEGORIE')),
                ),
              ),
            ),
            SizedBox(height: 0.05.sh,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context){
                        return AdminFoodManager();
                      },
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    color:AppColors.purpleColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(child: Text('MANAGE FOOD')),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }}
