// ignore_for_file: depend_on_referenced_packages

import 'package:caffae_app/models/ModelProvider.dart';
import 'package:caffae_app/src/Global/Export/export.dart';
import 'package:caffae_app/src/Global/widgets/rating.dart';
import 'package:caffae_app/src/features/Student/Guru_details/widgets/alert_dialog_feedback.dart';
import 'package:caffae_app/src/features/Student/Guru_details/widgets/chat_bottom_sheet.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../Student/Guru_details/widgets/meeting_bottom_sheet.dart';

class GuruProfileScreen extends ConsumerStatefulWidget {
  final GuruModel guruModel;
  static const String routeName = 'guru-profile';
  const GuruProfileScreen({
    Key? key,
    required this.guruModel,
  }) : super(key: key);

  @override
  ConsumerState<GuruProfileScreen> createState() => _GuruProfileScreenState();
}

class _GuruProfileScreenState extends ConsumerState<GuruProfileScreen> {
  final TextEditingController messageController = TextEditingController();
  void callBottomSheet(BuildContext context) {
    Get.bottomSheet(
      MeetingBottomSheet(
        guruModel: widget.guruModel,
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(widget.guruModel.id);
    return Scaffold(
      backgroundColor: HexColor('#D9D9D9'),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 14),
                  const GuruProfileHeader(),
                  const SizedBox(height: 14),
                  SizedBox(
                    height: 190,
                    child: Stack(
                      // alignment: Alignment.center,
                      children: [
                        Container(
                          height: 160,
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                            color: kBackGroundColors,
                            image: DecorationImage(
                              fit: BoxFit.fitHeight,
                              image: AssetImage('assets/images/back.png'),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 16,
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 207, 216, 207),
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  widget.guruModel.imageUrl.toString(),
                                ),
                              ),
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  right: 2,
                                  top: 9,
                                  child: Container(
                                    height: 20,
                                    width: 20,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 9, vertical: 9),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 6,
                        ),
                        ReusableText(
                          text: widget.guruModel.username.toString(),
                          textStyle: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: const Color(0xFF5D5B5B),
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        ReusableText(
                          text: 'Pianist',
                          textStyle: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: const Color(0xFF5D5B5B),
                          ),
                        ),
                        const RatingButton(
                          rating: 5,
                          ignoreGestures: false,
                        ),
                        const Divider(
                          thickness: 0.5,
                          color: Colors.black,
                        ),
                        const GuruProfileReusableText(
                          text: 'About',
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        ReusableText(
                          text: widget.guruModel.about.toString(),
                          textStyle: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            color: const Color(0xFF000000),
                          ),
                        ),
                        //const SizedBox(height: 8),
                        const GuruProfileReusableText(
                          text: 'Experience',
                        ),
                        //const SizedBox(
                        //  height: 8,

                        const SizedBox(
                          height: 8,
                        ),
                        const GuruProfileReusableText(
                          text: 'Fees',
                        ),
                        Row(children: [
                          FeesChargeCard(
                            text:
                                'Video Call \n${widget.guruModel.feesCharge!.videoCall} Coins/min',
                            width: MediaQuery.of(context).size.width / 3.3,
                          ),
                          FeesChargeCard(
                            text:
                                'Audio Call \n${widget.guruModel.feesCharge!.audiocall} Coins/min',
                            width: MediaQuery.of(context).size.width / 3.5,
                          ),
                          FeesChargeCard(
                              text: 'Chat \n(coming soon)',
                              width: MediaQuery.of(context).size.width / 3.49),
                        ]),
                        const SizedBox(
                          height: 8,
                        ),
                        const GuruProfileReusableText(
                          text: 'Total Sessions taken: 43',
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const GuruProfileReusableText(
                          text: 'Reviews',
                        ),

                        const SizedBox(
                          height: 6,
                        ),
                        // FutureBuilder<List<ReviewsModel>>(
                        //     future: ref.watch(guruRepository).fetchAllReviews(
                        //         recieverId: widget.guruModel.id.toString()),
                        //     builder: (context, snapshot) {
                        //       if (snapshot.connectionState ==
                        //           ConnectionState.waiting) {
                        //         // Show the circular progress indicator while waiting for data
                        //         return const Center(
                        //           child: CircularProgressIndicator(),
                        //         );
                        //       } else if (snapshot.hasError) {
                        //         return const Center(
                        //           child: Text('Something went wrong'),
                        //         );
                        //       } else if (snapshot.hasData &&
                        //           snapshot.data!.isNotEmpty) {
                        //         final reviews = snapshot.data!;
                        //         return SizedBox(
                        //           height: 130,
                        //           child: ListView.builder(
                        //             scrollDirection: Axis.horizontal,
                        //             shrinkWrap: true,
                        //             itemCount: reviews.length,
                        //             itemBuilder: (context, index) {
                        //               final ja = reviews[index];

                        //               return FutureBuilder(
                        //                 future: FirebaseFirestore.instance
                        //                     .collection('Users')
                        //                     .doc(ja.senderId)
                        //                     .get(),
                        //                 builder: (context, userSnapshot) {
                        //                   if (userSnapshot.hasData &&
                        //                       userSnapshot.data!.exists) {
                        //                     final userData = userSnapshot.data!;
                        //                     UserModel? user;
                        //                     if (userData.data() != null) {
                        //                       user = AuthModel.fromMap(
                        //                         userData.data()!,
                        //                       );
                        //                     }

                        //                     return ReviewCard(
                        //                       ja: ja,
                        //                       user: user!,
                        //                     );
                        //                   } else {
                        //                     return const Center(
                        //                       // render the loading indicator
                        //                       child:
                        //                           CircularProgressIndicator(),
                        //                     );
                        //                   }
                        //                 },
                        //               );
                        //             },
                        //           ),
                        //         );
                        //       } else {
                        //         return const Center(
                        //           child: Text(
                        //             'No data found ',
                        //           ),
                        //         );
                        //       }
                        //     }),
                        // const SizedBox(
                        //   height: 70,
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Flexible(flex: 1, child: Container()),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: openBottomSheet,
                        child: Image.asset('assets/images/messages.png'),
                      ),
                      GestureDetector(
                        onTap: () async {},
                        child: Image.asset(
                          'assets/images/phone.png',
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // String? toke =
                          //     await FirebaseMessaging.instance.getToken();
                        },
                        child: Image.asset(
                          'assets/images/video.png',
                        ),
                      ),
                      InkWell(
                        onTap: openMeeting,
                        child: Image.asset(
                          'assets/images/shedult.png',
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

  // for sending push notification

  showAlertDialog({
    required BuildContext context,
    required TextEditingController messageController,
    required double rating,
    required VoidCallback onTap,
    required GuruModel guruModel,
  }) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialogFeedBack(
          messageController: messageController,
          ontTap: onTap,
          guruModel: guruModel,
          rating: rating,
        );
      },
    );
  }

  void openMeeting() {
    Get.bottomSheet(
      MeetingBottomSheet(
        guruModel: widget.guruModel,
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

// --- Button Widget --- //
  void openBottomSheet() {
    Get.bottomSheet(
      const ChatBottomSheet(),
      backgroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}

class FeesChargeCard extends StatelessWidget {
  final double width;
  final String text;
  const FeesChargeCard({super.key, required this.text, required this.width});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: GlobalContainer(
        height: 57,
        borderWidth: 0.0,
        width: width,
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Center(
            child: ReusableText(
              text: text,
              // text:
              //     widget.guruModel.feesCharge!.videoCall,
              align: TextAlign.center,
              textStyle: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 11,
                color: const Color(0xFF283246),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class GuruProfileReusableText extends StatelessWidget {
  final String text;
  const GuruProfileReusableText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ReusableText(
      text: text,
      textStyle: GoogleFonts.poppins(
        fontWeight: FontWeight.w600,
        fontSize: 15,
        color: const Color(0xFF000000),
      ),
    );
  }
}

class GuruProfileHeader extends StatelessWidget {
  const GuruProfileHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 9),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(
              Icons.arrow_back,
              size: 30,
            ),
          ),
          Container(
            constraints: const BoxConstraints(minWidth: 44),
            height: 30,
            decoration: BoxDecoration(
                color: kBackGroundColors,
                borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.all(6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset('assets/svg/game-icons_two-coins.svg'),
                ReusableText(
                  text: '10',
                  textStyle: appStyle(
                    fw: FontWeight.w500,
                    fontSize: 15,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ReviewCard extends StatelessWidget {
  final ReviewsModel ja;
  final UserModel user;
  const ReviewCard({super.key, required this.ja, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: GlobalContainer(
        height: 65,
        borderWidth: 1.1,
        width: 250,
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            children: [
              ReusableText(
                text: user.username.toString(),
                textStyle: appStyle(
                  fw: FontWeight.bold,
                  fontSize: 13,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              const RatingButton(
                rating: 5,
                ignoreGestures: true,
              ),
              const SizedBox(
                height: 3,
              ),
              ReusableText(
                align: TextAlign.center,
                text: ja.message ?? '',
                textStyle: appStyle(
                  fw: FontWeight.w400,
                  fontSize: 11,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
