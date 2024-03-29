// ignore_for_file: deprecated_member_use, library_private_types_in_public_api

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';

class PhoneVerificationScreen extends StatefulWidget {
  const PhoneVerificationScreen({super.key});

  @override
  _PhoneVerificationScreenState createState() =>
      _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends State<PhoneVerificationScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _confirmationCodeController =
      TextEditingController();

/*  @override
  void initState() {
    super.initState();
    _initializeAmplify();
  }

  Future<void> _initializeAmplify() async {
    try {
      await Amplify.addPlugin(AmplifyAuthCognito());
      await Amplify.configure(amplifyconfig);
      print('Amplify initialized successfully');
    } catch (e) {
      print('Failed to initialize Amplify: $e');
    }
  }*/

  Future<void> _signInWithPhoneNumber() async {
    String phoneNumber = _phoneNumberController.text.trim();

    try {
      SignUpResult res = await Amplify.Auth.signUp(
        username: phoneNumber,
        password: 'Jacknd123@',
        options: CognitoSignUpOptions(
          userAttributes: {
            CognitoUserAttributeKey.phoneNumber: phoneNumber,
            CognitoUserAttributeKey.email: 'jackpkn07@gmail.com',
          },
        ),
      );
      debugPrint(res.nextStep.codeDeliveryDetails.toString());
      debugPrint(res.isSignUpComplete.toString());

      if (res.isSignUpComplete) {
        // Prompt user to enter confirmation code
        debugPrint('Confirmation code sent');
      } else {
        // This block executes if isSignUpComplete is false
        if (res.nextStep.codeDeliveryDetails != null) {
          // If code delivery details exist despite signup failure
          debugPrint('Code delivered but sign up failed');
        } else {
          debugPrint('Sign up failed');
        }
      }
    } catch (e) {
      debugPrint('Error signing up: $e');
    }
  }

  Future<void> _confirmPhoneNumber() async {
    String confirmationCode = _confirmationCodeController.text.trim();
    String phoneNumber = _phoneNumberController.text.trim();

    try {
      SignUpResult res = await Amplify.Auth.confirmSignUp(
        username: phoneNumber,
        confirmationCode: confirmationCode,
      );
      if (res.isSignUpComplete) {
        debugPrint('Phone number verified');
        // Proceed with your logic after phone number verification
      } else {
        debugPrint('Phone number verification failed');
      }
    } catch (e) {
      debugPrint('Error confirming phone number: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phone Verification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _phoneNumberController,
              decoration: const InputDecoration(labelText: 'Phone Number'),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _signInWithPhoneNumber,
              child: const Text('Sign Up with Phone Number'),
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: _confirmationCodeController,
              decoration: const InputDecoration(labelText: 'Confirmation Code'),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _confirmPhoneNumber,
              child: const Text('Confirm Phone Number'),
            ),
          ],
        ),
      ),
    );
  }
}
