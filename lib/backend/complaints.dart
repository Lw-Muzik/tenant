import '/exports/exports.dart';

class Complaints {
  static Future<DocumentReference<Map<String, dynamic>>> raiseComplaint(
      var complaint) async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    return await db.collection("complaints").add(complaint);
  }
}
