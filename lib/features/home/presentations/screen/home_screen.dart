import 'package:emendo/common/widgets/custom_app_bar.dart';
import 'package:emendo/features/home/presentations/widgets/workflow_title_show.dart';
import 'package:emendo/features/tasks/data/local/fake_workflow_db.dart';
import 'package:flutter/material.dart';

import 'dart:ui';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showCalenderModal = false;
  bool _showWorkflowSelectorModal = false;

  // برای دسترسی به مختصات آیکون
  final GlobalKey _calenderIconKey = GlobalKey();
  final GlobalKey _workflowSelectorKey = GlobalKey();
  Rect? _calenderIconRect;
  Rect? _workflowSelectorRect;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calculateCalenderIconPosition();
      _calculateWorkflowSelectorPosition();
    });
  }

  void _calculateCalenderIconPosition() {
    final renderBox =
        _calenderIconKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final offset = renderBox.localToGlobal(Offset.zero);
      setState(() {
        _calenderIconRect = offset & renderBox.size;
      });
    }
  }

  void _openCalenderModal() => setState(() => _showCalenderModal = true);

  void _closeCalenderModal() => setState(() => _showCalenderModal = false);

  void _calculateWorkflowSelectorPosition() {
    final renderBox =
        _workflowSelectorKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final offset = renderBox.localToGlobal(Offset.zero);
      setState(() {
        _workflowSelectorRect = offset & renderBox.size;
      });
    }
  }

  void _openWorkflowSelectorModal() =>
      setState(() => _showWorkflowSelectorModal = true);

  void _closeWorkflowSelectorModal() =>
      setState(() => _showWorkflowSelectorModal = false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              CustomAppBar(
                leadingWidget: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.search),
                ),
                title: WorkflowTitleShow(
                  key: _workflowSelectorKey,
                  workflowName: FakeWorkflowDb.getWorkflows[0].name,
                  onTap: () {
                    setState(() {
                      _openWorkflowSelectorModal();
                    });
                  },
                ),
                actionButton: IconButton(
                  key: _calenderIconKey,
                  onPressed: () {
                    setState(() {
                      _openCalenderModal();
                    });
                  },
                  icon: Icon(Icons.calendar_month),
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: const [
                    ListTile(
                      title: Text(
                          'Edit my proposalEdit my proposalEdit my proposalEdit my proposal'),
                      subtitle: Text('2025/03/02 - 12:00 PM'),
                      trailing: Text('10/18'),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (_showCalenderModal && _calenderIconRect != null) ...[
            Positioned.fill(
              child: ClipPath(
                clipper: IconHoleClipper(_calenderIconRect!),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                  child: Container(
                    color: Colors.black.withOpacity(0.3),
                  ),
                ),
              ),
            ),
            // خودِ مودال یا کارت وسط صفحه
            Positioned.fill(
              child: Center(
                child: Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    width: 300,
                    height: 300,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('تقویم یا محتوای دیگر...'),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _closeCalenderModal,
                          child: const Text('بستن'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
          if (_showWorkflowSelectorModal && _workflowSelectorRect != null) ...[
            Positioned.fill(
              child: ClipPath(
                clipper: IconHoleClipper(_workflowSelectorRect!),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                  child: Container(
                    color: Colors.black.withOpacity(0.3),
                  ),
                ),
              ),
            ),
            // خودِ مودال یا کارت وسط صفحه
            Positioned.fill(
              child: Center(
                child: Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    width: 300,
                    height: 300,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('انتخاب گر ورکفلو یا محتوای دیگر...'),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _closeWorkflowSelectorModal,
                          child: const Text('بستن'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class IconHoleClipper extends CustomClipper<Path> {
  final Rect iconRect;

  IconHoleClipper(this.iconRect);

  @override
  Path getClip(Size size) {
    // مسیر اصلی کل صفحه
    final path = Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    // یک RRect (مستطیل با گوشه‌های گرد) دور آیکون
    final RRect iconHole = RRect.fromRectAndRadius(
      iconRect.inflate(0), // کمی فاصله از لبه‌های آیکون
      const Radius.circular(50),
    );

    // اضافه کردن مسیر آیکون به عنوان سوراخ
    path.addRRect(iconHole);
    path.fillType = PathFillType.evenOdd; // ناحیه دوم را از اول کم می‌کند

    return path;
  }

  @override
  bool shouldReclip(IconHoleClipper oldClipper) {
    return oldClipper.iconRect != iconRect;
  }
}
