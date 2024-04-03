import 'package:cloud_firestore/cloud_firestore.dart';
class Data{
  Future<Stream<QuerySnapshot>>getData()async{
    return await FirebaseFirestore.instance.collection("users").snapshots();

  }

}