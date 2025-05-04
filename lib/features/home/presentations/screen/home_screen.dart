import 'package:emendo/common/helper/app_values.dart';
import 'package:emendo/common/widgets/custom_app_bar.dart';
import 'package:emendo/features/home/presentations/widgets/search_modal.dart';
import 'package:emendo/features/home/presentations/widgets/workflow_title_show.dart';
import 'package:emendo/features/tasks/data/local/fake_tasks_db.dart';
import 'package:emendo/features/tasks/data/local/fake_workflow_db.dart';
import 'package:emendo/features/tasks/presentations/widgets/task_widget.dart';
import 'package:flutter/material.dart';
import 'package:emendo/features/home/presentations/widgets/selector_modal.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showCalenderModal = false;
  bool _showSearchModal = false;
  bool _showWorkflowSelectorModal = false;

  /// key to find calender icon and workflow selector
  final GlobalKey _calenderIconKey = GlobalKey();
  final GlobalKey _searchIconKey = GlobalKey();
  final GlobalKey _workflowSelectorKey = GlobalKey();

  /// area of calender icon and workflow selector
  Rect? _calenderIconRect;
  Rect? _searchIconRect;
  Rect? _workflowSelectorRect;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calculateCalenderIconPosition();
      _calculateWorkflowSelectorPosition();
      _calculateSearchIconPosition();
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

  ///calculate search icon position
  void _calculateSearchIconPosition() {
    final renderBox =
        _searchIconKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final offset = renderBox.localToGlobal(Offset.zero);
      setState(() {
        _searchIconRect = offset & renderBox.size;
      });
    }
  }

  ///show or hide search modal
  void _searchModal() => setState(() => _showSearchModal = !_showSearchModal);

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

  ///show or hide workflow selector modal
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
                leadingWidget: !_showSearchModal
                    ? IconButton(
                        key: _searchIconKey,
                        onPressed: () {
                          _searchModal();
                        },
                        icon: Icon(Icons.search),
                      )
                    : SizedBox.shrink(),
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
                child: ListView.builder(
                  padding: const EdgeInsets.all(30),
                  itemCount: FakeTasksDb.getTasks.length,
                  itemBuilder: (context, index) {
                    return TaskWidget(task: FakeTasksDb.getTasks[index]);
                  },
                ),
              ),
            ],
          ),

          ///workflow selector modal
          if (_workflowSelectorRect != null &&
              !_showCalenderModal &&
              !_showSearchModal &&
              _showWorkflowSelectorModal)
            SelectorModal(
              onClose: () {
                _workflowModal();
                //  _workflowSelectorRect = null;
              },
              itemList: FakeWorkflowDb.getWorkflows
                  .map((workflow) => workflow.name)
                  .toList(),
              showModal: _showWorkflowSelectorModal,
              modalRect: _workflowSelectorRect!,
            ),

          ///calender modal
          if (_calenderIconRect != null &&
              !_showWorkflowSelectorModal &&
              !_showSearchModal &&
              _showCalenderModal)
            SelectorModal(
              onClose: () {
                _calenderModal();
                //  _workflowSelectorRect = null;
              },
              itemList: [
                "mah1",
                "mah2",
                "mah3",
                "mah4",
                "mah5",
                "mah6",
                "mah7",
                "mah8",
                "mah9",
                "mah10",
                "mah11",
                "mah12",
              ],
              showModal: _showCalenderModal,
              modalRect: _calenderIconRect!,
              isRight: true,
            ),

          ///search modal
          if (_searchIconRect != null &&
              !_showCalenderModal &&
              !_showWorkflowSelectorModal &&
              _showSearchModal)
            SearchModal(
              onClose: () {
                _searchModal();
              },
              showModal: _showSearchModal,
              modalRect: _searchIconRect!,
            )
        ],
      ),
    );
  }
}

