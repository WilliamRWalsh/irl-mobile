// @dart=2.12
// ignore: import_of_legacy_library_into_null_safe
import 'package:cloud_firestore/cloud_firestore.dart';

class CaloriesFirebase {
  void deleteCalories(
    String userId,
    String id,
  ) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('calories')
        .doc(id)
        .delete();
  }
}
