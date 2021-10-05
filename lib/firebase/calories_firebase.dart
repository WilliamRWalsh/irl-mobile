import 'package:cloud_firestore/cloud_firestore.dart';

class CaloriesFirebase {
  void deleteCalories(String id) {
    FirebaseFirestore.instance.collection('calories').doc(id).delete();
  }
}
