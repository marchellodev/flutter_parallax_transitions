import 'dart:math';

import 'package:flutter/material.dart';

import '../flutter_parallax_transitions.dart';

enum ClipperOrigin { leftUp, rightUp, leftDown, rightDown, middle }

class RippleClipper extends CustomClipper<Path> {
  RippleClipper({required this.origin, required this.progress});

  final ClipperOrigin origin;
  final double progress;

  @override
  Path getClip(Size size) {
    final Map center = <ClipperOrigin, Offset>{
      ClipperOrigin.leftUp: Offset(0, size.height),
      ClipperOrigin.rightUp: Offset(size.width, size.height),
      ClipperOrigin.leftDown: Offset.zero,
      ClipperOrigin.rightDown: Offset(size.width, 0),
      ClipperOrigin.middle: Offset(size.width * .5, size.height * .5),
    };
    final path = Path();
    final radius = sqrt(pow(size.width, 2) + pow(size.height, 2));
    path.addOval(
      Rect.fromCircle(
        center: center[origin] as Offset,
        radius: radius * progress,
      ),
    );
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class TransitionEffect {
  late TransitionWidgetBuilder _customEffect;

  TransitionEffect() {
    _customEffect = (
      Curve curve,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
    ) {
      return child;
    };
  }

  TransitionWidgetBuilder get customEffect => _customEffect;

  set createCustomEffect(TransitionWidgetBuilder handle) {
    _customEffect = handle;
  }

  static TransitionWidgetBuilder createFadeIn() {
    return (
      Curve curve,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
    ) =>
        FadeTransition(opacity: animation, child: child);
  }

  static TransitionWidgetBuilder createTransfer({
    required Tween<Offset> animationTween,
    required Tween<Offset> secondaryAnimationTween,
    required Tween<double> animationScaleTween,
    required Tween<double> secondaryAnimationScaleTween,
  }) {
    return (
      Curve curve,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
    ) {
      // secondaryAnimationTween.ani
      final secondaryPage = SlideTransition(
        position: secondaryAnimationTween.animate(
          CurvedAnimation(
            parent: secondaryAnimation,
            curve: Interval(0.3, 0.7, curve: curve),
          ),
        ),
        child: ScaleTransition(
          scale: secondaryAnimationScaleTween.animate(
            CurvedAnimation(
              parent: secondaryAnimation,
              curve: Interval(0.0, 0.3, curve: curve),
            ),
          ),
          child: ScaleTransition(
            scale: secondaryAnimationScaleTween.animate(
              CurvedAnimation(
                parent: secondaryAnimation,
                curve: Interval(0.7, 1.0, curve: curve),
              ),
            ),
            child: child,
          ),
        ),
      );

      // 离开动效
      return SlideTransition(
        position: animationTween.animate(
          CurvedAnimation(
            parent: animation,
            curve: Interval(0.3, 0.7, curve: curve),
          ),
        ),
        child: ScaleTransition(
          scale: animationScaleTween.animate(
            CurvedAnimation(
              parent: animation,
              curve: Interval(0.0, 0.3, curve: curve),
            ),
          ),
          child: ScaleTransition(
            scale: animationScaleTween.animate(
              CurvedAnimation(
                parent: animation,
                curve: Interval(0.7, 1.0, curve: curve),
              ),
            ),
            child: secondaryPage,
          ),
        ),
      );
    };
  }

  static TransitionWidgetBuilder createSlideIn(Tween<Offset> tween) {
    return (
      Curve curve,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
    ) =>
        SlideTransition(
          position:
              tween.animate(CurvedAnimation(parent: animation, curve: curve)),
          child: child,
        );
  }

  static TransitionWidgetBuilder createSlide({
    required Tween<Offset> animationTween,
    required Tween<Offset> secondaryAnimationTween,
  }) {
    return (
      Curve curve,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
    ) =>
        SlideTransition(
          position: animationTween.animate(animation),
          child: SlideTransition(
            position: secondaryAnimationTween.animate(secondaryAnimation),
            child: child,
          ),
        );
  }

  static TransitionWidgetBuilder createZoomSlide({
    required Tween<Offset> animationTween,
    required Tween<double> secondaryAnimationTween,
  }) {
    return (
      Curve curve,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
    ) =>
        SlideTransition(
          position: animationTween.animate(animation),
          child: ScaleTransition(
            scale: secondaryAnimationTween.animate(secondaryAnimation),
            child: child,
          ),
        );
  }

  static TransitionWidgetBuilder createRipple({required ClipperOrigin origin}) {
    return (
      Curve curve,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
    ) =>
        ClipPath(
          clipper: RippleClipper(origin: origin, progress: animation.value),
          child: child,
        );
  }
}
