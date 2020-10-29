import 'dart:async';
import 'dart:ui' as ui show Codec, Image, Picture, ImageByteFormat;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class SvgProvider extends ImageProvider<SvgProvider> {
  final String asset;
  final String package;
  final int width;
  final int height;

  const SvgProvider(this.asset, {this.package, this.width = 100, this.height = 100});

  String get keyName => package == null ? asset : 'packages/$package/$asset';

  @override
  Future<SvgProvider> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture<SvgProvider>(this);
  }

  @override
  ImageStreamCompleter load(SvgProvider key, nil) {
    return MultiFrameImageStreamCompleter(
      codec: _loadAsync(key),
      scale: 1.0,
    );
  }

  Future<ui.Codec> _loadAsync(SvgProvider key) async {
    assert(key == this);

    var rawSvg = await rootBundle.loadString(keyName);
    final DrawableRoot svgRoot = await svg.fromSvgString(rawSvg, rawSvg);
    final ui.Picture picture = svgRoot.toPicture(
      size: Size(
        width.toDouble(),
        height.toDouble(),
      ),
      clipToViewBox: false,
    );
    final ui.Image image = await picture.toImage(width, height);
    final imageData = await image.toByteData(format: ui.ImageByteFormat.png);

    return PaintingBinding.instance
        .instantiateImageCodec(imageData.buffer.asUint8List());
  }

  @override
  bool operator ==(dynamic other) {
    if (other.runtimeType != runtimeType) return false;
    final SvgProvider typedOther = other;
    return keyName == typedOther.keyName &&
        width == typedOther.width &&
        height == typedOther.height;
  }

  @override
  int get hashCode => hashValues(keyName.hashCode, 1.0);

  @override
  String toString() => '$runtimeType(${describeIdentity(keyName)}, scale: 1.0)';
}