import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dabbabi_service/models/firebase_response_model.dart';
import 'package:dabbabi_service/util/colors.dart';
import 'package:dabbabi_service/util/error_code_handler.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _Collection = _firestore.collection('Foods');
final String imagesPath= "food_images/";
UploadTask? uploadTask;
class FirebaseFoodCrud {
//CRUD method here

  static Future<ResponseFromCrudFireBase> addFood({
    required PlatformFile pickedFile,
    required   String  categorieName,
    required   String  foodDescription,
    required   String  foodImage,
    required   String  foodName,
    required   String  foodPackageType,
    required   String  foodWeight,
    required   String  isDelivrable,
    required   String  isSizable,
    required   String  price,
    required   String  quantity,


  }) async {

    ResponseFromCrudFireBase response = ResponseFromCrudFireBase();
    DocumentReference documentReferencer =
    _Collection.doc(foodName);
    Map<String, dynamic> data = <String, dynamic>{
      "CategorieName": categorieName,
"foodDescription": foodDescription,
       "foodImage":foodImage,
     "foodName": foodName,
     "foodPackageType":foodPackageType,
     "foodWeight":foodWeight,
     "isDelivrable":isDelivrable,
      "isSizable":isSizable,
     "price":price,
       "quantity":quantity,


    };

    var result = await documentReferencer
        .set(data)
        .whenComplete(() {
      response.code = 200;
      response.message = "food Sucessfully added to the database";
    })
        .catchError((e) {
      response.code = 500;
      response.message = e.toString();
      print(response.message);
    });

    return response;
  }



  //

  static Stream<QuerySnapshot> ReadFoods() {
    CollectionReference notesItemCollection =
        _Collection;
    return notesItemCollection.snapshots();
  }


  static Future<ResponseFromCrudFireBase> updateFood({

    required String docName,
    required String categorieName,
    required String categorieIcon,
    String? categorieItemSelled,

  }) async {
    print("this is docName ${docName} with his categorieName ${categorieName} and categorieIcon ${categorieIcon}");
    ResponseFromCrudFireBase response = ResponseFromCrudFireBase();
    DocumentReference documentReferencer =
    _Collection.doc(categorieName);

    Map<String, dynamic> data = <String, dynamic>{
      "CategorieName": categorieName,
      "CategorieIcon": categorieIcon,
      "CategorieItemSelled" : categorieItemSelled,

    };

    var result = await documentReferencer
        .set(data)
        .whenComplete(() {
      response.code = ErrorCodeHandler.errorCodeConnetedSuccessfully;
      response.message = "Categorie Sucessfully added to the database";
    })
        .catchError((e) {
      response.code = 500;
      response.message = e.toString();
      print(response.message);
    });

    if (response.code==ErrorCodeHandler.errorCodeConnetedSuccessfully) {
      if(categorieName!=docName){
        deleteFood(categorieName: docName);
      }
    }

    return response;






  }

  static Future<ResponseFromCrudFireBase> deleteFood({
    required String categorieName,
  }) async {
    ResponseFromCrudFireBase response = ResponseFromCrudFireBase();
    DocumentReference documentReferencer =
    _Collection.doc(categorieName);

    await documentReferencer
        .delete()
        .whenComplete((){
      response.code = 200;
      response.message = "Sucessfully Deleted Employee";
    })
        .catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }
}


/* foodDescription,
       foodImage,
      foodName,
     foodPackageType,
     foodWeight,
     isDelivrable,
      isSizable,
     price,
       quantity*/