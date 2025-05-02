import 'dart:ui';

import 'package:emendo/common/helper/is_dark_mode.dart';
import 'package:emendo/core/configs/app_colors.dart';
import 'package:emendo/core/configs/app_text_styles.dart';
import 'package:flutter/material.dart';

class SearchModal extends StatefulWidget {
  final bool showModal;
  final VoidCallback? onClose;
  final Rect modalRect;

  const SearchModal(
      {super.key,
      required this.showModal,
      this.onClose,
      required this.modalRect});

  @override
  State<SearchModal> createState() => _SearchModalState();
}

class _SearchModalState extends State<SearchModal>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;
  late Animation<double> _slideAnimation;
  late Animation<double> _widthAnimation;
  bool _shouldShow = false;
  late double screenWidth;

  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  void _safeClose() {
    if (mounted) {
      widget.onClose?.call();
    }
  }

  @override
  void initState() {
    super.initState();
    screenWidth = 320;
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _slideAnimation = Tween<double>(
      begin: widget.modalRect.top,
      end: widget.modalRect.top,
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

    _widthAnimation = Tween<double>(
      begin: widget.modalRect.width,
      end: screenWidth,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    if (widget.showModal) {
      _shouldShow = true;
      _animationController.forward();
      // Focus the text field when modal opens
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _focusNode.requestFocus();
        }
      });
    }
  }

  @override
  void didUpdateWidget(SearchModal oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.showModal != oldWidget.showModal) {
      if (widget.showModal) {
        setState(() {
          _shouldShow = true;
        });
        _animationController.forward();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            _focusNode.requestFocus();
          }
        });
      } else {
        _animationController.reverse();
        _textController.clear();
        _focusNode.unfocus();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_shouldShow) {
      return const SizedBox.shrink();
    }
    return AnimatedBuilder(
      animation: _animationController,
      builder: (BuildContext context, Widget? child) {
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
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                      child: Container(
                        color: Colors.black12,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: _slideAnimation.value,
              left: widget.modalRect.left,
              child: Opacity(
                opacity: _opacityAnimation.value,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: widget.modalRect.height,
                      width: _widthAnimation.value,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        cursorHeight: 16,
                        controller: _textController,
                        focusNode: _focusNode,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: context.isDarkMode
                              ? DarkColors.bgColor
                              : LightColors.bgColor,
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: context.isDarkMode
                                        ? DarkColors.primeColor
                                        : LightColors.primeColor),
                                child: Icon(
                                  Icons.search,
                                  color: context.isDarkMode
                                      ? DarkColors.white
                                      : LightColors.white,
                                )),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: 'Search...',
                          hintStyle: AppTextStyles.base(
                            context: context,
                            color: context.isDarkMode
                                ? DarkColors.primeColor
                                : LightColors.primeColor,
                          ),
                        ),
                        style: AppTextStyles.base(
                          context: context,
                          color: context.isDarkMode
                              ? DarkColors.primeColor
                              : LightColors.primeColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    Text("Result")
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
