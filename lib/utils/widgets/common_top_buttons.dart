import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_lock_app/res/fonts.dart';
import 'package:smart_lock_app/utils/extensions.dart';
import 'package:smart_lock_app/utils/routes.dart';
import 'package:smart_lock_app/utils/widgets/custom_buttons.dart';

class CommonTopButtons extends StatelessWidget {
  final bool isBackNeeded;
  final VoidCallback? backButton;
  final bool isCloseNeeded;

  const CommonTopButtons({
    super.key,
    this.isBackNeeded = true,
    this.backButton,
    this.isCloseNeeded = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // LEFT SLOT (Back or placeholder)
        SizedBox(
          width: 44.w, // same visual width as back button
          child: isBackNeeded
              ? CustomButton(
            icon: Icons.arrow_back_ios,
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            fullWidth: false,
            iconSize: 12.sp,
            onPressed: backButton ?? () {
              Navigator.pop(context);
            },
          )
              : const SizedBox.shrink(),
        ),

        const Spacer(),

        // RIGHT SLOT (Close always fixed)
        isCloseNeeded ? CustomButton(
          text: context.locale.close,
          fullWidth: false,
          textStyle: AppFonts.text10.regular.white.style,
          onPressed: () {
            // Navigator.pushNamedAndRemoveUntil(
            //   context,
            //   AppRoutes.welcome,
            //       (route) => false,
            // );
          },
        ): const SizedBox.shrink(),
      ],
    );
  }
}