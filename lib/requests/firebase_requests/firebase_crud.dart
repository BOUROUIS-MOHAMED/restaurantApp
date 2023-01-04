import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dabbabi_service/models/firebase_response_model.dart';
import 'package:dabbabi_service/util/error_code_handler.dart';
import 'package:firebase_core/firebase_core.dart';


final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _Collection = _firestore.collection('Categories');
class FirebaseCrud {
//CRUD method here









  static Future<ResponseFromCrudFireBase> addCategorie({
    required String categorieName,
    required String categorieIcon,
     String? categorieItemSelled,
  }) async {

    ResponseFromCrudFireBase response = ResponseFromCrudFireBase();
    DocumentReference documentReferencer =
    _Collection.doc(categorieName);

    Map<String, dynamic> data = <String, dynamic>{
      "CategorieName": categorieName,
      "CategorieIcon": categorieIcon,
      "CategorieItemSelled" : "0",

    };

    var result = await documentReferencer
        .set(data)
        .whenComplete(() {
      response.code = 200;
      response.message = "Categorie Sucessfully added to the database";
    })
        .catchError((e) {
      response.code = 500;
      response.message = e.toString();
      print(response.message);
    });

    return response;
  }





  //

  static Stream<QuerySnapshot> readCategories() {
    CollectionReference notesItemCollection =
        _Collection;

    return notesItemCollection.snapshots();
  }


  static Future<ResponseFromCrudFireBase> updateCategorie({

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
     deleteCategorie(categorieName: docName);
   }
  }

  return response;






  }

  static Future<ResponseFromCrudFireBase> deleteCategorie({
    required String categorieName,
  }) async {
    ResponseFromCrudFireBase response = ResponseFromCrudFireBase();
    DocumentReference documentReferencer =
    _Collection.doc(categorieName);

    await documentReferencer
        .delete()
        .whenComplete((){
      response.code = 200;
      response.message = "Categorie Sucessfully Deleted ";
    })
        .catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }
}