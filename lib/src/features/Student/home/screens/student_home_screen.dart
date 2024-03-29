import 'dart:async';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:caffae_app/models/ModelProvider.dart';
import 'package:caffae_app/src/Global/Export/export.dart';
import 'package:caffae_app/src/Global/providers/user_provider.dart';
import 'package:caffae_app/src/features/Guru/Screens/guru_profile.dart';
import 'package:caffae_app/src/features/Student/home/controller/home_controller.dart';
import 'package:caffae_app/src/features/Student/home/widgets/meeting_widget.dart';
import 'package:caffae_app/src/features/Student/home/widgets/recently_contact_card.dart';
import 'package:caffae_app/src/features/Student/widgets/meeting_container.dart';

class StudentHomePage extends ConsumerStatefulWidget {
  static const String routeName = 'home-page';
  const StudentHomePage({
    super.key,
  });

  @override
  ConsumerState<StudentHomePage> createState() => _StudentHomePageState();
}

class _StudentHomePageState extends ConsumerState<StudentHomePage> {
  // getCurrentUser() async {
  //   userModel = await ref
  //       .watch(profile)
  //       .getCurrentUser(userId: widget.userId, context: context);
  // }

  // UserModel? userModel;
  // List<GuruModel> gurus = [];
  // late Future<List<GuruModel>> userDataFuture;

  // final TextEditingController searchController = TextEditingController();
  // @override
  // void initState() {
  //   // getCurrentUser();
  //   super.initState();
  //   // userDataFuture =
  //   //     ref.watch(homeController).getRecentGuru(userModel: userModel);
  // }

  Stream<List<MeetingModel>> fetchAllMeetingById({required String senderId}) {
    final StreamController<List<MeetingModel>> controller =
        StreamController<List<MeetingModel>>.broadcast();

    // Define a function to fetch meetings
    Future<void> fetchMeetings() async {
      try {
        final List<MeetingModel> meetings = await Amplify.DataStore.query(
          MeetingModel.classType,
          where: MeetingModel.SENDERID.eq(senderId),
        );

        controller.add(meetings);
      } catch (e) {
        controller.addError(e);
      }
    }

    // Subscribe to DataStore events for MeetingModel
    Amplify.DataStore.observe(MeetingModel.classType)
        .listen((event) => fetchMeetings());

    // Fetch meetings once DataStore is initialized
    // Amplify.DataStore..then((_) => fetchMeetings());

    return controller.stream;
  }

  @override
  Widget build(BuildContext context) {
    final isGuruProvider = ref.watch(userFromHiveProvider);
    final userData = isGuruProvider.user;

    final screenWidth = MediaQuery.of(context).size.width;
    // ref.refresh(fetchBasedOnInterestProvider);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(right: 9, left: 9, bottom: 65),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeaderHome(),
                HomeNameRich(
                  title1: 'Hey ',
                  title2: userData!.username.toString(),
                ),
                const SizedBox(height: 14),
                const HomeText(
                  text: 'Schedule',
                ),
                const SizedBox(height: 14),
                StreamBuilder(
                    stream: fetchAllMeetingById(senderId: ''),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const HomeMeetingShimmer();
                      }

                      if (snapshot.data!.isEmpty) {
                        return const MeetingWidget();
                      }
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final meetings = snapshot.data![index];

                            return meetings.isDonePayment == true
                                ? MeetingContainer(
                                    context: context,
                                    meetingModel: meetings,
                                  )
                                : const MeetingWidget();
                          });
                    }),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                const HomeText(
                  text: 'Recently Contacted',
                ),
                const SizedBox(height: 10),
                const HomeText(text: 'Recommended For you'),
                const SizedBox(height: 10),
                SizedBox(
                  height: 165,
                  child: ref.watch(fetchBasedOnInterestProvider).when(
                        data: (data) {
                          if (data.isNotEmpty) {
                            ListView.builder(
                              itemCount: data.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                GuruModel guruModel = data[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => GuruProfileScreen(
                                          guruModel: guruModel,
                                        ),
                                      ),
                                    );
                                  },
                                  child:
                                      RecentlyContactCard(userData: guruModel),
                                );
                              },
                            );
                          }
                          return Center(
                            child: ReusableText(
                              text: 'There is no recommandation availble',
                              textStyle: appStyle(
                                fw: FontWeight.w300,
                                fontSize: screenWidth * 0.04,
                                color: Colors.black,
                              ),
                            ),
                          );
                        },
                        error: ((error, stackTrace) {
                          return null;
                        }),
                        loading: () => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),

                  // FutureBuilder(
                  //   future: userDataFuture,
                  //   builder: (context, snapshot) {
                  //     if (snapshot.connectionState == ConnectionState.waiting) {
                  //       return const Center(
                  //         child: CircularProgressIndicator(),
                  //       );
                  //     }
                  //     if (snapshot.hasError) {
                  //       return Center(
                  //         child: Text(
                  //           '${snapshot.error} occurred',
                  //           style: const TextStyle(fontSize: 18),
                  //         ),
                  //       );
                  //     }
                  //     if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  //       return SizedBox(
                  //         // height: 149,

                  //         child: ListView.builder(
                  //           itemCount: snapshot.data!.length,
                  //           shrinkWrap: true,
                  //           scrollDirection: Axis.horizontal,
                  //           itemBuilder: (context, index) {
                  //             final data = snapshot.data![index];
                  //             return GestureDetector(
                  //               onTap: () {
                  //                 Navigator.of(context).push(
                  //                   MaterialPageRoute(
                  //                     builder: (context) => GuruProfileScreen(
                  //                       guruModel: snapshot.data![index],
                  //                     ),
                  //                   ),
                  //                 );
                  //               },
                  //               child: RecentlyContactCard(userData: data),
                  //             );
                  //           },
                  //         ),
                  //       );
                  //     }
                  //     if (!snapshot.hasData) {
                  //       return const HomeText(
                  //         text: 'No data Found',
                  //       );
                  //     }
                  //     if (snapshot.data!.isEmpty) {
                  //       return const HomeText(
                  //           text: 'No currently recommended available');
                  //     } else {
                  //       return const HomeText(text: 'No Recommended available');
                  //     }
                  //   },
                  // ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
