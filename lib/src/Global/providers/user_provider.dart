// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:caffae_app/models/ModelProvider.dart';
import 'package:caffae_app/src/Global/Export/export.dart';
import 'package:hive_flutter/hive_flutter.dart';

final userProvider =
    ChangeNotifierProvider<UserProvider>((ref) => UserProvider(ref: ref));

class UserProvider extends ChangeNotifier {
  final ChangeNotifierProviderRef ref;
  UserProvider({
    required this.ref,
  });

  UserModel _user = UserModel(
    id: '',
    username: '',
    isGuru: false,
    documentId: '',
    phoneNumber: '',
    role: '',
    photoUrl: '',
    listExplore: [],
    createdAt: TemporalDateTime.now(),
    isVerified: false,
    pushToken: '',
  );
  UserModel get user => _user;

  void setUserFromModel(UserModel user) {
    _user = user;
    final hiveProvider = ref.read(userFromHiveProvider);
    hiveProvider.updateUserInHive(user);
    notifyListeners();
  }
}

class UserModelHiveProvider extends ChangeNotifier {
  final Box<UserModel> _userBox;

  UserModelHiveProvider(this._userBox);

  UserModel? get user {
    return _userBox.get("current_user");
  }

  void updateUserInHive(UserModel updatedUser) {
    _userBox.put("current_user", updatedUser);
    notifyListeners();
  }
}

final userFromHiveProvider = Provider<UserModelHiveProvider>((ref) {
  final box = Hive.box<UserModel>('user');

  return UserModelHiveProvider(box);
});
