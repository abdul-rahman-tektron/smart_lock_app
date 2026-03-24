import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_lock_app/res/images.dart';

class GlassLottieBackground extends StatelessWidget {
  final Widget child;

  /// Increase blur to make it more “glassy”
  final double blurSigma;

  /// Increase opacity for stronger frosted look
  final double glassOpacity;
  final bool isHome;

  const GlassLottieBackground({
    super.key,
    required this.child,
    this.blurSigma = 13,
    this.isHome = false,
    this.glassOpacity = 0.10,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF1FFFB),
        body: Stack(
          fit: StackFit.expand,
          children: [
            // 1) Lottie background
            // Positioned(
            //   bottom: 0,
            //   child: Lottie.asset(
            //     AppImages.background2,
            //     fit: BoxFit.fitWidth,
            //     repeat: true,
            //     animate: true,
            //   ),
            // ),


            !isHome ? Lottie.asset(
              AppImages.background,
              fit: BoxFit.cover,
              repeat: true,
              animate: true,
            ): Image.asset(AppImages.homeImage, fit: BoxFit.cover,),

            // 2) Glass overlay (blur + translucent gradient)
            Positioned.fill(
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: blurSigma,
                    sigmaY: blurSigma,
                  ),
                  child: Container(
                    color: Colors.white.withOpacity(glassOpacity),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white.withOpacity(0.18),
                            Colors.white.withOpacity(0.05),
                            Colors.white.withOpacity(0.12),
                          ],
                          stops: const [0.0, 0.55, 1.0],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // 3) Optional subtle “glass shine” highlight (looks premium)
            Positioned.fill(
              child: IgnorePointer(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: const Alignment(-0.7, -0.8),
                      radius: 1.2,
                      colors: [
                        Colors.white.withOpacity(0.18),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.65],
                    ),
                  ),
                ),
              ),
            ),

            // 4) Foreground content
            child,
          ],
        ),
      ),
    );
  }
}