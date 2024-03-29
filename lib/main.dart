import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:caffae_app/src/Global/Export/export.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'amplifyconfiguration.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initializes Hive with a valid directory in your app files
  await Hive.initFlutter();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  // This widget is the root of your application.a
  String? currentUserId;

  @override
  void initState() {
    getCurrentUser();
    super.initState();
    _configureAmplify();
  }

  Future<void> getCurrentUser() async {
    currentUserId =
        await ref.watch(authRepositoryProvider).retrieveCurrentUser();
  }

  void _configureAmplify() async {
    try {
      await Amplify.addPlugin(AmplifyAuthCognito());
      Amplify.addPlugin(AmplifyStorageS3());
      await Amplify.configure(amplifyconfig);
    } on Exception catch (e) {
      debugPrint('Error configuring Amplify: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Caffae',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: HexColor('#D9D9D9'),
      ),

      home: const SplashScreen(),
      // const SignUpScreen(),
    );
  }
}
