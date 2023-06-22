import 'package:flutter/material.dart';

class PageAnimationRoutes extends PageRouteBuilder {
  final Widget widget;
  final double ejex;
  final double ejey;
  PageAnimationRoutes({
    required this.widget,
    required this.ejex,
    required this.ejey,
  }) : super(
          transitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secAnimation,
              Widget child) {
            animation = CurvedAnimation(
              parent: animation,
              curve: Curves.fastOutSlowIn,
            );
            return ScaleTransition(
              alignment: Alignment(ejex, ejey),
              scale: animation,
              child: child,
            );
          },
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secAnimation) {
            return widget;
          },
        );
}
