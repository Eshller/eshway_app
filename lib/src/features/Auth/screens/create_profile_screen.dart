import 'dart:io';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:caffae_app/models/ModelProvider.dart';
import 'package:caffae_app/src/Global/Export/export.dart';
import 'package:caffae_app/src/Global/Utils/image_picker.dart';
import 'package:caffae_app/src/features/Auth/screens/personalization_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UserInformationScreen extends ConsumerStatefulWidget {
  final AuthUser authUser;
  static const String routeName = '/user-information';
  const UserInformationScreen({Key? key, required this.authUser})
      : super(key: key);

  @override
  ConsumerState<UserInformationScreen> createState() =>
      _UserInformationScreenState();
}

class _UserInformationScreenState extends ConsumerState<UserInformationScreen> {
  final TextEditingController nameController = TextEditingController();
  FilePickerResult? image;
  bool isLoading = false;
  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
  }

  void selectImage() async {
    image = await pickImageFromGallery(context);
    setState(() {});
  }

  void addUserDataToAws() {
    if (image == null) {
      return snackbar(
          context: context, content: 'Please select profile picture');
    }
    if (nameController.text.isEmpty) {
      return snackbar(context: context, content: 'Please Enter your name');
    }

    ref
        .watch(profile)
        .uploadFile(result: image!, context: context)
        .then((value) {
      UserModel authModel = UserModel(
        username: nameController.text.trim(),
        phoneNumber: widget.authUser.username,
        id: widget.authUser.userId,
        isVerified: true,
        photoUrl: value,
        isGuru: false,
        pushToken: '',
        role: '',
        documentId: '',
        listExplore: [],
      );
      Amplify.DataStore.save(authModel)
          .then((value) => isLoading = false)
          .then((value) async {
        var box = await Hive.openBox<UserModel>('userBox');
        await box.put('currentUser', authModel);
        if (context.mounted) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PersonalizationScreen(
                authUserId: widget.authUser.userId,
              ),
            ),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    //final loading = ref.watch(authChangeNotifierProvider.notifier).isLoading;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kBackGroundColors,
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              SizedBox(
                  height: 96, child: Image.asset('assets/images/logo.png')),
              const Text(
                'Add your information',
                textAlign: TextAlign.center,
                style: TextStyle(color: whiteColor),
              ),
            ],
          ),
          centerTitle: true,
        ),
        backgroundColor: kBackGroundColors,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    image == null
                        ? const CircleAvatar(
                            backgroundImage: NetworkImage(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-3VQz6KM-1laTLb_oCNKBdJNt609eeeDSA7d3VZo&s',
                            ),
                            radius: 64,
                          )
                        : Image.file(
                            File(image!.files.single.path!),
                          ),
                    Positioned(
                      bottom: -10,
                      left: 80,
                      child: IconButton(
                        onPressed: selectImage,
                        icon: const Icon(
                          Icons.add_a_photo,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 14,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 39),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: ReusableText(
                      text: 'Enter your name',
                      textStyle: appStyle(
                        fw: FontWeight.w500,
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: size.width * 0.85,
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    style: const TextStyle(color: whiteColor),
                    decoration: inputDecoration(),
                    controller: nameController,
                    maxLines: 1,
                    obscureText: false,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: addUserDataToAws,
                  child: GlobalContainer(
                    height: 40,
                    borderWidth: 1.1,
                    width: MediaQuery.of(context).size.width / 2.1,
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                    child: ReusableText(
                      text: 'Save your information',
                      textStyle: appStyle(
                        fw: FontWeight.w500,
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration inputDecoration() {
    return InputDecoration(
      fillColor: kBackGroundColors,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: const BorderSide(color: whiteColor, width: 0.8),
      ),
      errorBorder: const OutlineInputBorder(
        borderSide:
            BorderSide(color: Color.fromARGB(255, 219, 35, 35), width: 1.1),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
            color: Color.fromARGB(255, 65, 56, 56), width: 1.1),
        borderRadius: BorderRadius.circular(7.0),
      ),
      focusColor: const Color.fromARGB(255, 221, 197, 197),
      contentPadding:
          const EdgeInsets.symmetric(vertical: 1.0, horizontal: 15.0),
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white, width: 0.1),
        borderRadius: BorderRadius.circular(7.0),
      ),
    );
  }
}
