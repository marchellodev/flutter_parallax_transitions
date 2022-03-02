library flutter_parallax_transitions;

import 'package:flutter/widgets.dart';

import 'src/transition.dart';
import 'src/transition_types.dart';
import 'src/tweens.dart';

export 'src/transition_types.dart';

typedef TransitionWidgetBuilder = Widget Function(
  Curve,
  Animation<double>,
  Animation<double>,
  Widget,
);

final Map<PageTransitionType, TransitionWidgetBuilder> _effectMap = {
  PageTransitionType.custom: TransitionEffect().customEffect,
  PageTransitionType.fadeIn: TransitionEffect.createFadeIn(),
  PageTransitionType.transferRight: TransitionEffect.createTransfer(
    animationTween: t1,
    secondaryAnimationTween: t5,
    animationScaleTween: t14,
    secondaryAnimationScaleTween: t13,
  ),
  PageTransitionType.transferUp: TransitionEffect.createTransfer(
    animationTween: t3,
    secondaryAnimationTween: t7,
    animationScaleTween: t14,
    secondaryAnimationScaleTween: t13,
  ),
  PageTransitionType.slideInLeft: TransitionEffect.createSlideIn(t1),
  PageTransitionType.slideInRight: TransitionEffect.createSlideIn(t2),
  PageTransitionType.slideInUp: TransitionEffect.createSlideIn(t3),
  PageTransitionType.slideInDown: TransitionEffect.createSlideIn(t4),
  PageTransitionType.slideLeft: TransitionEffect.createSlide(
    animationTween: t1,
    secondaryAnimationTween: t5,
  ),
  PageTransitionType.slideRight: TransitionEffect.createSlide(
    animationTween: t2,
    secondaryAnimationTween: t6,
  ),
  PageTransitionType.slideUp: TransitionEffect.createSlide(
    animationTween: t3,
    secondaryAnimationTween: t7,
  ),
  PageTransitionType.slideDown: TransitionEffect.createSlide(
    animationTween: t4,
    secondaryAnimationTween: t8,
  ),
  PageTransitionType.slideParallaxLeft: TransitionEffect.createSlide(
    animationTween: t1,
    secondaryAnimationTween: t9,
  ),
  PageTransitionType.slideParallaxRight: TransitionEffect.createSlide(
    animationTween: t2,
    secondaryAnimationTween: t10,
  ),
  PageTransitionType.slideParallaxUp: TransitionEffect.createSlide(
    animationTween: t3,
    secondaryAnimationTween: t11,
  ),
  PageTransitionType.slideParallaxDown: TransitionEffect.createSlide(
    animationTween: t4,
    secondaryAnimationTween: t12,
  ),
  PageTransitionType.slideZoomLeft: TransitionEffect.createZoomSlide(
    animationTween: t1,
    secondaryAnimationTween: t13,
  ),
  PageTransitionType.slideZoomRight: TransitionEffect.createZoomSlide(
    animationTween: t2,
    secondaryAnimationTween: t13,
  ),
  PageTransitionType.slideZoomUp: TransitionEffect.createZoomSlide(
    animationTween: t3,
    secondaryAnimationTween: t13,
  ),
  PageTransitionType.slideZoomDown: TransitionEffect.createZoomSlide(
    animationTween: t4,
    secondaryAnimationTween: t13,
  ),
  PageTransitionType.rippleRightUp:
      TransitionEffect.createRipple(origin: ClipperOrigin.rightUp),
  PageTransitionType.rippleLeftUp:
      TransitionEffect.createRipple(origin: ClipperOrigin.leftUp),
  PageTransitionType.rippleLeftDown:
      TransitionEffect.createRipple(origin: ClipperOrigin.leftDown),
  PageTransitionType.rippleRightDown:
      TransitionEffect.createRipple(origin: ClipperOrigin.rightDown),
  PageTransitionType.rippleMiddle:
      TransitionEffect.createRipple(origin: ClipperOrigin.middle),
  PageTransitionType.slidePageLeft: TransitionEffect.createSlide(
    animationTween: t1,
    secondaryAnimationTween: tp9,
  ),
  PageTransitionType.slidePageRight: TransitionEffect.createSlide(
    animationTween: t2,
    secondaryAnimationTween: tp10,
  ),
  PageTransitionType.slidePageUp: TransitionEffect.createSlide(
    animationTween: t3,
    secondaryAnimationTween: tp11,
  ),
  PageTransitionType.slidePageDown: TransitionEffect.createSlide(
    animationTween: t4,
    secondaryAnimationTween: tp12,
  ),
};

TransitionWidgetBuilder getEffect(
  PageTransitionType type,
) {
  return _effectMap[type]!;
}

class PageTransition extends PageRouteBuilder {
  final Widget child;
  final PageTransitionType type;
  final Curve curve;
  final Alignment? alignment;
  final Duration duration;

  PageTransition({
    required this.child,
    required this.type,
    this.curve = Curves.linear,
    this.alignment,
    this.duration = const Duration(milliseconds: 200),
  }) : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return child;
          },
          transitionDuration: duration,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            return getEffect(type)(
              curve,
              animation,
              secondaryAnimation,
              child,
            ) as Widget;
          },
        );
}
