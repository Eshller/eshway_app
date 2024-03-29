// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';

import 'package:caffae_app/models/ModelProvider.dart';
import 'package:caffae_app/src/Global/Export/export.dart';
import 'package:caffae_app/src/Global/Utils/time_changer.dart';

class RecentlyContactCard extends StatelessWidget {
  final GuruModel userData;
  const RecentlyContactCard({
    Key? key,
    required this.userData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return userData.id == ''
        ? const SizedBox.shrink()
        : Card(
            elevation: 2,
            // borderOnForeground: true,
            shadowColor: whiteColor,
            margin: const EdgeInsets.all(5),
            shape: RoundedRectangleBorder(
              borderRadius: globalBorderRadius,
              //set border radius more than 50% of height and width to make circle
            ),
            child: Container(
              // height: 197,
              decoration: BoxDecoration(
                color: kBackGroundColors,
                // color: Colors.green,
                borderRadius: globalBorderRadius,
              ),
              width: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 83,
                    width: 83,
                    child: CachedNetworkImage(
                      imageUrl: userData.imageUrl.toString(),
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          // color: Colors.green,
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.fitWidth),
                        ),
                      ),
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  const SizedBox(
                    height: 9,
                  ),
                  HomeContactTextWidget(
                    fontSize: 11,
                    text: userData.username!.length > 9
                        ? "${userData.username.toString().substring(0, 10)}..."
                        : userData.username.toString(),
                  ),
                  // ReusableText(
                  //   align: TextAlign.center,
                  //   text: userData.username!.length > 9
                  //       ? "${userData.username.toString().substring(0, 10)}..."
                  //       : userData.username.toString(),
                  //   textStyle: GoogleFonts.poppins(
                  //     fontWeight: FontWeight.w500,
                  //     fontSize: 11,
                  //     color: Colors.white,
                  //   ),
                  // ),
                  const SizedBox(
                    height: 2,
                  ),
                  HomeContactTextWidget(
                    text: userData.specialist.toString(),
                    fontSize: 9,
                  ),

                  const SizedBox(
                    height: 2,
                  ),
                  HomeContactTextWidget(
                    fontSize: 8,
                    text: convertTimestampToRealTime(
                      int.parse(
                        userData.joiningTime.toString(),
                      ),
                    ),
                  ),
                  // Align(
                  //   alignment: Alignment.bottomCenter,
                  //   child: ReusableText(
                  //     text: convertTimestampToRealTime(
                  //       int.parse(
                  //         userData.joiningTime.toString(),
                  //       ),
                  //     ),
                  //     textStyle: GoogleFonts.poppins(
                  //       fontWeight: FontWeight.w500,
                  //       fontSize: 8,
                  //       color: Colors.white,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          );
  }
}

class HomeContactTextWidget extends StatelessWidget {
  final String text;
  final double fontSize;
  const HomeContactTextWidget(
      {super.key, required this.text, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return ReusableText(
      text: text,
      align: TextAlign.center,
      textStyle: GoogleFonts.poppins(
        fontWeight: customFont500Weight,
        fontSize: fontSize,
        color: whiteColor,
      ),
    );
  }
}
