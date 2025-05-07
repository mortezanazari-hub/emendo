import 'package:emendo/common/helper/app_values.dart';
import 'package:emendo/common/widgets/custom_app_bar.dart';
import 'package:emendo/features/home/presentations/widgets/search_modal.dart';
import 'package:emendo/features/home/presentations/widgets/workflow_title_show.dart';
import 'package:emendo/features/tasks/data/local/fake_tasks_db.dart';
import 'package:emendo/features/tasks/data/local/fake_workflow_db.dart';
import 'package:emendo/features/tasks/data/models/task_model.dart';
import 'package:emendo/features/tasks/presentations/widgets/task_widget.dart';
import 'package:flutter/material.dart';
import 'package:emendo/features/home/presentations/widgets/selector_modal.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  bool _showCalenderModal = false;
  bool _showSearchModal = false;
  bool _showWorkflowSelectorModal = false;

  final GlobalKey _calenderIconKey = GlobalKey();
  final GlobalKey _searchIconKey = GlobalKey();
  final GlobalKey _workflowSelectorKey = GlobalKey();

  Rect? _calenderIconRect;
  Rect? _searchIconRect;
  Rect? _workflowSelectorRect;

  final List<TaskModel> _tasks = List.from(FakeTasksDb.getTasks);

  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calculateCalenderIconPosition();
      _calculateWorkflowSelectorPosition();
      _calculateSearchIconPosition();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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

  void _calenderModal() =>
      setState(() => _showCalenderModal = !_showCalenderModal);

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

  void _searchModal() => setState(() => _showSearchModal = !_showSearchModal);

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

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) newIndex--;
      final task = _tasks.removeAt(oldIndex);
      _tasks.insert(newIndex, task);

      // فقط آیتم جابجا شده رو انیمیت کن
      _controller.reset();
      _controller.forward();
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
                child: _tasks.isEmpty
                    ? Center(child: Text("No tasks available"))
                    : ListView.separated(
                        padding: const EdgeInsets.all(30),
                        itemCount: _tasks.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          return Draggable<int>(
                            data: index,
                            feedback: Material(
                              elevation: 4.0,
                              child: Container(
                                width: MediaQuery.of(context).size.width -
                                    60, // 30 padding on each side
                                child: TaskWidget(
                                  task: _tasks[index],
                                ),
                              ),
                            ),
                            childWhenDragging: Opacity(
                              opacity: 0.5,
                              child: TaskWidget(
                                task: _tasks[index],
                              ),
                            ),
                            child: DragTarget<int>(
                              onAccept: (draggedIndex) {
                                if (draggedIndex != index) {
                                  setState(() {
                                    final item = _tasks.removeAt(draggedIndex);
                                    _tasks.insert(index, item);
                                  });
                                }
                              },
                              builder: (context, candidateData, rejectedData) {
                                return AnimatedContainer(
                                  duration: Duration(milliseconds: 200),
                                  decoration: BoxDecoration(
                                    border: candidateData.isNotEmpty
                                        ? Border.all(
                                            color: Colors.blue, width: 2)
                                        : null,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: TaskWidget(
                              task: _tasks[index],
                            ),
                          );
                        },
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),

          if (_workflowSelectorRect != null &&
              !_showCalenderModal &&
              !_showSearchModal &&
              _showWorkflowSelectorModal)
            SelectorModal(
              onClose: () {
                _workflowModal();
              },
              itemList: FakeWorkflowDb.getWorkflows
                  .map((workflow) => workflow.name)
                  .toList(),
              showModal: _showWorkflowSelectorModal,
              modalRect: _workflowSelectorRect!,
            ),

          if (_calenderIconRect != null &&
              !_showWorkflowSelectorModal &&
              !_showSearchModal &&
              _showCalenderModal)
            SelectorModal(
              onClose: () {
                _calenderModal();
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