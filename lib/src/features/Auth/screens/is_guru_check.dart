// ignore_for_file: depend_on_referenced_packages

import 'package:caffae_app/models/ModelProvider.dart';
import 'package:caffae_app/src/Global/Export/export.dart';
import 'package:caffae_app/src/Global/providers/user_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';

class GuruHomeScreen extends ConsumerStatefulWidget {
  const GuruHomeScreen({super.key});

  @override
  ConsumerState<GuruHomeScreen> createState() => _GuruHomeScreenState();
}

class _GuruHomeScreenState extends ConsumerState<GuruHomeScreen> {
  List<Widget> pages = [
    const GuruHomePage(),
    const GuruSearchPage(),
    const GuruBrowserPage(),
    const GuruMessagePage(),
    const GuruProfilePage(),
  ];

  int index = 0;
  @override
  Widget build(
    BuildContext context,
  ) {
    // final guruStream = ref.watch(guruStreamProvider);
    // final userStream = ref.watch(userDataAuthProvider);
    return Scaffold(
      backgroundColor: HexColor('#D9D9D9'),
      body: Stack(
        children: [
          pages[index],
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: CommonContainer(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          index = 0; // Switch to GuruHomePage
                        });
                      },
                      child: SvgPicture.asset(
                          'assets/svg/majesticons_home-line.svg'),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          index = 1; // Switch to GuruSearchPage
                        });
                      },
                      child: Image.asset('assets/images/search.png'),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          index = 2; // Switch to GuruSearchPage
                        });
                      },
                      child: Image.asset('assets/images/network.png'),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          index = 3; // Switch to GuruBrowserPage
                        });
                      },
                      child: SvgPicture.asset('assets/svg/message.svg'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            index = 4; // Switch to GuruMessagePage
                          });
                        },
                        child: const CircleAvatar(
                          maxRadius: 16,
                          /*child: guruStream.when(
                            data: (data) {
                              if (data != null) {
                                return CircleAvatar(
                                    // maxRadius: 12,
                                    backgroundImage: NetworkImage(
                                  data.imageUrl.toString(),
                                ));
                              }
                              return (const CircleAvatar(
                                maxRadius: 12,
                              ));
                            },
                            error: (e, t) => const CircleAvatar(
                              maxRadius: 12,
                            ),
                            loading: () => const CircleAvatar(
                              maxRadius: 12,
                            ),*/
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StudentHome extends ConsumerStatefulWidget {
  final String userId;
  const StudentHome({super.key, required this.userId});

  @override
  ConsumerState<StudentHome> createState() => _StudentHomeState();
}

class _StudentHomeState extends ConsumerState<StudentHome> {
  // UserModel? userModel;
  // @override
  // void initState() {
  //   getCurrentUser();
  //   super.initState();
  // }

  // getCurrentUser() async {
  //   userModel = await ref
  //       .watch(profile)
  //       .getCurrentUser(userId: widget.userId, context: context);
  // }

  Future<UserModel> fetchUserModel() async {
    var box = await Hive.openBox<UserModel>('userBox');

    UserModel? storedUser = box.get('currentUser');
    return storedUser!;
    // if (mounted) {
    //   setState(() {
    //     userModel = storedUser;
    //   });
    // }
  }

  int index = 0;
  @override
  Widget build(BuildContext context) {
    final isGuruProvider = ref.watch(userFromHiveProvider);
    final userData = isGuruProvider.user;

    List pages = [
      const StudentHomePage(),
      const GuruSearchPage(),
      const ContactPage(),
      StudentProfilePage(
        userID: widget.userId,
      ),
    ];
    // final userStream = ref.watch(userDataSteamProvider);
    return Scaffold(
      backgroundColor: HexColor('#D9D9D9'),
      body: SafeArea(
        child: Stack(
          children: [
            pages[index],
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: CommonContainer(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                          onTap: () {
                            setState(() {
                              index = 0; // Switch to GuruHomePage
                            });
                          },
                          child: SvgPicture.asset(
                            'assets/svg/majesticons_home-line.svg',
                          )),
                      InkWell(
                        onTap: () {
                          setState(() {
                            index = 1; // Switch to GuruSearchPage
                          });
                        },
                        child: Image.asset(
                          'assets/images/search.png',
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            index = 2; // Switch to GuruBrowserPage
                          });
                        },
                        child: SvgPicture.asset('assets/svg/message.svg'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              index = 3; // Switch to GuruMessagePage
                            });
                          },
                          child: CircleAvatar(
                            maxRadius: 16,
                            child: userData!.photoUrl == null
                                ? const CircleAvatar(
                                    maxRadius: 12,
                                  )
                                : CircleAvatar(
                                    maxRadius: 12,
                                    backgroundImage: NetworkImage(
                                      userData.photoUrl.toString(),
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CommonContainer extends StatelessWidget {
  final Widget child;
  const CommonContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: HexColor('#2067FD'),
          boxShadow: const [
            BoxShadow(
              color: Color(0x40000000),
            ),
            BoxShadow(color: Color(0x40000000))
          ],
          borderRadius: BorderRadius.circular(15)),
      child: child,
    );
  }
}
