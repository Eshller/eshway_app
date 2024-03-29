// ignore_for_file: deprecated_member_use

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:caffae_app/models/ModelProvider.dart';
import 'package:caffae_app/src/Global/Export/export.dart';
import 'package:caffae_app/src/Global/providers/user_provider.dart';
import 'package:file_picker/file_picker.dart';

final AmplifyLogger _logger = AmplifyLogger('MyStorageApp');

final profile = Provider((ref) => ProfileRepository(ref: ref));

class ProfileRepository extends ChangeNotifier {
  ProviderRef ref;

  ProfileRepository({required this.ref});
  bool _loading = false;
  String _userId = '';

  bool _logout = false;

  bool get logout => _logout;

  set logout(bool value) {
    _logout = value;
    notifyListeners();
  }

  String get userId => _userId;

  set userId(String value) {
    _userId = value;
    notifyListeners();
  }

  // String _profilePic = "";
  String _profilePicKey = "";

  String get profilePicKey => _profilePicKey;

  set profilePicKey(String value) {
    _profilePicKey = value;
    notifyListeners();
  }

  // String get profilePic => _profilePic;

  // set profilePic(String value) {
  //   _profilePic = value;
  //   notifyListeners();
  // }

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void showInSnackBar(BuildContext context, String value) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        value,
        textAlign: TextAlign.center,
        style: const TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
      ),
    ));
  }

  // upload a file to the S3 bucket
  Future<String> uploadFile({
    required FilePickerResult result,
    required BuildContext context,
  }) async {
    final platformFile = result.files.single;

    try {
      Map<String, String> metadata = <String, String>{};
      metadata['name'] = "user_$uuid";

      metadata['desc'] = 'A profile picture ';
      S3UploadFileOptions options = S3UploadFileOptions(
          accessLevel: StorageAccessLevel.guest, metadata: metadata);
      StorageUploadFileResult res = await Amplify.Storage.uploadFile(
        options: options,
        localFile: AWSFile.fromStream(
          platformFile.readStream!,
          size: platformFile.size,
        ),
        key: platformFile.name,
        onProgress: (p) =>
            _logger.debug('Uploading: ${p.transferredBytes}/${p.totalBytes}'),
      ).result;

      StorageItem item = res.uploadedItem;

      String key = item.key;

      final result = await Amplify.Storage.getUrl(
        key: key,
        /*options: const StorageGetUrlOptions(

        ),*/
      ).result;
      final url = result.url.toString();

      return url;
    } on StorageException catch (e) {
      if (context.mounted) {
        showInSnackBar(context, e.message);
      }

      _logger.error('Error uploading file - ${e.message}');
      return '';
    }
  }

  Future<bool> saveUserProfileDetails({
    required String userID,
    required String userName,
    required BuildContext context,
    required String profilePic,
  }) async {
    loading = true;
    // UserModel newUser = UserModel(
    //   id: userID,
    //   username: userName,
    //   photoUrl: profilePic,
    //   // email: email,
    //   isVerified: true,
    // );

    try {
      List<UserModel> users = await Amplify.DataStore.query(UserModel.classType,
          where: UserModel.ID.eq(userId));
      UserModel userModel = users.first;
      userModel = userModel.copyWith(
        username: userName,
        photoUrl: profilePic,
        isVerified: true,
      );
      await Amplify.DataStore.save(userModel).then((_) => loading = false);
      ref.watch(userProvider).setUserFromModel(userModel);

      return true;
    } on StorageException catch (e) {
      if (context.mounted) {
        snackbar(context: context, content: e.message);
      }
      return false;
    }
  }

  Future<bool> signOut({required BuildContext context}) async {
    try {
      Amplify.Auth.signOut();
      return logout = true;
    } on AuthException catch (e) {
      debugPrint(e.message);
      if (context.mounted) {
        showInSnackBar(context, e.message);
      }
      return logout = false;
    }
  }

  Future<bool> updateUserProfileDetails({
    required String userId,
    required BuildContext context,
    required List<String> listExplore,
  }) async {
    loading = true;

    // Query for user
    try {
      List<UserModel> users = await Amplify.DataStore.query(UserModel.classType,
          where: UserModel.ID.eq(userId));

      // Should only be one
      UserModel user = users.first;

      user = user.copyWith(
        listExplore: listExplore,
      );

      // Save updated user
      await Amplify.DataStore.save(user);
      ref.watch(userProvider).setUserFromModel(user);

      loading = false;
      return true;
    } on AuthException catch (e) {
      if (context.mounted) {
        showInSnackBar(context, e.message);
      }
      debugPrint(e.toString());
      return false;
    }
  }

// fethc current user based on id
  Future<UserModel> getCurrentUser({
    required String userId,
    required BuildContext context,
  }) async {
    UserModel? userModel;
    try {
      userModel = (await Amplify.DataStore.query(UserModel.classType,
              where: UserModel.ID.eq(userId)))
          .first;
      return userModel;
    } catch (e) {
      if (context.mounted) {
        snackbar(context: context, content: e.toString());
      }
    }
    return userModel!;
  }
}
