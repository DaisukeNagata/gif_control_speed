import 'package:flutter/material.dart';
import 'package:gif_control_speed/submain.dart';

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
      if (value == 0) {
        widget.c
          ..reset()
          ..stop();
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SubMainPage(
                title: 'EveryDaySoft',
              ),
            ));
      } else {
        widget.c.repeat(min: 0, max: 100, period: Duration(milliseconds: value));
      }
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
      image: const AssetImage("assets/g2vO.gif"),
      height: 200,
      width: 200,
    );
  }
}
