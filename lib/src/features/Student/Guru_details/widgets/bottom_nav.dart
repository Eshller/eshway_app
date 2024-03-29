
import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  final VoidCallback onTap;
  final String image;
  const BottomNav({
    Key? key,
    required this.onTap,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        // color: kBackGroundColors,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: onTap,
        icon: Ink.image(
          image: AssetImage(image),
        ),
      ),
    );
  }
}
