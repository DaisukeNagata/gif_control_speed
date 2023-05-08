import 'package:flutter/material.dart';

import 'gifImage.dart';

class AnimationView extends StatefulWidget {
  const AnimationView({
    super.key,
    required this.c,
  });

  final GifController c;

  @override
  AnimationViewState createState() => AnimationViewState();
}

class AnimationViewState extends State<AnimationView>
    with TickerProviderStateMixin {
  late GifController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.c;
    _controller.streamSize.stream.listen((value) {
      _controller.repeat(
        min: 0,
        max: 149,
        period: Duration(milliseconds: value == 0 ? 1000 : value),
      );
    });
  }

  @override
  void dispose() {
    widget.c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildAnimation(context);
  }

  Widget _buildAnimation(BuildContext context) {
    return GifImage(
      controller: widget.c,
      image: const AssetImage("assets/animation.webp"),
      height: MediaQuery.of(context).size.width,
      width: MediaQuery.of(context).size.width,
    );
  }
}
