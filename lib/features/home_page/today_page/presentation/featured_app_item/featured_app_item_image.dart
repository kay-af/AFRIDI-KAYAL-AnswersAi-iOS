import "dart:ui";

import "package:flutter/cupertino.dart";
import "package:store/network/dtos/featured_app_dto.dart";

class FeaturedAppItemImage extends StatelessWidget {
  final FeaturedAppDto featuredApp;

  const FeaturedAppItemImage({required this.featuredApp, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(featuredApp.imageUrl, alignment: Alignment.center, fit: BoxFit.cover),
        ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: 120, sigmaY: 120),
          child: ShaderMask(
            shaderCallback: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                CupertinoColors.black,
                CupertinoColors.transparent,
              ],
              stops: [0.45, 0.45],
            ).createShader,
            blendMode: BlendMode.dstOut,
            child: Image.asset(
              featuredApp.imageUrl,
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
        ),
      ],
    );
  }
}
