import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_lock_app/res/fonts.dart';

class ProfileCameraCaptureScreen extends StatefulWidget {
  const ProfileCameraCaptureScreen({super.key});

  @override
  State<ProfileCameraCaptureScreen> createState() =>
      _ProfileCameraCaptureScreenState();
}

class _ProfileCameraCaptureScreenState extends State<ProfileCameraCaptureScreen> {
  CameraController? _controller;
  bool _isReady = false;
  bool _isCapturing = false;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();
    final frontCamera = cameras.firstWhere(
          (camera) => camera.lensDirection == CameraLensDirection.front,
      orElse: () => cameras.first,
    );

    _controller = CameraController(
      frontCamera,
      ResolutionPreset.medium,
      enableAudio: false,
    );

    await _controller!.initialize();

    if (!mounted) return;
    setState(() => _isReady = true);
  }

  Future<void> _capturePhoto() async {
    if (_controller == null ||
        !_controller!.value.isInitialized ||
        _isCapturing) {
      return;
    }

    setState(() => _isCapturing = true);

    try {
      final file = await _controller!.takePicture();
      if (!mounted) return;
      Navigator.pop(context, File(file.path));
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to capture image")),
      );
      setState(() => _isCapturing = false);
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;

    return Scaffold(
      backgroundColor: Colors.black,
      body: !_isReady || controller == null
          ? const Center(
        child: CircularProgressIndicator(color: Colors.white),
      )
          : Stack(
        children: [
          Positioned.fill(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: controller.value.previewSize!.height,
                height: controller.value.previewSize!.width,
                child: CameraPreview(controller),
              ),
            ),
          ),

          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.20),
            ),
          ),

          Positioned.fill(
            child: CustomPaint(
              painter: _CameraOverlayPainter(context),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(18.w),
              child: Column(
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: EdgeInsets.all(8.w),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.35),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  20.verticalSpace,
                  Text(
                    "Align your face inside the box",
                    textAlign: TextAlign.center,
                    style: AppFonts.text16.bold.style.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  6.verticalSpace,
                  Text(
                    "Look straight at the camera. Avoid side angles, low light, or cropped face.",
                    textAlign: TextAlign.center,
                    style: AppFonts.text12.medium.style.copyWith(
                      color: Colors.white.withOpacity(0.85),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 18.w,
                      vertical: 10.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.45),
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    child: Text(
                      _isCapturing
                          ? "Capturing..."
                          : "Keep your face centered, then tap capture",
                      textAlign: TextAlign.center,
                      style: AppFonts.text14.semiBold.style.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  20.verticalSpace,
                  InkWell(
                    onTap: _isCapturing ? null : _capturePhoto,
                    borderRadius: BorderRadius.circular(40.r),
                    child: Container(
                      width: 72.w,
                      height: 72.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.white.withOpacity(0.8),
                          width: 4,
                        ),
                      ),
                      child: Center(
                        child: Container(
                          width: 56.w,
                          height: 56.w,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: _isCapturing
                              ? Padding(
                            padding: EdgeInsets.all(14.w),
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.black,
                            ),
                          )
                              : Icon(
                            Icons.camera_alt_rounded,
                            color: Colors.black,
                            size: 26.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                  10.verticalSpace,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CameraOverlayPainter extends CustomPainter {
  final BuildContext context;

  _CameraOverlayPainter(this.context);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withOpacity(0.6)
      ..style = PaintingStyle.fill;

    final path = Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    // Center cut-out (profile ratio)
    final rectWidth = size.width * 0.8;
    final rectHeight = size.height * 0.5;

    final rect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: rectWidth,
      height: rectHeight,
    );

    final cutout = Path()
      ..addRRect(RRect.fromRectAndRadius(rect, const Radius.circular(20)));

    // Remove center from overlay
    final finalPath = Path.combine(PathOperation.difference, path, cutout);

    canvas.drawPath(finalPath, paint);

    // Optional: White border around cutout
    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(20)),
      borderPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}