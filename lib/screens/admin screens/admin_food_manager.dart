import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:dabbabi_service/requests/firebase_requests/firebase_crud_foods.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
import 'package:shimmer/shimmer.dart';

class AdminFoodManager extends StatefulWidget {
  const AdminFoodManager({Key? key}) : super(key: key);

  @override
  State<AdminFoodManager> createState() => _AdminFoodManagerState();
}

TextEditingController addFoodName = TextEditingController();
TextEditingController addCategoryName = TextEditingController();
TextEditingController addFoodPrice = TextEditingController();
TextEditingController addFoodDescription = TextEditingController();
TextEditingController addFoodPackageType = TextEditingController();
TextEditingController addFoodQuantity = TextEditingController();
TextEditingController addFoodWeight = TextEditingController();

TextEditingController modifyFoodName = TextEditingController();
TextEditingController modifyCategoryName = TextEditingController();
TextEditingController modifyFoodPrice = TextEditingController();
TextEditingController modifyFoodDescription = TextEditingController();
TextEditingController modifyFoodPackageType = TextEditingController();
TextEditingController modifyFoodQuantity = TextEditingController();
TextEditingController modifyFoodWeight = TextEditingController();




class _AdminFoodManagerState extends State<AdminFoodManager> {

  PlatformFile? pickedFileforAdd;
  late Uint8List fileBytes;
  bool isDelivrable=false;
  bool isSizable=true;

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> collectionReference = FirebaseFoodCrud.ReadFoods();


/*    setCategorieIconTo(int index){
      setState(() {
        lastTapedIconInAddCategorie=index;
        selectedCategorieIconInAddCategorie = listOfIconsName[index].toString();
        addCategorieIcon.text=(selectedCategorieIconInAddCategorie);
      });
    }*/


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
                  "FOOD LIST ".toUpperCase(),
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
                                    height: 0.2.sh,
                                    width: 1.sw,
                                    child: Center(
                                      child: ListView(

                                          scrollDirection: Axis.horizontal,
                                          children: snapshot.data!.docs.map((data){

                                            return Center(
                                              child: CachedNetworkImage(
                                                imageUrl: data["foodImage"],
                                                errorWidget: (context, url, error) {
                                                  return Container(
                                                    child: Center(
                                                      child: Icon(FontAwesomeIcons.triangleExclamation,color: Colors.redAccent,),
                                                    ),
                                                  );
                                                },
                                                placeholder: (context, url) {

                                                  return SizedBox(
                                                    width: 0.2.sh,
                                                    height: 0.2.sh,
                                                    child: Shimmer.fromColors(
                                                      baseColor: Colors.transparent,
                                                      highlightColor: Colors.yellow,
                                                      child: Text(
                                                        'Loading',
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 40.0,
                                                          fontWeight:
                                                          FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  );

                                                },

                                                imageBuilder:(context, imageProvider) {
                                                  return Container(
                                                    width: 0.2.sh,
                                                    height: 0.2.sh,


                                                    margin: EdgeInsets.symmetric(horizontal: 10),
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: imageProvider,
                                                          fit: BoxFit.cover,
                                                         ),


                                                      borderRadius: BorderRadius.circular(10),

                                                      border: Border.all(
                                                        color:  isLightMode?Colors.black:Colors.white,



                                                      ),

                                                    ),
                                                    child: ElevatedButton(
                                                        onPressed: (){},
                                                        onLongPress: (){
                                                          /*   showModalBottomSheet(context: context, builder: (context) {
                                                        return ModifyCategorieWidget(listOfIcons: listOfIcons,data: data,listOfIconsName: listOfIconsName, collectionReference: collectionReference,);

                                                      },);*/
                                                          print(data["CategorieName"]);
                                                        },
                                                        style: ButtonStyle(

                                                          backgroundColor:MaterialStatePropertyAll(Colors.transparent),
                                                        ),
                                                        child: Stack(
                                                          children: [
                                                            Positioned(
                                                                top: 0,
                                                                left: 0,
                                                                child: Text(data["foodName"])),
                                                            Positioned(
                                                                bottom: 0,
                                                                left: 0,
                                                                child: Text(data["price"]+"TND \n${data["quantity"]+" item left"}" )),

                                                          ],
                                                        )
                                                    ),



                                                  );
                                                },

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
                        collectionReference = FirebaseFoodCrud.ReadFoods();
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
                    "ADD Food ".toUpperCase(),
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
               Wrap(
                 children: [
                   Container(
                     width: 0.4.sw,
                     height: 0.4.sw,
                     child: pickedFileforAdd!=null?
                     ClipRRect(
                       borderRadius: BorderRadius.circular(15),
                       child: Image.file(
                         File(pickedFileforAdd!.path!),
                         width: double.infinity,
                         fit: BoxFit.cover,
                       ),
                     ):
                         Container(
                           child: Text("No image Selected",style: TextStyle(
                             color: Colors.pink
                           )),
                         )
                   ),
                   SizedBox(width: 10,),
                   Container(
                     width: 0.4.sw,
                     child: ElevatedButton(
                         onPressed: (){
                           addImageSelection();
                         },
                         child: Text("Select Image")),
                   ),
                 ],
               ),
                Divider(height: 0.01.sh,),
                Container(

                  child: TextField(
                    decoration: InputDecoration(
                        label: Text("Categorie Name *"),
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
                    controller: addCategoryName,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: TextField(
                    decoration: InputDecoration(
                        label: Text("Food Name "),
                        floatingLabelAlignment: FloatingLabelAlignment.start,
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        hintText: "Pizza",
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
                    controller: addFoodName,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: TextField(

                    decoration: InputDecoration(

                        label: Text("Food Description "),
                        floatingLabelAlignment: FloatingLabelAlignment.start,
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        hintText: "----------",
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
                    controller: addFoodDescription,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: TextField(
                    decoration: InputDecoration(
                        label: Text("Food Package type "),
                        floatingLabelAlignment: FloatingLabelAlignment.start,
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        hintText: "Box-Bottle-bag",
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
                    controller: addFoodPackageType,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: TextField(
                    decoration: InputDecoration(
                        label: Text("Food Weight "),
                        floatingLabelAlignment: FloatingLabelAlignment.start,
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        hintText: "1L",
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
                    controller: addFoodWeight,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: TextField(
                    decoration: InputDecoration(
                        label: Text("Food Quantity "),
                        floatingLabelAlignment: FloatingLabelAlignment.start,
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        hintText: "100",
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
                    controller: addFoodQuantity,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: TextField(
                    decoration: InputDecoration(
                        label: Text("Food Price "),
                        floatingLabelAlignment: FloatingLabelAlignment.start,
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        hintText: "30 TND",
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
                    controller: addFoodPrice,
                   ),
                ),
                SizedBox(
                  height: 25,
                ),

          SizedBox(height: 30,),
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    Container(
                      height: 0.06.sh,
                      width: 0.9.sw,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: AppColors.appGreen
                          )
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                Text(
                                    "can you deliver this food:  ".toUpperCase()
                                ),
                                Text("${isDelivrable}.".toUpperCase(),style: TextStyle(

                                  fontSize: 0.02.sh,color:isDelivrable?Colors.green:Colors.red,
                                ),),
                              ],
                            ),
                            Switch(

                              // This bool value toggles the switch.
                              value: isDelivrable,

                              onChanged: (bool value) {
                                // This is called when the user toggles the switch.
                                setState(() {
                                  isDelivrable = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),

                  ],
                ),
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    Container(
                      height: 0.06.sh,
                      width: 0.9.sw,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: AppColors.appGreen
                          )
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                Text(
                                    "This food Have Sizes S/M/L:  ".toUpperCase()
                                ),
                                Text("${isSizable}.".toUpperCase(),style: TextStyle(

                                  fontSize: 0.02.sh,color:isSizable?Colors.green:Colors.red,
                                ),),
                              ],
                            ),
                            Switch(

                              // This bool value toggles the switch.
                              value: isSizable,

                              onChanged: (bool value) {
                                // This is called when the user toggles the switch.
                                setState(() {
                                  isSizable = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),

                  ],
                ),
                SizedBox(height: 30,),
                Padding(

                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: GestureDetector(
                    onTap: () {
                      addCategorie();
                    },
                    child: Container(
                      width: 0.6.sw,
                      padding: EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        color:AppColors.appGreen,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(child: Text('ADD FOOD')),
                    ),
                  ),
                ),
                buildProgress(),

              ],
            )

          ],
        ),
      ),
    );
  }



  Future addCategorie() async {
    String _categorieName = addCategoryName.text;
    String _foodName = addFoodName.text;
    String _foodDescription = addFoodDescription.text;
    String _foodPrice = addFoodPrice.text;
    String _foodQuantity = addFoodQuantity.text;
    String _foodWeight = addFoodWeight.text;
    String _foodPackageType = addFoodPackageType.text;
    String _isSizable= isSizable.toString();
    String _isDelivrable=isDelivrable.toString();



    if (_categorieName.isNotEmpty
        && _foodName.isNotEmpty
        && _foodPackageType.isNotEmpty
        && _foodPrice.isNotEmpty
        && _foodQuantity.isNotEmpty
        && _foodWeight.isNotEmpty
        && _foodDescription.isNotEmpty) {


      final file=File(pickedFileforAdd!.path!);
      String path=imagesPath+_foodName.toString();
      final ref = FirebaseStorage.instance.ref().child(path);
      uploadTask= ref.putFile(file);
      final snapshot = await uploadTask!.whenComplete(() => () async {
      });
      final urlDownload = await snapshot.ref.getDownloadURL ();
      print("Download Link $urlDownload");
      uploadTask=null;

      var response = await FirebaseFoodCrud.addFood(
        foodImage: urlDownload,
        foodName: _foodName,
        foodWeight: _foodWeight,
        foodPackageType: _foodPackageType,
        price: _foodPrice,
        isSizable: isSizable.toString(),
        isDelivrable: isDelivrable.toString(),
        quantity: _foodQuantity,
        foodDescription: _foodDescription,
        categorieName: _categorieName, pickedFile: pickedFileforAdd!,);




      if (response.code != 200) {
        SnackBarWidgets.alertSnackBar(response.message.toString(), response.code.toString());
      } else {
        SnackBarWidgets.successSnackBar(response.message.toString(), response.code.toString());
      }


    } else {
      SnackBarWidgets.alertSnackBar("Please fill all fields", ErrorCodeHandler.errorCodeEmptyField.toString());




    }

  }

  static Widget buildProgress()=>StreamBuilder(
    stream: uploadTask?.snapshotEvents,
    builder: (context, snapshot) {

      if (snapshot.hasData) {
        final progr=snapshot.data!;
        double progress=progr.bytesTransferred/progr.totalBytes;
        return SizedBox(
          height: 50,
          child: Stack(
            fit: StackFit.expand,
            children: [
              LinearProgressIndicator(
                value: progress,
                backgroundColor: AppColors.yellowColor,
                color: AppColors.signColor,
              ),
              Center(
                child: Text("UPLOADING IMAGE PROGRESS ${progress.toStringAsFixed(2)}"),
              )
            ],
          ),
        );
      }
      else return const SizedBox(height: 50,);
    },);



  Future addImageSelection() async {
   final result = await FilePicker.platform.pickFiles(
     type: FileType.image

   );
   if (result == null ) return ;




setState(() {
  pickedFileforAdd=result.files.first;

});
   final name=pickedFileforAdd!.name;
   print("the file name is ${name}");
  }


}

/*
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
            return AdminFoodManager();
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
            return AdminFoodManager();
          },
        ),
      );

    } else {
      SnackBarWidgets.alertSnackBar("Please fill all fields", ErrorCodeHandler.errorCodeEmptyField.toString());




    }
  }

}
*/

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


