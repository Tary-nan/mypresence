import 'package:flutter/material.dart';

class FadeTransitionWidget extends StatefulWidget {
  FadeTransitionWidget({this.child});
  final Widget child;
  @override
  _FadeTransitionWidgetState createState() => _FadeTransitionWidgetState();
}

class _FadeTransitionWidgetState extends State<FadeTransitionWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;
  CurvedAnimation _curve;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _curve = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _animation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(_curve);

    /*_animation.addStatusListener((status) {
      if (status == AnimationStatus.completed)
        _controller.reverse();
      if (status == AnimationStatus.dismissed) _controller.reverse();
    });
    */
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    _controller.forward();
    return FadeTransition(
          opacity: _animation,
          child: widget.child,
        );
      }
  }

  