import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../providers/app_provider.dart';
import '../../requests/firebase_requests/firebase_crud.dart';
import '../../util/colors.dart';
import '../../util/const.dart';
import '../../util/error_code_handler.dart';
import '../../widgets/badge.dart';
import '../../widgets/snackbar_widgets.dart';
import '../notifications.dart';

class AdminCategorieManager extends StatefulWidget {
  const AdminCategorieManager({Key? key}) : super(key: key);

  @override
  State<AdminCategorieManager> createState() => _AdminCategorieManagerState();
}

TextEditingController addCategorieIcon = TextEditingController();
TextEditingController addCategorieName = TextEditingController();
TextEditingController addCategorieItemSelled = TextEditingController();
TextEditingController modifyCategorieIcon = TextEditingController();
TextEditingController modifyCategorieName = TextEditingController();
TextEditingController modifyCategorieItemSelled = TextEditingController();


class _AdminCategorieManagerState extends State<AdminCategorieManager> {

  String selectedCategorieIconInAddCategorie = "";
  String selectedCategorieIconInmodifyCategorie = "";
  List<IconData> listOfIcons = [
    FontAwesomeIcons.pizzaSlice,
    FontAwesomeIcons.wineBottle,
    FontAwesomeIcons.breadSlice,
    FontAwesomeIcons.drumstickBite,
    FontAwesomeIcons.bowlFood,
    FontAwesomeIcons.burger,
    FontAwesomeIcons.fish,
    FontAwesomeIcons.shrimp,
    FontAwesomeIcons.cakeCandles,
    FontAwesomeIcons.iceCream,
    FontAwesomeIcons.cheese,
    FontAwesomeIcons.cookie,
    FontAwesomeIcons.bacon,
    FontAwesomeIcons.stroopwafel,
    FontAwesomeIcons.pepperHot,
    FontAwesomeIcons.hotdog,
    FontAwesomeIcons.candyCane,
    Icons.fastfood_outlined
  ];
  List<String> listOfIconsName = [
    "FontAwesomeIcons.pizzaSlice",
    "FontAwesomeIcons.wineBottle",
    "FontAwesomeIcons.breadSlice",
    "FontAwesomeIcons.drumstickBite",
    "FontAwesomeIcons.bowlFood",
    "FontAwesomeIcons.burger",
    "FontAwesomeIcons.fish",
    "FontAwesomeIcons.shrimp",
    "FontAwesomeIcons.cakeCandles",
    "FontAwesomeIcons.iceCream",
    "FontAwesomeIcons.cheese",
    "FontAwesomeIcons.cookie",
    "FontAwesomeIcons.bacon",
    "FontAwesomeIcons.stroopwafel",
    "FontAwesomeIcons.pepperHot",
    "FontAwesomeIcons.hotdog",
    "FontAwesomeIcons.candyCane",
    "Icons.fastfood_outlined"
  ];
  int lastTapedIconInAddCategorie=50;
  int lastTapedIconInModifyCategorie=50;

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> collectionReference = FirebaseCrud.readCategories();

    setCategorieIconTo(int index){
      setState(() {
        lastTapedIconInAddCategorie=index;
        selectedCategorieIconInAddCategorie = listOfIconsName[index].toString();
        addCategorieIcon.text=(selectedCategorieIconInAddCategorie);
      });
    }
    bool isLightMode=Provider.of<AppProvider>(context).theme == Constants.lightTheme;
    return  Scaffold(
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
Column(
  children: [
    Container(height: 15.0),
    Text(
      "CATEGORIES LIST ".toUpperCase(),
      style: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
      ),
    ),



    Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Wrap(

            direction: Axis.horizontal,
            spacing: 5,
            runSpacing: 5,
            children: [
StreamBuilder(
stream: collectionReference,
    builder:(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if(snapshot.hasData){
      return Padding(

        padding: const EdgeInsets.all(8.0),

        child: Container(
          height: 0.08.sh,
          width: 1.sw,
          child: Center(
            child: ListView(

              scrollDirection: Axis.horizontal,
              children: snapshot.data!.docs.map((data){

                return Center(
                  child: Container(
                    width: 0.3.sw,
                  height: 0.05.sh,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color:  isLightMode?Colors.black:Colors.white,


                    ),

                  ),
                  child: ElevatedButton(
                    onPressed: (){},
                    onLongPress: (){
                      showModalBottomSheet(context: context, builder: (context) {
return ModifyCategorieWidget(listOfIcons: listOfIcons,data: data,listOfIconsName: listOfIconsName, collectionReference: collectionReference,);

                      },);
                      print(data["CategorieName"]);
                    },
                    style: ButtonStyle(
                      backgroundColor:MaterialStatePropertyAll(Colors.transparent),
                    ),
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      Icon(listOfIcons[listOfIconsName.indexOf(data["CategorieIcon"])]),

                      Text(data["CategorieName"]),
                    ],
                    ),
                  ),



                  ),
                );
              }).toList()
            ),
          ),
        ),
      );
      }else{
        return Container();
      }
    },
),
            ],
          ),
        ],
      ),
    ),
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child:  Text(
          "#for more option just hold the categorie container",
          style: TextStyle(
            fontSize: 0.01.sh,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    ),
    Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: () {
setState(() {
  collectionReference = FirebaseCrud.readCategories();
});
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color:AppColors.colorPack1,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(child: Text('REFRESH LIST')),
        ),
      ),
    ),

  ],
),
            Divider(height: 0.03.sh,)
            ,
            Column(
              children: [
                Container(height: 15.0),
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                    "ADD CATEGORIES ".toUpperCase(),
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  child: TextField(
                    decoration: InputDecoration(
                        label: Text("CategorieName *"),
                        floatingLabelAlignment: FloatingLabelAlignment.start,
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        hintText: "traditional food",
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.appGreen,
                            )),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.appGreen,
                            )),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                            )),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                    controller: addCategorieName,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Wrap(

                        direction: Axis.horizontal,
                        spacing: 5,
                        runSpacing: 5,
                        children: [
                          for(int i = 0; i < listOfIcons.length; i++) ...[
                            Container(
                              width: 0.3.sw,
                              child: GestureDetector(
                                  onTap: () {
                                    setCategorieIconTo(i);
                                  },
                                  child: iconContainer(
                                    listOfIcons: listOfIcons,
                                    index: i,
                                    currentIndex: lastTapedIconInAddCategorie,
                                  )
                              ),
                            ),
                          ],

                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: TextField(
                    decoration: InputDecoration(
                        label: Text("CategorieItemSelled "),
                        floatingLabelAlignment: FloatingLabelAlignment.start,
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        hintText: "50",
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.appGreen,
                            )),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.appGreen,
                            )),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                            )),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                    controller: addCategorieItemSelled,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: GestureDetector(
                    onTap: () {
                      addCategorie();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        color:AppColors.appGreen,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(child: Text('ADD CATEGORIE')),
                    ),
                  ),
                )
              ],
            )

          ],
        ),
      ),
    );
  }

  Future addCategorie() async {
    String _categorieName = addCategorieName.text;
    String _categorieIcon = addCategorieIcon.text;
    String _categorieItemSelled = addCategorieItemSelled.text ?? "";

    if (_categorieName.isNotEmpty && _categorieIcon.isNotEmpty) {
      var response = await FirebaseCrud.addCategorie(
          categorieName: _categorieName,
          categorieIcon: _categorieIcon,
          categorieItemSelled: _categorieItemSelled);
      if (response.code != 200) {
        SnackBarWidgets.alertSnackBar(response.message.toString(), response.code.toString());
      } else {
        SnackBarWidgets.successSnackBar(response.message.toString(), response.code.toString());
      }

      addCategorieName.text = "";
      addCategorieIcon.text = "";
      addCategorieItemSelled.text = "";
    } else {
      SnackBarWidgets.alertSnackBar("Please fill all fields", ErrorCodeHandler.errorCodeEmptyField.toString());




    }
  }


}

class ModifyCategorieWidget extends StatefulWidget {
   ModifyCategorieWidget({
    Key? key,
    required this.listOfIconsName,
    required this.data,
    required this.listOfIcons,
    required this.collectionReference
  }) : super(key: key);

  final List<IconData> listOfIcons;
  final QueryDocumentSnapshot<Object?> data;
  final List<String> listOfIconsName;
   Stream<QuerySnapshot> collectionReference;


  @override
  State<ModifyCategorieWidget> createState() => _ModifyCategorieWidgetState();
}
int lastTapedIconInModifyCategorie=50;
String selectedCategorieIconInmodifyCategorie = "";

class _ModifyCategorieWidgetState extends State<ModifyCategorieWidget> {



  setCategoryModifiedIconTo(int index){
    setState(() {
      print("index taped=${index}");
      lastTapedIconInModifyCategorie=index;
      selectedCategorieIconInmodifyCategorie = widget.listOfIconsName[index].toString();
      modifyCategorieIcon.text=(selectedCategorieIconInmodifyCategorie);
    });
  }
  @override
  void initState() {
    lastTapedIconInModifyCategorie=widget.listOfIconsName.indexOf(widget.data['CategorieIcon']);
    modifyCategorieName.text=widget.data['CategorieName'];
    modifyCategorieIcon.text=widget.data['CategorieIcon'];
    modifyCategorieItemSelled.text=widget.data["CategorieItemSelled"];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return     Container(

      padding: EdgeInsets.all(20),

      height: 0.8.sh,

      width: 1.sw,

      decoration: BoxDecoration(

        color: Colors.black38,

        borderRadius: BorderRadius.circular(20)



      ),

      child: SingleChildScrollView(



        child: Column(

          children: [

            Wrap(

              children: [

                Container(

                  width: 0.4.sw,

                  child: TextField(

                   enabled: false,

                    decoration: InputDecoration(



                        floatingLabelAlignment: FloatingLabelAlignment.start,

                        floatingLabelBehavior: FloatingLabelBehavior.auto,

                        hintText: widget.data["CategorieName"],

                        enabledBorder: OutlineInputBorder(

                            borderSide: BorderSide(

                              color: AppColors.appGreen,

                            )),

                        focusedBorder: OutlineInputBorder(

                            borderSide: BorderSide(

                              color: AppColors.appGreen,

                            )),

                        errorBorder: OutlineInputBorder(

                            borderSide: BorderSide(

                              color: Colors.red,

                            )),

                        border: OutlineInputBorder(

                          borderRadius: BorderRadius.circular(10),

                        )),





                  ),

                ),

                Container(

                  width: 0.5.sw,

                  child: TextField(

                    decoration: InputDecoration(

                        floatingLabelAlignment: FloatingLabelAlignment.start,

                        floatingLabelBehavior: FloatingLabelBehavior.auto,

                        hintText: "new Category Name",

                        enabledBorder: OutlineInputBorder(

                            borderSide: BorderSide(

                              color: AppColors.appGreen,

                            )),

                        focusedBorder: OutlineInputBorder(

                            borderSide: BorderSide(

                              color: AppColors.appGreen,

                            )),

                        errorBorder: OutlineInputBorder(

                            borderSide: BorderSide(

                              color: Colors.red,

                            )),

                        border: OutlineInputBorder(

                          borderRadius: BorderRadius.circular(10),

                        )),

                    controller: modifyCategorieName,

                  ),

                ),

              ],

            ),

            SizedBox(height: 0.02.sh,),

            Container(

              child: Column(

                mainAxisAlignment: MainAxisAlignment.center,

                children: [

                  Wrap(



                    direction: Axis.horizontal,

                    spacing: 5,

                    runSpacing: 5,

                    children: [

                      for(int i = 0; i < widget.listOfIcons.length; i++) ...[

                        Container(

                          width: 0.15.sw,

                          child: GestureDetector(

                              onTap: () {



                                setCategoryModifiedIconTo(i);

                              },

                              child: iconContainer(

                                listOfIcons: widget.listOfIcons,

                                index: i,

                                currentIndex: lastTapedIconInModifyCategorie,

                              )

                          ),

                        ),

                      ],



                    ],

                  ),

                ],

              ),

            ),

            SizedBox(height: 0.02.sh,),

            Wrap(

              children: [

                Container(

                  width: 0.4.sw,

                  child: TextField(

                    enabled: false,

                    decoration: InputDecoration(



                        floatingLabelAlignment: FloatingLabelAlignment.start,

                        floatingLabelBehavior: FloatingLabelBehavior.auto,

                        hintText: widget.data["CategorieItemSelled"],

                        enabledBorder: OutlineInputBorder(

                            borderSide: BorderSide(

                              color: AppColors.appGreen,

                            )),

                        focusedBorder: OutlineInputBorder(

                            borderSide: BorderSide(

                              color: AppColors.appGreen,

                            )),

                        errorBorder: OutlineInputBorder(

                            borderSide: BorderSide(

                              color: Colors.red,

                            )),

                        border: OutlineInputBorder(

                          borderRadius: BorderRadius.circular(10),

                        )),





                  ),

                ),

                Container(

                  width: 0.5.sw,

                  child: TextField(

                    decoration: InputDecoration(

                        floatingLabelAlignment: FloatingLabelAlignment.start,

                        floatingLabelBehavior: FloatingLabelBehavior.auto,

                        hintText: "new Category item selled number",

                        enabledBorder: OutlineInputBorder(

                            borderSide: BorderSide(

                              color: AppColors.appGreen,

                            )),

                        focusedBorder: OutlineInputBorder(

                            borderSide: BorderSide(

                              color: AppColors.appGreen,

                            )),

                        errorBorder: OutlineInputBorder(

                            borderSide: BorderSide(

                              color: Colors.red,

                            )),

                        border: OutlineInputBorder(

                          borderRadius: BorderRadius.circular(10),

                        )),

                    controller: modifyCategorieItemSelled,

                  ),

                ),

              ],

            ),
            SizedBox(height: 0.02.sh,),
            Wrap(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      updateCategorie();
                    });
                  },
                  child: Container(
                    width: 0.5.sw,
                    height: 0.06.sh,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      color:AppColors.appGreen,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(child: Text('SAVE CHANGES')),
                  ),
                ),
                SizedBox(width: 0.05.sw,),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      deleteCategorie(widget.data['CategorieName']);
                    });
                  },

                  child: Container(
                    width: 0.35.sw,
                    height: 0.06.sh,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      color:Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(child: Text('DELETE CATEGORIE')),
                  ),
                ),
              ],
            ),
            SizedBox(height: 0.02.sh,),


          ],

        ),

      ),

    );
  }
  Future deleteCategorie(String categorieName)async {


    if (categorieName.isNotEmpty) {
      var response = await FirebaseCrud.deleteCategorie(
          categorieName: categorieName);
      if (response.code != 200) {
        SnackBarWidgets.alertSnackBar(response.message.toString(), response.code.toString());
      } else {
        SnackBarWidgets.successSnackBar(response.message.toString(), response.code.toString());
      }
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return AdminCategorieManager();
          },
        ),
      );

    } else {
      SnackBarWidgets.alertSnackBar("Error", ErrorCodeHandler.errorCodeEmptyField.toString());




    }
  }

  Future updateCategorie() async {
    print("i am there ${modifyCategorieIcon.text}");

    String _categorieName = modifyCategorieName.text;
    String _categorieIcon = modifyCategorieIcon.text;
    String _categorieItemSelled = modifyCategorieItemSelled.text ?? "";

    if (_categorieName.isNotEmpty && _categorieIcon.isNotEmpty) {
      var response = await FirebaseCrud.updateCategorie(
          docName: widget.data["CategorieName"],
          categorieName: _categorieName,
          categorieIcon: _categorieIcon,
          categorieItemSelled: _categorieItemSelled);

      if (response.code != ErrorCodeHandler.errorCodeConnetedSuccessfully) {
SnackBarWidgets.alertSnackBar(response.message.toString(), response.code.toString());
      } else {
        SnackBarWidgets.successSnackBar(response.message.toString(), response.code.toString());
      }
setState(() {
  modifyCategorieName.text = "";
  modifyCategorieIcon.text = "";
  modifyCategorieItemSelled.text = "";
});
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return AdminCategorieManager();
          },
        ),
      );

    } else {
      SnackBarWidgets.alertSnackBar("Please fill all fields", ErrorCodeHandler.errorCodeEmptyField.toString());




    }
  }

}

class iconContainer extends StatelessWidget {
  const iconContainer({
    Key? key,
    required this.listOfIcons,
    required this.index,
    required this.currentIndex
  }) : super(key: key);

  final List<IconData> listOfIcons;
  final int index;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0.02.sh),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: AppColors.appGreen,
          ),
          color: index==currentIndex?AppColors.mainColor:Colors.transparent
      ),
      child: Center(
        child: Icon(
          listOfIcons[index],
          size: 0.025.sh,
          color: AppColors.colorPack2,
        ),
      ),
    );
  }
}


