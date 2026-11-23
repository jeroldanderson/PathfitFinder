import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import '../theme.dart';

class DesignIcon extends StatelessWidget {
  const DesignIcon(this.file, {super.key, this.size = 22});
  final String file;
  final double size;
  @override
  Widget build(BuildContext context) =>
      SvgPicture.asset('assets/figma/$file', width: size, height: size);
}

class Brand extends StatelessWidget {
  const Brand({super.key});
  @override
  Widget build(BuildContext context) => Row(
    children: [
      Container(
        width: 38,
        height: 38,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: yellow,
          borderRadius: BorderRadius.circular(11),
        ),
        child: const Text(
          'P',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
        ),
      ),
      const SizedBox(width: 10),
      const Text(
        'PathFitFinder',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
      ),
    ],
  );
}

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
    this.label, {
    super.key,
    required this.onPressed,
    this.loading = false,
    this.icon,
    this.trailing,
  });
  final String label;
  final VoidCallback? onPressed;
  final bool loading;
  final Widget? icon;
  final Widget? trailing;
  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    child: FilledButton(
      onPressed: loading ? null : onPressed,
      child: loading
          ? const SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(strokeWidth: 2, color: ink),
            )
          : Stack(
              alignment: Alignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (icon != null) ...[icon!, const SizedBox(width: 10)],
                    Flexible(child: Text(label, textAlign: TextAlign.center)),
                  ],
                ),
                if (trailing != null)
                  Align(alignment: Alignment.centerRight, child: trailing!),
              ],
            ),
    ),
  );
}

class Field extends StatelessWidget {
  const Field(this.label, {super.key, required this.child});
  final String label;
  final Widget child;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        child,
      ],
    ),
  );
}

class PageBody extends StatelessWidget {
  const PageBody({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.fromLTRB(24, 16, 24, 24),
  });
  final Widget child;
  final EdgeInsetsGeometry padding;
  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    physics: const AlwaysScrollableScrollPhysics(),
    padding: padding,
    child: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 680),
        child: child,
      ),
    ),
  );
}

class Photo extends StatelessWidget {
  const Photo(
    this.path, {
    super.key,
    this.width,
    this.height,
    this.radius = 12,
    this.fit = BoxFit.cover,
  });
  final String path;
  final double? width, height;
  final double radius;
  final BoxFit fit;
  @override
  Widget build(BuildContext context) {
    Widget fallback() => const ColoredBox(
      color: surface,
      child: Center(
        child: Icon(Icons.image_not_supported_outlined, color: muted),
      ),
    );
    Widget content;
    if (path.startsWith('assets/')) {
      content = Image.asset(
        path,
        fit: fit,
        errorBuilder: (_, _, _) => fallback(),
      );
    } else if (path.startsWith('data:image/')) {
      try {
        final comma = path.indexOf(',');
        final bytes = base64Decode(path.substring(comma + 1));
        content = Image.memory(
          bytes,
          fit: fit,
          gaplessPlayback: true,
          errorBuilder: (_, _, _) => fallback(),
        );
      } catch (_) {
        content = fallback();
      }
    } else if (path.startsWith('http://') || path.startsWith('https://')) {
      content = Image.network(
        path,
        fit: fit,
        errorBuilder: (_, _, _) => fallback(),
      );
    } else {
      content = FutureBuilder<Uint8List>(
        future: XFile(path).readAsBytes(),
        builder: (context, snapshot) => snapshot.hasData
            ? Image.memory(
                snapshot.data!,
                fit: fit,
                errorBuilder: (_, _, _) => fallback(),
              )
            : fallback(),
      );
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: SizedBox(width: width, height: height, child: content),
    );
  }
}

class ChoiceGroup extends StatelessWidget {
  const ChoiceGroup(
    this.label,
    this.options,
    this.value,
    this.onChanged, {
    super.key,
  });
  final String label, value;
  final List<String> options;
  final ValueChanged<String> onChanged;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 18),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: options.map((option) {
            final selected = option == value;
            return ChoiceChip(
              label: Text(option),
              selected: selected,
              showCheckmark: false,
              selectedColor: cream,
              backgroundColor: Colors.white,
              labelStyle: TextStyle(
                fontSize: 12,
                color: ink,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
              ),
              side: BorderSide(color: selected ? yellow : line),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onSelected: (_) => onChanged(option),
            );
          }).toList(),
        ),
      ],
    ),
  );
}

void showNotice(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}

class DashedPanel extends StatelessWidget {
  const DashedPanel({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) => CustomPaint(
    foregroundPainter: _DashedBorder(),
    child: Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: child,
    ),
  );
}

class _DashedBorder extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          (Offset.zero & size).deflate(.5),
          const Radius.circular(14),
        ),
      );
    final paint = Paint()
      ..color = const Color(0xFFC9CECA)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    for (final metric in path.computeMetrics()) {
      for (double distance = 0; distance < metric.length; distance += 9) {
        canvas.drawPath(metric.extractPath(distance, distance + 5), paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
