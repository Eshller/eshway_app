import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';


class CommonCameraWidget extends StatelessWidget {
  final String imageUrl;
  final VoidCallback cameraCallback;
  const CommonCameraWidget({
    Key? key,
    required this.imageUrl,
    required this.cameraCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
           /* Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SecondPage(
                  imageUrl: imageUrl,
                ),
              ),
            );*/
          },
          child: Hero(
            tag: imageUrl,
            child: Container(
              height: 100,
              width: 100,
              decoration: const BoxDecoration(
                  color: Colors.white, shape: BoxShape.circle),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                imageBuilder: (context, imageProvider) => Container(
                  height: 110,
                  width: 110,
                  alignment: FractionalOffset.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    // color: Colors.green,
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.fitWidth),
                  ),
                ),
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 1,
          right: 2,
          child: InkWell(
            onTap: cameraCallback,
            child: const Icon(
              Icons.photo_camera,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
