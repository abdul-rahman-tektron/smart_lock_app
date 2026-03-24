import 'package:flutter/material.dart';

class VerifyingLoader extends StatefulWidget {
  const VerifyingLoader({super.key});

  @override
  State<VerifyingLoader> createState() => VerifyingLoaderState();
}

class VerifyingLoaderState extends State<VerifyingLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(vsync: this, duration: const Duration(milliseconds: 900))
      ..repeat();
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        RotationTransition(
          turns: _c,
          child: const Icon(Icons.autorenew, size: 44),
        ),
        const SizedBox(height: 10),
        const Text("Verification in progress..."),
      ],
    );
  }
}

class _ResultBadge extends StatelessWidget {
  final bool recognized;
  final double similarity; // 0..1
  final String message;

  const _ResultBadge({
    super.key,
    required this.recognized,
    required this.similarity,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          recognized ? Icons.verified : Icons.error,
          size: 44,
        ),
        const SizedBox(height: 10),
        Text(recognized ? "Recognized ✅" : "Not recognized ❌"),
        const SizedBox(height: 6),
        Text("Similarity: ${(similarity * 100).toStringAsFixed(1)}%"),
        if (message.isNotEmpty) ...[
          const SizedBox(height: 6),
          Text(message, textAlign: TextAlign.center),
        ],
      ],
    );
  }
}