import 'dart:async';
import 'dart:io';

import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/src/presentations/features/menu/student/scan_qr/provider/qr_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:scan/scan.dart';

class ScanQrSection extends StatefulWidget {
  const ScanQrSection({super.key});

  @override
  State<ScanQrSection> createState() => _ScanQrSectionState();
}

class _ScanQrSectionState extends State<ScanQrSection> {
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    }
    controller?.resumeCamera();
  }

  @override
  void dispose() {
    controller?.dispose();
    controller?.stopCamera();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller != null && mounted) {
      controller?.pauseCamera();
      controller?.resumeCamera();
    }
    return _buildBody();
  }

  Widget _buildBody() {
    final qrNotifier = context.read<QrNotifier>();
    return Stack(
      children: [
        Positioned.fill(
          child: LayoutBuilder(
            builder: (context, constraint) {
              final size = constraint.maxWidth - 48;
              return QRView(
                key: qrKey,
                // formatsAllowed: widget.formatsAllowed,
                onQRViewCreated: _onQRViewCreated,
                overlay: QrScannerOverlayShape(
                  borderRadius: 24.0,
                  borderColor: Palette.primary,
                  borderWidth: 8,
                  overlayColor: Colors.black38,
                  cutOutWidth: size,
                  cutOutHeight: size,
                ),
              );
            },
          ),
        ),
        if (controller != null)
          Positioned(
            bottom: 48,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  shape: const CircleBorder(
                    side: BorderSide(color: Colors.white, width: 2),
                  ),
                  backgroundColor: Palette.primaryVariant,
                  onPressed: () {
                    controller?.flipCamera();
                  },
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: SvgPicture.asset(
                      'assets/icons/flip_camera_icon.svg',
                      color: Colors.white,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                FloatingActionButton(
                  shape: const CircleBorder(
                    side: BorderSide(color: Colors.white, width: 2),
                  ),
                  backgroundColor: Palette.onPrimary,
                  onPressed: () {
                    controller?.toggleFlash();
                  },
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: SvgPicture.asset(
                      'assets/icons/flash_icon.svg',
                      color: Colors.white,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                FloatingActionButton(
                  shape: const CircleBorder(
                    side: BorderSide(color: Colors.white, width: 2),
                  ),
                  backgroundColor: Palette.primaryVariant,
                  onPressed: () async {
                    final picked = await ImagePicker().pickImage(
                      source: ImageSource.gallery,
                      maxWidth: 1920,
                      maxHeight: 1920,
                      imageQuality: 100,
                    );

                    if (picked != null) {
                      final String? data = await Scan.parse(picked.path);
                      if (data != null) {
                        qrNotifier.setQrCode(data);
                      }
                    }
                  },
                  child: const SizedBox(
                    width: 24,
                    height: 24,
                    child: Icon(
                      Icons.image_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          )
      ],
    );
  }

  Future<void> _onQRViewCreated(QRViewController controller) async {
    final qrNotifier = context.read<QrNotifier>();
    this.controller = controller;
    setState(() {});
    controller.scannedDataStream.listen((scanData) {
      if (scanData.code != null) {
        if (scanData.code!.isNotEmpty) {
          qrNotifier.setQrCode(scanData.code!);
        }
      }
    });
  }
}
