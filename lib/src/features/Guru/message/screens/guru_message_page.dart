import 'package:cached_network_image/cached_network_image.dart';
import 'package:caffae_app/src/Global/Export/export.dart';
import 'package:caffae_app/src/features/Guru/message/services/repository_meeting.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GuruMessagePage extends ConsumerWidget {
  const GuruMessagePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meeting = ref.watch(meetingStateNotifierProvider);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 62),
          child: Column(
            children: [
              const SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 12,
                  left: 12,
                ),
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
                          SvgPicture.asset(
                              'assets/svg/game-icons_two-coins.svg'),
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
              ),
              // StreamBuilder(
              //   stream: Stream.value(2),
              //   builder: (context, snapshot) {
              //     if (snapshot.connectionState == ConnectionState.waiting) {
              //       return Shimmer.fromColors(
              //         baseColor: Colors.grey.shade400,
              //         highlightColor: Colors.grey.shade200,
              //         child: ListView.builder(
              //             itemCount: 9,
              //             shrinkWrap: true,
              //             scrollDirection: Axis.vertical,
              //             itemBuilder: (context, index) {
              //               return Padding(
              //                 padding: const EdgeInsets.all(5.0),
              //                 child: GlobalContainer(
              //                   height: 115,
              //                   borderWidth: 1.1,
              //                   width: MediaQuery.of(context).size.width,
              //                   color: const Color.fromARGB(255, 252, 245, 245),
              //                   borderRadius: BorderRadius.circular(18),
              //                   child: const Text(''),
              //                 ),
              //               );
              //             }),
              //       );
              //     }

              //     return

              ListView.builder(
                itemCount: meeting.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding:
                    const EdgeInsets.symmetric(vertical: 11, horizontal: 5),
                itemBuilder: (context, index) {
                  final j = meeting.state[index];
                  return CustomContainer(
                    minHeight: 100,
                    minWidth: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5, left: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => SecondPage(
                              //       imageUrl: listOfMeetings.senderPic
                              //           .toString(),
                              //     ),
                              //   ),
                              // );
                            },
                            child: Hero(
                              tag: 'listOfMeetings.senderPic.toString()',
                              child: Container(
                                height: 80,
                                width: 80,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle),
                                child: CachedNetworkImage(
                                  // height: 110,
                                  // width: 110,
                                  imageUrl: '',
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    height: 110,
                                    width: 110,
                                    alignment: FractionalOffset.center,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      // color: Colors.green,
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.fitWidth),
                                    ),
                                  ),
                                  placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                            ),
                          ),
                          // const CircleAvatar(
                          //   m4axRadius: 39,
                          // ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ReusableText(
                                  text: 'listOfMeetings.senderName',
                                  textStyle: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                // listOfMeetings.isDecline == true
                                //     ?
                                //     ReusableText(
                                //     text:
                                //     'you have declined the meeting with ${listOfMeetings.senderName}',
                                //     textStyle: appStyle(
                                //       fw: FontWeight.w300,
                                //       fontSize: 9,
                                //       color: Colors.black,
                                //     ))
                                //     :
                                RichText(
                                  text: TextSpan(
                                    text:
                                        // listOfMeetings
                                        //     .isAudio ==
                                        //     true
                                        //     ? 'Audio call '
                                        //     :
                                        "Video call ",
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 9,
                                      color: HexColor('#2067FD'),
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'on ',
                                        style: GoogleFonts.inter(
                                            color: Colors.black),
                                        children: [
                                          TextSpan(
                                            text: formatDate(''),
                                            style: GoogleFonts.inter(
                                              // fontSize: 16.sp,
                                              color: HexColor('#2067FD'),
                                            ),
                                            children: [
                                              TextSpan(
                                                text: ', from ',
                                                style: GoogleFonts.inter(
                                                  // fontSize: 16.sp,
                                                  color: Colors.black,
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text: '',
                                                    style: GoogleFonts.inter(
                                                      // fontSize: 16.sp,
                                                      color:
                                                          HexColor('#2067FD'),
                                                    ),
                                                    children: [
                                                      TextSpan(
                                                        text: ' to ',
                                                        style:
                                                            GoogleFonts.inter(
                                                          // fontSize: 16.sp,
                                                          color: Colors.black,
                                                        ),
                                                        children: [
                                                          TextSpan(
                                                            text:
                                                                getNextTime(''),
                                                            style: GoogleFonts
                                                                .inter(
                                                              // fontSize: 16.sp,
                                                              color: HexColor(
                                                                '#2067FD',
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        InkWell(
                                          onTap: () {},
                                          child: GlobalContainer(
                                            height: 25,
                                            width: 92,
                                            color: HexColor('#FF0000'),
                                            borderWidth: 0.0,
                                            borderRadius:
                                                BorderRadius.circular(14),
                                            child: ReusableText(
                                              text: 'Decline',
                                              textStyle: appStyle(
                                                fw: FontWeight.w500,
                                                fontSize: 11,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 6,
                                        ),
                                        InkWell(
                                          onTap: () {},
                                          child: GlobalContainer(
                                            height: 25,
                                            width: 92,
                                            borderRadius:
                                                BorderRadius.circular(14),
                                            color: const Color(0xFF39B200),
                                            borderWidth: 0.0,
                                            child: ReusableText(
                                              text: 'Accept',
                                              textStyle: appStyle(
                                                fw: FontWeight.w500,
                                                fontSize: 11,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),

                                  //  ReusableText(
                                  // text:
                                  // 'you have accepted meetings, payment is in pending',
                                  // textStyle: appStyle(
                                  //   fw: FontWeight.w300,
                                  //   fontSize: 9,
                                  //   color: Colors.black,
                                  // ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              //   },
              // )
            ],
          ),
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  final String imageUrl;
  const SecondPage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Profile Screen"),
          centerTitle: true,
        ),
        body: Hero(
          tag: imageUrl,
          child: Container(
            alignment: Alignment.topCenter,
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: NetworkImage(imageUrl),
            )),
          ),
        ));
  }
}
