import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('myUser');
  final CollectionReference doctorsCollection =
      FirebaseFirestore.instance.collection('doctors');
  final CollectionReference specializatonCollection =
      FirebaseFirestore.instance.collection('specialization');
  final CollectionReference appointmentCollection =
      FirebaseFirestore.instance.collection('appointment');

  Future updateUserData(String userName, String uid, String phoneNumber,
      String email, String pesel, String surname) async {
    return await userCollection.doc(uid).set({
      'name': userName,
      'surname': surname,
      'userId': uid,
      'phoneNumber': phoneNumber,
      'email': email,
      'pesel': pesel,
      'role': 'user',
      'doctor_id': '',
    });
  }

  Future updateDoctorsData(String userName, String doctorid, String phoneNumber,
      String surname) async {
    return await doctorsCollection.doc(doctorid).set({
      'name': userName,
      'surname': surname,
      'doctorId': doctorid,
      'phoneNumber': phoneNumber,
    });
  }

  Future updateSpecialization(String specializationName, String specid) async {
    return await specializatonCollection.doc(specid).set({
      'specializationId': specid,
      'specializationName': specializationName,
    });
  }

  Future checPeselNumber(String pesel) async {
    QuerySnapshot result =
        await userCollection.where('pesel', isEqualTo: pesel).get();
    List<DocumentSnapshot> documents = result.docs;
    return documents.length;
  }

  Future checPhone(String phone) async {
    QuerySnapshot result =
        await userCollection.where('phoneNumber', isEqualTo: phone).get();
    List<DocumentSnapshot> documents = result.docs;
    return documents.length;
  }

  Future makeAnAppointment(String user_id, String appointment_id) async {
    return await appointmentCollection.doc(appointment_id).update({
      'user_id': user_id,
      'is_free': false,
    });
  }

  Future cancelAnAppointment(String appointment_id) async {
    return await appointmentCollection.doc(appointment_id).update({
      'user_id': null,
      'is_free': true,
    });
  }

  Future addNewAppointmentToDatabase(
      String appointment_id,
      String doctor_id,
      String user_id,
      String prescription_id,
      bool confirmed,
      bool reminded,
      bool is_free,
      bool done,
      String issue,
      DateTime appointment_date,
      DateTime appointment_date_end,
      DateTime created_date) async {
    return await appointmentCollection.doc(appointment_id).set({
      'user_id': user_id,
      'appointment_id': appointment_id,
      'doctor_id': doctor_id,
      'prescription_id': prescription_id,
      'confirmed': confirmed,
      'reminded': reminded,
      'done': done,
      'issue': issue,
      'appointment_date': appointment_date,
      'appointment_date_end': appointment_date_end,
      'created_date': created_date,
      'is_free': is_free,
    });
  }
}
