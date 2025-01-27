import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CRUDService {
  User? user = FirebaseAuth.instance.currentUser;

// add new contacts to firestore
  Future addNewContacts(String name, String phone, String email, String note) async {
    Map<String, dynamic> data = {"name": name, "email": email, "phone": phone, "note" : note};
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .collection("contacts")
          .add(data);
      print("Document Added");
    } catch (e) {
      print(e.toString());
    }
  }

  // read documents inside firestore
  Stream<QuerySnapshot> getContacts({String? searchQuery}) async* {
    var contactsQuery = FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .collection("contacts")
        .orderBy("name");

    // a filter to perfom search
    if (searchQuery != null && searchQuery.isNotEmpty) {
      String searchEnd = searchQuery + "\uf8ff";
      contactsQuery = contactsQuery.where("name",
          isGreaterThanOrEqualTo: searchQuery, isLessThan: searchEnd);
    }

    var contacts = contactsQuery.snapshots();
    yield* contacts;
  }

  // update a contact
  Future updateContact(
      String name, String phone, String email,String note, String docID) async {
    Map<String, dynamic> data = {"name": name, "email": email, "phone": phone, "note" : note};
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .collection("contacts")
          .doc(docID)
          .update(data);
      print("Document Updated");
    } catch (e) {
      print(e.toString());
    }
  }

  // delete contact from firestore
  Future deleteContact(String docID) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .collection("contacts")
          .doc(docID)
          .delete();
      print("Contact Deleted");
    } catch (e) {
      print(e.toString());
    }
  }

  Future addNewAppointment(String name,String content, String time, String date) async {
    Map<String, dynamic> appointment = {"name": name,"content": content, "time": time, "date": date,};
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .collection("appointment")
          .add(appointment);
      print("Document Added");
    } catch (e) {
      print(e.toString());
    }
  }
  Stream<QuerySnapshot> getAppointments({String? searchQuery}) async* {
    var contactsQuery = FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .collection("appointment")
        .orderBy("name");

    // a filter to perfom search
    if (searchQuery != null && searchQuery.isNotEmpty) {
      String searchEnd = searchQuery + "\uf8ff";
      contactsQuery = contactsQuery.where("name",
          isGreaterThanOrEqualTo: searchQuery, isLessThan: searchEnd);
    }

    var appointments = contactsQuery.snapshots();
    yield* appointments;
  }

  // Future updateAppointment(
  //     String name, String content, String time,String date, String docID) async {
  //   Map<String, dynamic> data = {"name": name, "content": content, "time": time, "date" : date};
  //   try {
  //     await FirebaseFirestore.instance
  //         .collection("users")
  //         .doc(user!.uid)
  //         .collection("appointment")
  //         .doc(docID)
  //         .update(data);
  //     print("Appointment Updated");
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }
  // Future deleteAppointment(String docID) async {
  //   try {
  //     await FirebaseFirestore.instance
  //         .collection("users")
  //         .doc(user!.uid)
  //         .collection("appointment")
  //         .doc(docID)
  //         .delete();
  //     print("Appointment Deleted");
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }
}
