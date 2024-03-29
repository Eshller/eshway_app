import 'package:caffae_app/src/Global/Export/export.dart';
import 'package:caffae_app/src/features/Student/screens/transaction_history.dart';

class CommonProfileFooterCard extends StatelessWidget {
  const CommonProfileFooterCard({
    super.key,
    required this.ref,
  });

  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const TransactionHistory(),
                ),
              );
            },
            child: Row(
              children: [
                ReusableText(
                  text: 'Transaction history',
                  textStyle: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    color: const Color(0xFF283246),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Image.asset(
                  'assets/images/clock.png',
                  opacity: const AlwaysStoppedAnimation(1),
                  color: Colors.black,
                  height: 22,
                  width: 22,
                )
              ],
            ),
          ),
          const SizedBox(
            height: 9,
          ),
          InkWell(
            onTap: () {},
            child: Row(
              children: [
                ReusableText(
                  text: 'Logout',
                  textStyle: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    color: const Color(0xFF283246),
                  ),
                ),
                const SizedBox(
                  width: 9,
                ),
                const Icon(Icons.logout)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
