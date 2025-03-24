import 'dart:ui';

import 'package:emendo/common/helper/app_values.dart';
import 'package:emendo/features/tasks/data/local/fake_workflow_db.dart';
import 'package:flutter/material.dart';

import 'package:emendo/features/home/presentations/screen/home_screen.dart';

class SelectorModal extends StatefulWidget {
  final Rect modalRect;
  final bool showModal;
  final List<String> itemList;
  final VoidCallback? onClose;
  final bool? isRight;

  const SelectorModal({
    super.key,
    required this.modalRect,
    required this.showModal,
    required this.itemList,
    this.onClose,
    this.isRight,
  });

  @override
  State<SelectorModal> createState() => _SelectorModalState();
}

class _SelectorModalState extends State<SelectorModal>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;
  late Animation<double> _opacityAnimation;
  bool _shouldShow = false;

  void _safeClose() {
    if (mounted) {
      widget.onClose?.call();
    }
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _slideAnimation = Tween<double>(
      begin: widget.modalRect.bottom,
      end: widget.modalRect.bottom + 10,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    if (widget.showModal) {
      _shouldShow = true;
      _animationController.forward();
    }

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        setState(() {
          _shouldShow = false;
        });
        _safeClose();
      }
    });
  }

  @override
  void didUpdateWidget(SelectorModal oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.showModal != oldWidget.showModal) {
      if (widget.showModal) {
        setState(() {
          _shouldShow = true;
        });
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_shouldShow) {
      return const SizedBox.shrink();
    }

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Stack(
          children: [
            Positioned.fill(
              child: Opacity(
                opacity: _opacityAnimation.value,
                child: GestureDetector(
                  onTap: () {
                    if (widget.showModal && !_animationController.isAnimating) {
                      _safeClose();
                    }
                  },
                  child: ClipPath(
                    clipper: IconHoleClipper(widget.modalRect),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                      child: Container(
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: _slideAnimation.value,
              left: (widget.isRight != true) ? widget.modalRect.left : null,
              right: (widget.isRight == true) ? 15 : null,
              child: Opacity(
                opacity: _opacityAnimation.value,
                child: Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(12),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxHeight: 250,
                      maxWidth: 200,
                      minHeight: 100,
                    ),
                    child: ListView.builder(
                      itemCount: widget.itemList.length,
                      itemBuilder: (context, index) {
                        return ItemInModal(
                          widget: widget,
                          index: index,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class ItemInModal extends StatefulWidget {
  final int index;
  final SelectorModal widget;

  const ItemInModal({
    super.key,
    required this.widget,
    required this.index,
  });

  @override
  State<ItemInModal> createState() => _ItemInModalState();
}

class _ItemInModalState extends State<ItemInModal> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: InkWell(
        onTap: () {
          setState(() {
            final currentWfName = AppValues.currentWorkflow.name;
            final currentSelect = widget.widget.itemList[widget.index];
            if (currentWfName != currentSelect) {
              AppValues.currentWorkflow = FakeWorkflowDb.getWorkflows
                  .firstWhere((model) => model.name == currentSelect);
            }
            widget.widget.onClose?.call();
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(child: Text(widget.widget.itemList[widget.index])),
        ),
      ),
    );
  }
}
