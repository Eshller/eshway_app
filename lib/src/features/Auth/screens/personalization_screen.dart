import 'package:caffae_app/models/ModelProvider.dart';
import 'package:caffae_app/src/Global/Export/export.dart';
import 'package:caffae_app/src/Global/Utils/personalization_model.dart';
import 'package:caffae_app/src/features/Auth/screens/is_guru_check.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PersonalizationScreen extends ConsumerStatefulWidget {
  final String authUserId;
  static const String routeName = 'personalization-screen';
  const PersonalizationScreen({super.key, required this.authUserId});

  @override
  ConsumerState<PersonalizationScreen> createState() =>
      _PersonalizationScreenState();
}

class _PersonalizationScreenState extends ConsumerState<PersonalizationScreen> {
  List<String> listExplore = [];
  @override
  Widget build(BuildContext context) {
    final listExp = ref.watch(profile);
    return Scaffold(
      backgroundColor: kBackGroundColors,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 169,
                    width: 169,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/caffae.png'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ReusableText(
                    text:
                        'Explore a world of personalized intersect tailored to your unique preferences',
                    align: TextAlign.center,
                    textStyle: appStyle(
                      fw: customFont500Weight,
                      fontSize: 14,
                      color: whiteColor,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 20, top: 30),
                child: GridView.builder(
                  itemCount: per.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 13,
                    crossAxisCount: 3,
                    childAspectRatio: 2.5,
                  ),
                  itemBuilder: (context, index) {
                    final item = per[index].name;
                    final isSelected = listExplore.contains(item);
                    return GestureDetector(
                      onTap: () async {
                        setState(() {
                          if (isSelected) {
                            listExplore.remove(item);
                          } else {
                            listExplore.add(item);
                          }
                        });
                      },
                      child: Container(
                        width: 120,
                        alignment: Alignment.center,
                        // borderRadius: BorderRadius.circular(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: isSelected
                              ? const Color.fromARGB(255, 94, 103, 211)
                              : blackColor,
                        ),
                        child: ReusableText(
                          text: per[index].name,
                          textStyle: appStyle(
                            fw: customFont500Weight,
                            fontSize: 12,
                            color: whiteColor,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              InkWell(
                hoverColor: Colors.red,
                onTap: () async {
                  if (listExplore.isEmpty) {
                    return snackbar(
                        context: context,
                        content: 'Please select your preferences at least one');
                  }

                  ref
                      .watch(profile)
                      .updateUserProfileDetails(
                        userId: widget.authUserId,
                        listExplore: listExplore,
                        context: context,
                      )
                      .then((value) async {
                    if (value) {
                      var box = await Hive.openBox<UserModel>('userBox');
                      UserModel? storedUser = box.get('currentUser');
                      if (storedUser != null) {
                        try {
                          UserModel userModel =
                              UserModel(listExplore: listExplore);
                          await box.put('currentUser',
                              userModel); // Save the updated storedUser to Hive

                          if (context.mounted) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => StudentHome(
                                  userId: widget.authUserId,
                                ),
                              ),
                              (route) => false,
                            );
                          }
                        } catch (e) {
                          if (context.mounted) {
                            snackbar(
                                context: context,
                                content: 'Something went wrong');
                          }

                          // Handle any errors that might occur during the update process
                        }
                      }
                    } else {
                      snackbar(
                          context: context, content: 'Something went wrong');
                    }
                    // student home screen
                  });
                },
                child: GlobalContainer(
                  height: 34,
                  width: 100,
                  borderWidth: 1.1,
                  color: const Color.fromARGB(255, 6, 234, 250),
                  borderRadius: BorderRadius.circular(19),
                  child: listExp.loading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ReusableText(
                              text: 'Next',
                              textStyle: appStyle(
                                fw: customFont500Weight,
                                fontSize: 13,
                                color: whiteColor,
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward,
                              color: whiteColor,
                            )
                          ],
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
