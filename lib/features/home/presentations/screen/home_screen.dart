import 'package:emendo/common/helper/app_values.dart';
import 'package:emendo/common/widgets/custom_app_bar.dart';
import 'package:emendo/features/home/presentations/widgets/workflow_title_show.dart';
import 'package:emendo/features/tasks/data/local/fake_workflow_db.dart';
import 'package:flutter/material.dart';

import 'dart:ui';

import '../widgets/selector_modal.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showCalenderModal = false;
  bool _showWorkflowSelectorModal = false;

  /// key to find calender icon and workflow selector
  final GlobalKey _calenderIconKey = GlobalKey();
  final GlobalKey _workflowSelectorKey = GlobalKey();

  /// area of calender icon and workflow selector
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

  ///calculate calender icon position
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

  ///show or hide calender list modal
  void _calenderModal() =>
      setState(() => _showCalenderModal = !_showCalenderModal);

  ///calculate workflow selector position
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

  void _workflowModal() {
    setState(() {
      _showWorkflowSelectorModal = !_showWorkflowSelectorModal;
    });
  }

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
                  workflowName: AppValues.currentWorkflow.name,
                  onTap: () {
                    _workflowModal();
                  },
                ),
                actionButton: IconButton(
                  key: _calenderIconKey,
                  onPressed: () {
                    _calenderModal();
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
                    color: Colors.black,
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
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
          if (_workflowSelectorRect != null && !_showCalenderModal)
            SelectorModal(
              onClose: () {
                _workflowModal();
                //  _workflowSelectorRect = null;
              },
              workflows: FakeWorkflowDb.getWorkflows
                  .map((workflow) => workflow.name)
                  .toList(),
              showModal: _showWorkflowSelectorModal,
              workflowSelectorRect: _workflowSelectorRect!,
            )
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
