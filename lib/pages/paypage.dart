import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kawan/bloc/mutations/mutations_bloc.dart';
import 'package:kawan/bloc/mutations/mutations_events.dart';
import 'package:kawan/models/payment_qr.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class PayPage extends StatelessWidget {
  const PayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "balance",
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Scaffold(
          body: Stack(
            children: [
              MobileScanner(
                controller: MobileScannerController(
                  detectionSpeed: DetectionSpeed.noDuplicates,
                  returnImage: true,
                ),
                onDetect: (capture) {
                  final List<Barcode> barcodes = capture.barcodes;
                  final Uint8List? image = capture.image;

                  if (image != null && barcodes.first.rawValue != null) {
                    try {
                      final paymentQr = PaymentQr.fromJson(
                        jsonDecode(
                          barcodes.first.rawValue!,
                        ),
                      );

                      // pay
                      context.read<MutationsBloc>().add(
                            DeductionMutationAdded(
                              nominal: paymentQr.amount,
                              description: paymentQr.description,
                            ),
                          );

                      Navigator.of(context).pop();

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              "Pembayaran ${paymentQr.description} berhasil"),
                        ),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("QR Tidak Valid"),
                        ),
                      );
                    }
                  }
                },
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0x00000000),
                    border: Border.symmetric(
                        vertical: BorderSide(
                          color: Colors
                              .black45, // Adjust opacity and color as needed
                          width: (MediaQuery.of(context).size.width / 2) - 100,
                        ),
                        horizontal: BorderSide(
                          color: Colors.black45,
                          width: (MediaQuery.of(context).size.height / 2) - 100,
                        )),
                  ),
                  child: Center(
                    child: Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: const BoxDecoration(
                        color: Colors.white38,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ),
              const Positioned.fill(child: ScanningAnimation()),
              const Positioned.fill(
                top: 300,
                child: SizedBox(
                  width: 300,
                  child: Center(
                    child: Text(
                      "Bayar dengan kode QR",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 100,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black,
                        Colors.transparent,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                      ),
                      const SizedBox(width: 16),
                      const Text(
                        "Bayar dengan scan",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ScanningAnimation extends StatefulWidget {
  const ScanningAnimation({super.key});

  @override
  ScanningAnimationState createState() => ScanningAnimationState();
}

class ScanningAnimationState extends State<ScanningAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [
                max(_controller.value - 0.1, 0),
                _controller.value,
                min(_controller.value + 0.1, 1)
              ],
              colors: const [
                Colors.transparent,
                Colors.white30,
                Colors.transparent,
              ],
            ),
          ),
        );
      },
    );
  }
}
