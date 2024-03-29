import 'dart:io';

import 'package:caffae_app/src/Global/Export/export.dart';

final guruRepository = Provider(((ref) => GuruRepository()));

class GuruRepository {
  Future fetchAllUsers() async {
    try {} catch (e) {
      return [];
    }
  }

  Stream getGuruInformation() async* {}

  Future addGuruInformation() async {
    // try {} catch (e) {}
  }

  Future<bool> updateUserName(
      {required String username, required BuildContext context}) async {
    try {
      return true;
    } catch (e) {
      if (context.mounted) {}
      debugPrint(e.toString());
      return false;
    }
  }

  Future updateProfilePhoto({
    required File profilePhoto,
    required BuildContext context,
  }) async {
    try {} catch (e) {
      if (context.mounted) {
        snackbar(context: context, content: e.toString());
      }
      debugPrint(e.toString());
    }
  }

  Future updateFeesCharge({required BuildContext context}) async {
    try {} catch (e) {
      if (context.mounted) {
        snackbar(context: context, content: e.toString());
      }

      debugPrint(e.toString());
    }
  }

  Future getCurrentGuruData() async {}

  Future<void> addReviewsOnFirebase({
    required String message,
    required String senderId,
    required String recieverId,
    required int? rating,
  }) async {}

  Future fetchAllReviews({
    required String receiverId,
  }) async {
    try {} catch (e) {
      debugPrint(e.toString());
    }
    return [];
  }

  // Assuming you have already set up your Firebase instance and Firestore collection

// Function to calculate average total rating based on receiverId
  Future calculateAverageRating(String receiverId) async {}
}
