import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../auth/providers/profile_provider.dart';
import '../../../core/services/audio_service.dart';

class TracingScreen extends ConsumerStatefulWidget {
  final String char;
  const TracingScreen({super.key, required this.char});

  @override
  ConsumerState<TracingScreen> createState() => _TracingScreenState();
}

class _TracingScreenState extends ConsumerState<TracingScreen> {
  List<Offset?> _points = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFCF0),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Text(
                    widget.char,
                    style: TextStyle(
                      fontSize: 300,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.withOpacity(0.1),
                    ),
                  ),
                  GestureDetector(
                    onPanUpdate: (details) {
                      setState(() {
                        RenderBox renderBox = context.findRenderObject() as RenderBox;
                        _points.add(renderBox.globalToLocal(details.globalPosition));
                      });
                    },
                    onPanEnd: (details) => _points.add(null),
                    child: CustomPaint(
                      painter: TracingPainter(points: _points),
                      size: Size.infinite,
                    ),
                  ),
                ],
              ),
            ),
            _buildActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(icon: const Icon(Icons.close, size: 30), onPressed: () => Navigator.pop(context)),
          Text("Desenhe a Letra ${widget.char}", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () => setState(() => _points = [])),
        ],
      ),
    );
  }

  Widget _buildActions() {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF6C5CE7),
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 60),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        onPressed: () {
          ref.read(audioServiceProvider).playCorrect();
          ref.read(profileProvider.notifier).updateStars(25);
          ref.read(profileProvider.notifier).updateProgress('writing', 0.05);
          Navigator.pop(context);
        },
        child: const Text("CONCLUÍDO!", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
    );
  }
}

class TracingPainter extends CustomPainter {
  final List<Offset?> points;
  TracingPainter({required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = const Color(0xFF6C5CE7)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 12.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(TracingPainter oldDelegate) => true;
}
