import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:caffae_app/src/Global/Export/export.dart';
import 'package:caffae_app/src/Global/providers/user_provider.dart';
import 'package:caffae_app/src/features/Auth/screens/create_profile_screen.dart';
import 'package:caffae_app/src/features/Auth/screens/is_guru_check.dart';
import 'package:caffae_app/src/features/Auth/screens/login_screen.dart';
import 'package:caffae_app/src/features/Auth/screens/personalization_screen.dart';

class CheckGuruScreen extends ConsumerStatefulWidget {
  const CheckGuruScreen({super.key});

  @override
  ConsumerState<CheckGuruScreen> createState() => _CheckGuruScreenState();
}

class _CheckGuruScreenState extends ConsumerState<CheckGuruScreen> {
  String? currentUserId;

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  Future<void> getCurrentUser() async {
    currentUserId =
        await ref.watch(authRepositoryProvider).retrieveCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authRepositoryProvider);
    return FutureBuilder<bool>(
      // Check if the user is signed in
      future: auth.isLoggedIn(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Show loading indicator while checking authentication status
        } else {
          if (snapshot.hasData && snapshot.data == true) {
            return FutureBuilder<bool>(
              future: auth.isGuru(currentUserId!),
              builder: (context, isGuruSnapshot) {
                if (isGuruSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (isGuruSnapshot.hasData &&
                    isGuruSnapshot.data == true) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GuruHomeScreen(),
                      ),
                    );
                  });
                  return Container(); // Placeholder widget (not rendered).
                } else {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StudentHome(
                          userId: currentUserId!,
                        ),
                      ),
                    );
                  });
                  return Container(); // Placeholder widget (not rendered).
                }
              },
            );
            //return HomeScreen(); // Navigate to the home screen if signed in
          } else {
            return const LoginPhoneScreen(); // Navigate to the login screen if not signed in
          }
        }
      },
    );
  }
}

class IsGuru extends ConsumerStatefulWidget {
  final AuthUser authUser;

  const IsGuru({Key? key, required this.authUser}) : super(key: key);

  @override
  ConsumerState<IsGuru> createState() => _IsGuruState();
}

class _IsGuruState extends ConsumerState<IsGuru> {
  @override
  Widget build(BuildContext context) {
    final isGuruProvider = ref.watch(userFromHiveProvider);
    final userData = isGuruProvider.user;

    if (userData!.isGuru!) {
      return const GuruHomeScreen();
    } else {
      if (userData.username!.isEmpty) {
        return UserInformationScreen(authUser: widget.authUser);
      } else {
        if (userData.listExplore!.isEmpty) {
          return PersonalizationScreen(authUserId: widget.authUser.userId);
        } else {
          return const StudentHome(userId: '');
        }
      }
    }
  }
}
