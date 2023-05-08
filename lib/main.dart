import 'package:flutter/material.dart';
import 'package:gif_control_speed/gifImage.dart';
import 'animation_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
  });
  @override
  State<MyApp> createState() => _MainState();
}

class _MainState extends State<MyApp> with TickerProviderStateMixin {
  late final AnimationView _a = AnimationView(c: GifController(vsync: this));
  var speed = 2000;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Stack(
          children: [
            Container(
              color: Colors.grey,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _txButton('stop', () => {_a.c.stop()}),
                    _txButton('-', () => {speed += 100}),
                    _txButton('play', () => {_a.c.streamSize.sink.add(speed)}),
                    _txButton(
                        '+', () => {speed > 200 ? speed -= 100 : speed = 200}),
                  ],
                ),
                _a,
              ],
            ),
          ],
        ));
  }

  Widget _txButton(String title, VoidCallback func) {
    return TextButton(
      onPressed: () {
        func.call();
      },
      child: Text(title),
    );
  }
}
