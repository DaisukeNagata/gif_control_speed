// ignore_for_file: file_names

import 'dart:async' show Future, StreamController;

import 'dart:ui';
import 'package:flutter/cupertino.dart';

class GifController extends AnimationController {
  GifController({required this.vsync})
      : super.unbounded(
          value: 0,
          vsync: vsync,
        );

  final TickerProvider vsync;
  final streamSize = StreamController<int>();

  @override
  void reset() {
    value = 0.0;
  }
}

class GifImage extends StatefulWidget {
  const GifImage({
    super.key,
    required this.image,
    required this.controller,
    required this.width,
    required this.height,
    this.excludeFromSemantics = false,
    this.matchTextDirection = false,
    this.gaplessPlayback = false,
  });

  final GifController controller;

  final ImageProvider image;
  final double width;
  final double height;
  final bool matchTextDirection;
  final bool gaplessPlayback;
  final bool excludeFromSemantics;
  @override
  State<StatefulWidget> createState() {
    return GifImageState();
  }
}

class GifImageState extends State<GifImage> {
  int _curIndex = 0;
  // ignore: avoid_init_to_null
  late var _infos = null;

  ImageInfo? get _imageInfo {
    return _infos == null ? null : _infos?[_curIndex];
  }

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_listener);
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller.removeListener(_listener);
  }

  void _listener() {
    if (_curIndex != widget.controller.value &&
        !widget.controller.value.isInfinite) {
      if (mounted) {
        setState(() {
          if ((widget.controller.value <= _curIndex)) {
            widget.controller.streamSize.sink.add(0);
          }
          _curIndex = widget.controller.value.toInt();
        });
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    fetchGif(widget.image).then((imageInfos) {
      if (mounted) {
        setState(() {
          _infos = imageInfos;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final RawImage image = RawImage(
      image: _imageInfo?.image,
      width: widget.width,
      height: widget.height,
      scale: _imageInfo?.scale ?? 1.0,
    );
    return image;
  }

  Future<List<ImageInfo>?> fetchGif(ImageProvider provider) async {
    List<ImageInfo>? infos = [];
    dynamic data;

    if (provider is AssetImage) {
      AssetBundleImageKey key =
          await provider.obtainKey(const ImageConfiguration());
      data = await key.bundle.load(key.name);
    }

    final codec = await instantiateImageCodec(data.buffer.asUint8List());
    infos = [];

    for (int i = 0; i < codec.frameCount; i++) {
      var frameInfo = await codec.getNextFrame();
      infos.add(ImageInfo(image: frameInfo.image));
    }
    return infos;
  }
}
