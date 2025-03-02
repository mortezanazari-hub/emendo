import 'dart:ui';

import 'package:emendo/common/helper/app_values.dart';
import 'package:emendo/features/tasks/data/local/fake_workflow_db.dart';
import 'package:flutter/material.dart';

import 'package:emendo/features/home/presentations/screen/home_screen.dart';

class SelectorModal extends StatefulWidget {
  final Rect workflowSelectorRect;
  final bool showModal;
  final List<String> workflows; // List of items
  final VoidCallback? onClose; // Add callback for closing the modal

  const SelectorModal({
    super.key,
    required this.workflowSelectorRect,
    required this.showModal,
    required this.workflows,
    this.onClose,
  });

  @override
  State<SelectorModal> createState() => _SelectorModalState();
}

class _SelectorModalState extends State<SelectorModal>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    // Start animation from the bottom of workflowSelectorRect
    _slideAnimation = Tween<double>(
      begin: widget.workflowSelectorRect.bottom,
      end: widget.workflowSelectorRect.bottom + 10,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    // Add opacity animation
    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    // Start animation when modal is shown
    if (widget.showModal) {
      _animationController.forward();
    }
  }

  @override
  void didUpdateWidget(SelectorModal oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Handle show/hide transitions
    if (widget.showModal != oldWidget.showModal) {
      if (widget.showModal) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }

    // Update animation values if the rect changes
    if (widget.workflowSelectorRect != oldWidget.workflowSelectorRect) {
      _slideAnimation = Tween<double>(
        begin: widget.workflowSelectorRect.bottom,
        end: widget.workflowSelectorRect.bottom + 10,
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ));
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Return empty widget if modal is not showing and animation is complete
    if (!widget.showModal && _animationController.isDismissed) {
      return const SizedBox.shrink();
    }

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Stack(
          children: [
            // Backdrop filter with hole - fade in/out with animation
            Positioned.fill(
              child: Opacity(
                opacity: _opacityAnimation.value,
                child: GestureDetector(
                  // Close modal when tapping outside
                  onTap: () {
                    if (widget.showModal) {
                      widget.onClose?.call();
                    }
                  },

                  child: ClipPath(
                    clipper: IconHoleClipper(widget.workflowSelectorRect),
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
            // Animated modal with fade effect
            Positioned(
              top: _slideAnimation.value,
              left: widget.workflowSelectorRect.left,
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
                      itemCount: widget.workflows.length,
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

  const ItemInModal({
    super.key,
    required this.widget,
    required this.index,
  });

  final SelectorModal widget;

  @override
  State<ItemInModal> createState() => _ItemInModalState();
}

class _ItemInModalState extends State<ItemInModal> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: InkWell(
        //highlightColor: Colors.red,
        onTap: () {
          setState(() {
            final currentWfName = AppValues.currentWorkflow.name;
            final currentSelect = widget.widget.workflows[widget.index];
            if (currentWfName != currentSelect) {
              AppValues.currentWorkflow = FakeWorkflowDb.getWorkflows
                  .firstWhere((model) => model.name == currentSelect);
            }
            widget.widget.onClose?.call();
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(child: Text(widget.widget.workflows[widget.index])),
        ),
      ),
    );
  }
}
