import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('myUser');
  final CollectionReference doctorsCollection = FirebaseFirestore.instance.collection('doctors');
  final CollectionReference specializatonCollection = FirebaseFirestore.instance.collection('specialization');

  Future updateUserData(String userName, String uid, String phoneNumber, String email, String pesel, String surname) async {
    return await userCollection.doc(uid).set({
      'name' : userName,
      'surname' : surname,
      'userId' : uid,
      'phoneNumber' : phoneNumber,
      'email': email,
      'pesel': pesel,
    });
  }

   Future updateDoctorsData(String userName, String doctorid, String phoneNumber, String surname) async {
    return await doctorsCollection.doc(uid).set({
      'name' : userName,
      'surname' : surname,
      'doctorId' : doctorid,
      'phoneNumber' : phoneNumber,
    });
  }

  Future updateSpecialization(String specializationName, String specid) async {
    return await specializatonCollection.doc(uid).set({
      'specializationId' : specid,
      'specializationName' : specializationName,
    });
  }

  Future checPeselNumber(String pesel) async {
    QuerySnapshot result = await userCollection.where('pesel', isEqualTo: pesel).get();
    List <DocumentSnapshot> documents = result.docs;
    return documents.length;
  }

  Future checPhone(String phone) async {
    QuerySnapshot result = await userCollection.where('phoneNumber', isEqualTo: phone).get();
    List <DocumentSnapshot> documents = result.docs;
    return documents.length;
  }
}