import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_lock_app/res/fonts.dart';

class ResultBadge extends StatelessWidget {
  final bool recognized;
  final double similarity; // 0..1
  final String message;

  const ResultBadge({
    super.key,
    required this.recognized,
    required this.similarity,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final Color color = recognized ? Colors.green : Colors.red;
    final IconData icon =
    recognized ? Icons.verified_rounded : Icons.error_rounded;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // ✅ Icon
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withOpacity(0.15),
          ),
          child: Icon(
            icon,
            size: 40,
            color: color,
          ),
        ),

        12.verticalSpace,

        // ✅ Title
        Text(
          recognized ? "Face Recognized" : "Face Not Recognized",
          style: AppFonts.text16.bold.style.copyWith(color: color),
          textAlign: TextAlign.center,
        ),

        8.verticalSpace,

        // ✅ Similarity %
        Text(
          "Similarity: ${(similarity * 100).toStringAsFixed(1)}%",
          style: AppFonts.text14.regular.style,
        ),

        // ✅ Optional message
        if (message.isNotEmpty) ...[
          6.verticalSpace,
          Text(
            message,
            style: AppFonts.text12.regular.style.copyWith(
              color: Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }
}