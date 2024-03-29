import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:caffae_app/models/ModelProvider.dart';
import 'package:caffae_app/src/Global/Export/export.dart';
import 'package:caffae_app/src/Global/providers/user_provider.dart';

final homeController = Provider((ref) => HomeAuthRepository(ref: ref));

class HomeAuthRepository {
  ProviderRef ref;
  HomeAuthRepository({required this.ref});

  Future<UserModel?> getCurrentUser() async {
    UserModel? userModel;

    try {
      AuthUser res = await Amplify.Auth.getCurrentUser();

      List<UserModel> userData = await Amplify.DataStore.query(
          UserModel.classType,
          where: UserModel.ID.eq(res.userId));

      if (userData.isNotEmpty) {
        userModel = UserModel.fromJson(userData.first.toJson());
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return userModel;
  }

  Stream<UserModel?> getSignedInGuru() {
    return Stream.fromFuture(getCurrentUser());
  }

  Stream<UserModel> getSignedInUser() {
    return _getSignedInUserFromDataSource().asStream();
  }

  // Private method to get user from DataStore
  Future<UserModel> _getSignedInUserFromDataSource() async {
    UserModel? userModel;
    try {
      AuthUser user = await Amplify.Auth.getCurrentUser();
      List<UserModel> data = await Amplify.DataStore.query(UserModel.classType,
          where: UserModel.ID.eq(user.userId));
      if (data.isNotEmpty) {
        userModel = UserModel.fromJson(data.first.toJson());
      }
      return userModel!;

      // return data.isEmpty ? null : UserModel.fromJson(data.first);
    } catch (error) {
      debugPrint(error.toString());
      return userModel!;
    }
  }

  Future<List<GuruModel>> getRecentGuru() async {
    List<GuruModel> gurus = [];
    try {
      // final userProvders = ref.watch(userProvider);
      final isGuruProvider = ref.watch(userFromHiveProvider);
      // final userData = isGuruProvider.user;

      // final currentUser = await Amplify.Auth.getCurrentUser();
      // final userId = currentUser.userId;

      // final userQuery = await Amplify.DataStore.query(
      //   UserModel.classType,
      //   where: UserModel.ID.eq(userId),
      // );

      // if (userQuery.isNotEmpty) {
      //   userModel = userQuery.first;
      if (isGuruProvider.user!.listExplore != null) {
        List<String> interests = isGuruProvider.user!.listExplore!
            .map((explore) => explore.toString())
            .toList();
        // List<GuruModel> tempGurus = [];
        for (var interest in interests) {
          final guruQuery = await Amplify.DataStore.query(
            GuruModel.classType,
            where: GuruModel.SPECIALIST.eq(interest),
          );
          gurus.addAll(guruQuery);
        }
      }
      gurus = gurus.toSet().toList();
      return gurus;
      //   if (userModel.listExplore != null) {
      //     List<String> interests = userModel.listExplore!
      //         .map((explore) => explore.toString())
      //         .toList();

      //     List<GuruModel> tempGurus = [];
      //     for (var interest in interests) {
      //       final guruQuery = await Amplify.DataStore.query(
      //         GuruModel.classType,
      //         where: GuruModel.SPECIALIST.eq(interest),
      //       );
      //       tempGurus.addAll(guruQuery);
      //     }

      //     // Remove duplicates if needed
      //     gurus = tempGurus.toSet().toList();
      //   }
      // }
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }
}
