import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:caffae_app/src/Global/Export/export.dart';
import 'package:caffae_app/src/features/Auth/screens/check_is_guru_screen.dart';
import 'package:caffae_app/src/features/Auth/screens/login_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  late Box userBox;
  late AuthUser authUser;

  Future<void> fetchCurrentUser() async {
    final currentUser = await ref.read(authRepositoryProvider).currentUser();
    // Assuming ref.read(authRepositoryProvider).currentUser() returns a Future<AuthUser>

    setState(() {
      authUser = currentUser;
    });
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () async {
      userBox = await Hive.openBox("isSignedIn");
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => userBox.get("isLogin", defaultValue: false)
                  ? IsGuru(
                      authUser: authUser,
                    )
                  : const LoginPhoneScreen()));
    });
  }

  void createBox() async {}

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(children: []),
    );
  }
}
