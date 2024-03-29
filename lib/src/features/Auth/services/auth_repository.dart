// ignore_for_file: deprecated_member_use

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:caffae_app/models/ModelProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository.instance());

class AuthRepository extends ChangeNotifier {
  AuthRepository.instance();

  bool _isSignedIn = false;
  bool _loading = false;
  bool _isOTPSignUpComplete = false;
  bool _isSignUpComplete = false;
  bool get isSignedIn => _isSignedIn;
  bool get isSignUpComplete => _isSignUpComplete;

  set isSignUpComplete(bool value) {
    _isSignUpComplete = value;
    notifyListeners();
  }

  set isSignedIn(bool value) {
    _isSignedIn = value;
    notifyListeners();
  }

  showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  bool get isOTPSignUpComplete => _isOTPSignUpComplete;

  set isOTPSignUpComplete(bool value) {
    _isOTPSignUpComplete = value;
    notifyListeners();
  }

  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

//! retive the current user attributes
  Future<void> retrieveUserAttributes({required BuildContext context}) async {
    try {
      var res = await Amplify.Auth.fetchUserAttributes();
      for (var element in res) {
        debugPrint('key: ${element.userAttributeKey}; value: ${element.value}');
      }
    } on AuthException catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.message);
      }
      debugPrint(e.message);
    }
  }

  //! check the type of user
  Future<bool> isGuru(String userId) async {
    try {
      // Query for the user with the specified ID
      final users = await Amplify.DataStore.query(
        UserModel.classType,
        where: UserModel.ID.eq(userId),
      );

      if (users.isNotEmpty) {
        // Check the attributes to determine if the user is a "Guru"
        final UserModel user = users.first;

        // Example: Check if the user has the "isGuru" attribute set to true
        if (user.isGuru == true) {
          return true; // User is a "Guru"
        } else {
          return false; // User is not a "Guru"
        }
      } else {
        // User not found
        return false;
      }
    } catch (e) {
      debugPrint('Error checking if user is a Guru: $e');
      return false; // Return false if an error occurs
    }
  }

//! to check the user isLogin
  Future<bool> isLoggedIn() async {
    try {
      // Check current authentication session
      final session = await Amplify.Auth.fetchAuthSession(
        options: const CognitoSessionOptions(getAWSCredentials: true),
      );

      return session
          .isSignedIn; // Return true if the user is signed in, else false
    } catch (e) {
      debugPrint('Error checking authentication status: $e');
      return false; // Return false if an error occurs
    }
  }

//! retrive the current user
  Future<String> retrieveCurrentUser() async {
    AuthUser authUser = await Amplify.Auth.getCurrentUser();
    debugPrint(authUser.userId);
    return authUser.userId;
  }

  Future<AuthUser> currentUser() async {
    AuthUser authUser = await Amplify.Auth.getCurrentUser();
    debugPrint(authUser.userId);
    return authUser;
  }

//! to register a user
  Future<bool?> register(
      {required String phoneNumber,
      required String password,
      required String confirmPassword,
      required String email,
      required BuildContext context}) async {
    try {
      //   print(phoneNumber);/**/
      loading = false;
      SignUpResult res = await Amplify.Auth.signUp(
        username: phoneNumber,
        password: password,
        options: CognitoSignUpOptions(
          userAttributes: {
            // CognitoUserAttributeKey.phoneNumber: '+919079620861',
            CognitoUserAttributeKey.email: email
          },
        ),
      );

      isSignUpComplete = res.isSignUpComplete;
      loading = false;

      // send to otp verification screen
      return isSignUpComplete;
    } on AuthException catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.message);
      }
      debugPrint(e.message);
      loading = false;
      return isSignUpComplete;
    }
  }

//! login the user
  Future<bool> login({
    required String phoneNumber,
    required String password,
    required BuildContext context,
  }) async {
    loading = true;

    try {
      SignInResult res =
          await Amplify.Auth.signIn(username: phoneNumber, password: password);
// set the result of user isSiginedIn
      isSignedIn = res.isSignedIn;
      loading = false;
      return isSignedIn;
    } on AuthException catch (e) {
      debugPrint(e.message);
      if (context.mounted) {
        showSnackBar(context, e.message);
      }
      loading = false;
      return isSignedIn;
    }
  }

  //! for confirm the phoneNumber
  Future<bool> confirmLogin({
    required BuildContext context,
    required String otp,
  }) async {
    loading = true;
    try {
      SignInResult res =
          await Amplify.Auth.confirmSignIn(confirmationValue: otp);
      isSignedIn = res.isSignedIn;
      loading = false;

      return isSignedIn;
    } on AuthException catch (e) {
      debugPrint(e.message);
      if (context.mounted) {
        showSnackBar(context, e.message);
      }
      loading = false;
      return isSignedIn;
    }
  }

//! for confirm signup
  Future<bool> confirmPhoneNumber({
    required String confirmationCode,
    required String phoneNumber,
    required BuildContext context,
    required String password,
  }) async {
    loading = true;
    try {
      SignUpResult res = await Amplify.Auth.confirmSignUp(
        username: phoneNumber,
        confirmationCode: confirmationCode,
      );
      loading = false;
      return res.isSignUpComplete;
    } on AuthException catch (e) {
      debugPrint(e.message);
      if (context.mounted) {
        showSnackBar(context, e.message);
      }
      loading = false;
      return isSignUpComplete;
    }
  }

  //! fetchAllUsers
  Future<void> fetchUserDetails(BuildContext context) async {
    try {
      // Get the currently signed-in user
      AuthUser authUser = await Amplify.Auth.getCurrentUser();

      // Fetch user attributes
      final result = await Amplify.Auth.fetchUserAttributes();
      // Loop through user attributes to retrieve phone number
      String phoneNumber = '';
      for (final attribute in result) {
        if (attribute.userAttributeKey.toString() == authUser.username) {
          phoneNumber = attribute.value ?? '';
          break;
        }
      }
      // Use the retrieved phone number or other user attributes as needed
      debugPrint('Phone Number: $phoneNumber');

      // Navigate to the desired screen or perform further actions with user details
      // ...
    } catch (e) {
      // Handle errors
      if (context.mounted) {
        debugPrint('Error fetching user details: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error fetching user details: $e')),
        );
      }
    }
  }
}
