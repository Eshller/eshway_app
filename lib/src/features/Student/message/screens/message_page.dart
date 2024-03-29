import 'dart:async';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:caffae_app/models/ModelProvider.dart';
import 'package:caffae_app/src/Global/Export/export.dart';
import 'package:shimmer/shimmer.dart';

class ContactPage extends StatelessWidget {
  static const String routeName = "contact-page";
  const ContactPage({super.key});
  Stream<List<MeetingModel>> fetchAllMeetingById(
      {required String receiverId}) async* {
    final StreamController<List<MeetingModel>> controller = StreamController();

    try {
      final List<MeetingModel> meetings = await Amplify.DataStore.query(
        MeetingModel.classType,
        where: MeetingModel.RECEIVERID.eq(receiverId),
      );

      // Add the fetched meetings to the stream
      controller.add(meetings);
    } catch (e) {
      // Handle errors by adding an error event to the stream
      controller.addError(e);
    } finally {
      await controller
          .close(); // Ensure the StreamController is closed after use
    }
    yield* controller.stream;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 62),
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            const CommonHeader(),
            const SizedBox(
              height: 10,
            ),
            StreamBuilder(
              stream: fetchAllMeetingById(receiverId: ''),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey.shade400,
                    highlightColor: Colors.grey.shade200,
                    child: ListView.builder(
                      itemCount: 9,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: GlobalContainer(
                            height: 115,
                            borderWidth: 1.1,
                            width: MediaQuery.of(context).size.width,
                            color: const Color.fromARGB(255, 252, 245, 245),
                            borderRadius: BorderRadius.circular(18),
                            child: const Text(''),
                          ),
                        );
                      },
                    ),
                  );
                }
                if (snapshot.data!.isEmpty) {
                  return Center(
                    child: ReusableText(
                      text: 'No message found',
                      textStyle: appStyle(
                        fw: FontWeight.bold,
                        fontSize: 14,
                        color: kBackGroundColors,
                      ),
                    ),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: 4,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final listOfMeetings = snapshot.data![index];

                      return listOfMeetings.isDonePayment == true
                          ? const SizedBox.shrink()
                          : MessageCard(listOfMeetings: listOfMeetings);
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class MessageCard extends ConsumerWidget {
  final MeetingModel listOfMeetings;
  const MessageCard({super.key, required this.listOfMeetings});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomContainer(
      minHeight: 100,
      minWidth: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.only(right: 5, left: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 80,
              width: 80,
              decoration: const BoxDecoration(
                  color: Colors.white, shape: BoxShape.circle),
              child: CachedNetworkImage(
                // height: 110,
                // width: 110,
                imageUrl: listOfMeetings.receiverPic!.isEmpty
                    ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-3VQz6KM-1laTLb_oCNKBdJNt609eeeDSA7d3VZo&s'
                    : listOfMeetings.receiverPic.toString(),
                imageBuilder: (context, imageProvider) => Container(
                  height: 110,
                  width: 110,
                  alignment: FractionalOffset.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            const SizedBox(
              width: 2,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 19),
                      child: ReusableText(
                        text: '1 hr ago',
                        textStyle: appStyle(
                          fw: FontWeight.w500,
                          fontSize: 10,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: listOfMeetings.isDecline == false &&
                                  listOfMeetings.isAccept == false
                              ? Colors.green
                              : listOfMeetings.isDecline == true &&
                                      listOfMeetings.isAccept == false
                                  ? Colors.red
                                  : Colors.blue,
                        ),
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      listOfMeetings.isDecline == false &&
                              listOfMeetings.isAccept == false
                          ? MeetingHeaderName(
                              text:
                                  'Your meeting is in pending with ${listOfMeetings.receiverName}',
                            )
                          : listOfMeetings.isDecline == true &&
                                  listOfMeetings.isAccept == false
                              ? MeetingHeaderName(
                                  text:
                                      '${listOfMeetings.receiverName} has Declined your request')
                              : MeetingHeaderName(
                                  text:
                                      '${listOfMeetings.receiverName} has accepted your request'),
                    ],
                  ),
                  const SizedBox(
                    height: 1,
                  ),
                  listOfMeetings.isDecline == true &&
                          listOfMeetings.isAccept == false
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 17),
                          child: ReusableText(
                            text: 'He could not accept because ....',
                            textStyle: appStyle(
                                fw: customFont300Weight,
                                fontSize: 9,
                                color: blackColor),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: RichText(
                            text: TextSpan(
                              text: "Your ",
                              style: GoogleFonts.inter(
                                fontSize: 8,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                              children: [
                                TextSpan(
                                  text: listOfMeetings.isAudio == true
                                      ? 'audio call'
                                      : "video call",
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w400,
                                    color: HexColor('#2067FD'),
                                  ),
                                  children: [
                                    TextSpan(
                                      text: ' with ',
                                      style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w300,
                                        // fontSize: 16.sp,
                                        color: Colors.black,
                                      ),
                                      children: [
                                        TextSpan(
                                          text:
                                              ' ${listOfMeetings.receiverName} ',
                                          style: GoogleFonts.inter(
                                            // fontSize: 16.sp,
                                            color: HexColor('#2067FD'),
                                          ),
                                          children: [
                                            TextSpan(
                                              text: listOfMeetings.isDecline ==
                                                          false &&
                                                      listOfMeetings.isAccept ==
                                                          false
                                                  ? ' is in pending  for '
                                                  : ' has been scheduled for ',
                                              style: GoogleFonts.inter(
                                                // fontSize: 16.sp,
                                                color: Colors.black,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: formatDate(
                                                      listOfMeetings.date
                                                          .toString()),
                                                  style: GoogleFonts.inter(
                                                    // fontSize: 16.sp,
                                                    color: HexColor('#2067FD'),
                                                  ),
                                                  children: [
                                                    TextSpan(
                                                      text: ' from  ',
                                                      style: GoogleFonts.inter(
                                                          // fontSize: 16.sp,
                                                          color: Colors.black),
                                                      children: [
                                                        TextSpan(
                                                          style:
                                                              GoogleFonts.inter(
                                                            color: HexColor(
                                                                '#2067FD'),
                                                          ),
                                                          text:
                                                              '${listOfMeetings.time.toString()} ',
                                                          children: [
                                                            TextSpan(
                                                              text: 'to ',
                                                              style: GoogleFonts
                                                                  .inter(
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                              children: [
                                                                TextSpan(
                                                                  style:
                                                                      GoogleFonts
                                                                          .inter(
                                                                    color:
                                                                        HexColor(
                                                                      '#2067FD',
                                                                    ),
                                                                  ),
                                                                  text:
                                                                      getNextTime(
                                                                    listOfMeetings
                                                                        .time
                                                                        .toString(),
                                                                  ),
                                                                )
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ],
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
                        ),
                  const SizedBox(
                    height: 8,
                  ),
                  listOfMeetings.isAccept == false
                      ? const SizedBox.shrink()
                      : Padding(
                          padding: const EdgeInsets.only(right: 9),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const SizedBox(
                                  width: 6,
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: GlobalContainer(
                                    height: 25,
                                    width: 120,
                                    borderRadius: BorderRadius.circular(14),
                                    color: const Color(0xFF283246),
                                    borderWidth: 0.0,
                                    child: ReusableText(
                                      text: 'Make Payment',
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
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MeetingHeaderName extends StatelessWidget {
  const MeetingHeaderName({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ReusableText(
        text: text,
        textStyle: GoogleFonts.inter(
          fontWeight: FontWeight.w500,
          fontSize: 12,
          color: Colors.black,
        ),
      ),
    );
  }
}
