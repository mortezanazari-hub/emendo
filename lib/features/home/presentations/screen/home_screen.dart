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

  // کلید برای لیست انیمیشن
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  // دیوریشن انیمیشن‌ها
  final Duration _animationDuration = const Duration(milliseconds: 300);

  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
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


  // متد بهبود یافته با انیمیشن برای مدیریت تغییر وضعیت تسک‌ها
  void _onTaskStatusChanged(int index, bool isDone) {
    final task = _tasks[index];

    // ابتدا تسک را با انیمیشن حذف می‌کنیم
    _listKey.currentState?.removeItem(
      index,
      (context, animation) => _buildTaskItem(context, task, index, animation),
      duration: _animationDuration,
    );

    // مقداری تاخیر قبل از اضافه کردن مجدد تسک به لیست
    Future.delayed(_animationDuration, () {
      setState(() {
        // تسک را از لیست اصلی حذف می‌کنیم
        _tasks.removeAt(index);

        int newIndex;
        if (isDone) {
          // اگر تسک انجام شده، آن را به انتهای لیست اضافه کن
          _tasks.add(task);
          newIndex = _tasks.length - 1;
        } else {
          // اگر تسک از حالت انجام‌شده خارج شد، آن را قبل از اولین تسک انجام‌شده قرار بده
          int firstCompletedTaskIndex = _tasks.indexWhere((t) => t.isDone);
          if (firstCompletedTaskIndex != -1) {
            _tasks.insert(firstCompletedTaskIndex, task);
            newIndex = firstCompletedTaskIndex;
          } else {
            _tasks.add(task);
            newIndex = _tasks.length - 1;
          }
        }

        // اضافه کردن تسک به موقعیت جدید با انیمیشن
        _listKey.currentState?.insertItem(
          newIndex,
          duration: _animationDuration,
        );
      });
    });
  }

  // ساخت آیتم تسک برای انیمیشن
  Widget _buildTaskItem(BuildContext context, TaskModel task, int index,
      Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: FadeTransition(
        opacity: animation,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.2, 0.0),
            end: Offset.zero,
          ).animate(animation),
          child: Draggable<int>(
            data: index,
            feedback: Material(
              elevation: 4.0,
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 60,
                child: TaskWidget(
                  task: task,
                  onStatusChanged: (_) {},
                ),
              ),
            ),
            childWhenDragging: Opacity(
              opacity: 0.5,
              child: TaskWidget(
                task: task,
                onStatusChanged: (_) {},
              ),
            ),
            child: DragTarget<int>(
              onAccept: (draggedIndex) {
                if (draggedIndex != index) {
                  setState(() {
                    final item = _tasks.removeAt(draggedIndex);
                    _tasks.insert(index, item);

                    // انیمیشن برای آیتم‌های جابجاشده
                    _listKey.currentState?.setState(() {});
                  });
                }
              },
              builder: (context, candidateData, rejectedData) {
                return AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    border: candidateData.isNotEmpty
                        ? Border.all(color: Colors.blue, width: 2)
                        : null,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TaskWidget(
                    task: task,
                    onStatusChanged: (isDone) =>
                        _onTaskStatusChanged(index, isDone),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
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
                    : AnimatedList(
                        key: _listKey,
                        padding: const EdgeInsets.all(30),
                        initialItemCount: _tasks.length,
                        itemBuilder: (context, index, animation) {
                          return _buildTaskItem(
                              context, _tasks[index], index, animation);
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