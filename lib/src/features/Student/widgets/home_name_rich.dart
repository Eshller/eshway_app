import 'package:caffae_app/src/Global/Export/export.dart';

class HomeNameRich extends StatelessWidget {
  final String title1;
  final String title2;
  const HomeNameRich({
    Key? key,
    required this.title1,
    required this.title2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: title1,
        style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500, fontSize: 30, color: blackColor),
        children: [
          TextSpan(
            text: title2,
            style: GoogleFonts.poppins(
              fontSize: 23,
              color: HexColor('#2261FD'),
            ),
          )
        ],
      ),
    );
  }
}
