import 'dart:io';

import 'package:caffae_app/src/Global/Export/export.dart';

final profileServiceProvider = Provider((ref) => ProfileService());

class ProfileService {
  Future<void> uploadDocument({
    required File documentId,
    required ProviderRef ref,
    required BuildContext context,
  }) async {
    try {} catch (e) {
      if (context.mounted) {}
      debugPrint(e.toString());
    }
  }

  Future<void> updateUserName({
    required String userName,
    required ProviderRef ref,
    required BuildContext context,
  }) async {
    try {} catch (e) {
      if (context.mounted) {
        snackbar(context: context, content: e.toString());
      }
      debugPrint(e.toString());
    }
  }

  Future<void> updateUserProfile({
    required BuildContext context,
    required ProviderRef ref,
    required File? profilePic,
  }) async {
    try {} catch (e) {
      if (context.mounted) {
        snackbar(context: context, content: e.toString());
      }
      debugPrint(e.toString());
    }
  }
}
