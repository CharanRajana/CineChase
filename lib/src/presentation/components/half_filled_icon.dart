import 'package:flutter/material.dart';

class HalfFilledIcon extends StatelessWidget {
  final IconData icon;
  final double size = 24;
  final Color color;

  const HalfFilledIcon({super.key, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (Rect rect) {
        return LinearGradient(
          stops: const [0, 0.5, 0.5],
          colors: [color, color, color.withOpacity(0)],
        ).createShader(rect);
      },
      child: SizedBox(
        width: size,
        height: size,
        child: Icon(icon,
            size: size, color: Theme.of(context).colorScheme.onSurface),
      ),
    );
  }
}
