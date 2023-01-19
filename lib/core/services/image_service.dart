import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

/// for convert image from repaint boundary
Future<Uint8List?> captureWidget(BuildContext context) async {
  final box = context.findRenderObject() as RenderRepaintBoundary;
  final image = await box.toImage(pixelRatio: 4.0);
  final byteData = await image.toByteData(format: ImageByteFormat.png);
  final bytes = byteData!.buffer.asUint8List();

  return bytes;
}

/// for take image from galery
Future<bool> takePicture(Uint8List image) async {
  try {
    await ImageGallerySaver.saveImage(
      image,
      quality: 100,
      name: 'qr',
    );
    return true;
  } catch (e) {
    return false;
  }
}

/// save image to temp
Future<String> saveFileToTemp(Uint8List bytes) async {
  late String filePath;
  final tempDir = await getTemporaryDirectory();
  final File file = File(
    '${tempDir.path}/${DateTime.now().toIso8601String()}.png',
  );

  final raf = file.openSync(mode: FileMode.write);
  filePath = file.path;
  raf.writeFromSync(bytes);
  await raf.close();
  return filePath;
}
