import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:wms_mobile/utils/constants/app_colors_const.dart';

class BarcodeScannerBox extends StatefulWidget {
  const BarcodeScannerBox({
    super.key,
    required this.onDetect,
    this.height = 176,
    this.hint = 'Point camera at barcode',
    this.subHint = 'Auto-detects QR / Code128',
    this.icon = Icons.qr_code_scanner_rounded,
  });

  final ValueChanged<String> onDetect;
  final double height;
  final String hint;
  final String subHint;
  final IconData icon;

  @override
  State<BarcodeScannerBox> createState() => _BarcodeScannerBoxState();
}

class _BarcodeScannerBoxState extends State<BarcodeScannerBox> {
  MobileScannerController? _controller;
  bool _enabled = false;
  bool _busy = false;

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _enableScanner() async {
    if (_enabled) return;

    final controller = MobileScannerController(
      detectionSpeed: DetectionSpeed.normal,
      facing: CameraFacing.back,
    );

    setState(() {
      _controller = controller;
      _enabled = true;
      _busy = false;
    });
  }

  Future<void> _disableScanner() async {
    final controller = _controller;
    setState(() {
      _enabled = false;
      _controller = null;
      _busy = false;
    });
    await controller?.dispose();
  }

  void _handleDetect(BarcodeCapture capture) {
    if (!_enabled || _busy) return;

    final code = _readFirstCode(capture);
    if (code == null) return;

    _busy = true;
    HapticFeedback.mediumImpact();

    final oldController = _controller;
    setState(() {
      _enabled = false;
      _controller = null;
    });
    oldController?.dispose();

    widget.onDetect(code);
  }

  String? _readFirstCode(BarcodeCapture capture) {
    for (final barcode in capture.barcodes) {
      final value = barcode.rawValue?.trim();
      if (value != null && value.isNotEmpty) {
        return value;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        color: AppColorsConst.white04,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColorsConst.white15, width: 2),
      ),
      clipBehavior: Clip.antiAlias,
      child: !_enabled
          ? Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: _enableScanner,
                child: _IdlePrompt(
                  icon: widget.icon,
                  hint: 'Tap to open scanner',
                  subHint: widget.subHint,
                ),
              ),
            )
          : Stack(
              fit: StackFit.expand,
              children: [
                MobileScanner(
                  controller: _controller,
                  onDetect: _handleDetect,
                  errorBuilder: (context, error) {
                    return const _IdlePrompt(
                      icon: Icons.videocam_off_outlined,
                      hint: 'Camera permission needed',
                      subHint: 'Close and try again · or use manual entry',
                    );
                  },
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Material(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(20),
                    child: InkWell(
                      onTap: _disableScanner,
                      borderRadius: BorderRadius.circular(20),
                      child: const Padding(
                        padding: EdgeInsets.all(8),
                        child: Icon(
                          Icons.close_rounded,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                IgnorePointer(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        widget.hint,
                        style: const TextStyle(
                          color: AppColorsConst.white50,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

class _IdlePrompt extends StatelessWidget {
  const _IdlePrompt({
    required this.icon,
    required this.hint,
    required this.subHint,
  });

  final IconData icon;
  final String hint;
  final String subHint;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 38, color: AppColorsConst.white20),
        const SizedBox(height: 12),
        Text(
          hint,
          style: const TextStyle(color: AppColorsConst.white30, fontSize: 14),
        ),
        const SizedBox(height: 4),
        Text(
          subHint,
          style: const TextStyle(
            fontSize: 11,
            fontFamily: 'monospace',
            color: AppColorsConst.white20,
          ),
        ),
      ],
    );
  }
}
