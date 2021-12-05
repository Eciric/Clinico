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
  final CollectionReference prescriptionCollection =
      FirebaseFirestore.instance.collection('prescription');

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
      String unique_id,
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
    return await appointmentCollection.doc(unique_id).set({
      'user_id': user_id,
      'appointment_id': unique_id,
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

  Future checkIfDateIsFree(
      DateTime start, DateTime end, String doctor_id) async {
    QuerySnapshot result = await appointmentCollection
        .where('doctor_id', isEqualTo: doctor_id)
        .get();
    List<DocumentSnapshot> documents = result.docs;
    for (var doc in documents) {
      //print(doc.get("appointment_id"));
      Timestamp ts_currentStart = doc.get("appointment_date");
      Timestamp ts_currentEnd = doc.get("appointment_date_end");
      DateTime currentStart = ts_currentStart.toDate();
      DateTime currentEnd = ts_currentEnd.toDate();
      //print("Start: " + start.toString());
      //print("End: " + end.toString());

      //print("StartC: " + currentStart.toString());
      //print("EndC: " + currentEnd.toString());
      if (currentStart.isBefore(start) && currentEnd.isAfter(start)) {
        return false;
      }
      if (currentStart.isBefore(end) && currentEnd.isAfter(end)) {
        return false;
      }
    }
    return true;
  }

  Future getUsersDoctorId(String user_id) async {
    var result = await userCollection.where('userId', isEqualTo: user_id).get();
    return result.docs[0].get('doctor_id');
  }

  Future getUsersNameAndSurnameByID(String user_id) async {
    if (user_id == null) {
      return "Appointment isn't booked";
    }
    var result = await userCollection.where('userId', isEqualTo: user_id).get();
    if (result.docs.length > 0) {
      String name =
          result.docs[0].get('name') + " " + result.docs[0].get('surname');
      return name;
    }
    return "Appointment isn't booked";
  }

  Future finishAppointment(String appointment_id) async {
    return await appointmentCollection.doc(appointment_id).update({
      'done': true,
    });
  }

  Future addPrescription(
      String prescription_id, String diagnosis, String text) async {
    return await prescriptionCollection.doc(prescription_id).set({
      'prescription_id': prescription_id,
      'diagnosis': diagnosis,
      'description': text,
    });
  }

  Future modifyPrescriptionInAppointment(
      String prescription_id, String appointment_id) async {
    return await appointmentCollection
        .doc(appointment_id)
        .update({'prescription_id': prescription_id});
  }
}
