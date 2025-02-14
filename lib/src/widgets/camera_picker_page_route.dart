///
/// [Author] Alex (https://github.com/AlexV525)
/// [Date] 2020/7/15 21:44
///
import 'package:flutter/material.dart';

/// Build [AssetPickerPageRoute] with the given generic type.
/// 构建匹配泛型的 [AssetPickerPageRoute]
typedef CameraPickerPageRouteBuilder<T> = CameraPickerPageRoute<T> Function(
  Widget picker,
);

/// Built a slide page transition for the picker.
/// 为选择器构造一个上下进出的页面过渡动画
class CameraPickerPageRoute<T> extends PageRoute<T> {
  CameraPickerPageRoute({
    required this.builder,
    this.transitionCurve = Curves.easeIn,
    this.transitionDuration = const Duration(milliseconds: 300),
    this.barrierColor,
    this.barrierDismissible = false,
    this.barrierLabel,
    this.maintainState = true,
    this.opaque = true,
    this.canTransitionFromPredicate,
  });

  final WidgetBuilder builder;

  final Curve transitionCurve;
  @override
  final Duration transitionDuration;

  @override
  final Color? barrierColor;
  @override
  final bool barrierDismissible;
  @override
  final String? barrierLabel;
  @override
  final bool opaque;
  @override
  final bool maintainState;

  final bool Function(TransitionRoute<dynamic>)? canTransitionFromPredicate;

  @override
  bool canTransitionFrom(TransitionRoute<dynamic> previousRoute) =>
      canTransitionFromPredicate?.call(previousRoute) ?? false;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return builder(context);
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(curve: transitionCurve, parent: animation),
      ),
      child: child,
    );
  }
}
