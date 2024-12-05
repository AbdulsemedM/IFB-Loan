import 'package:flutter/material.dart';
import 'package:ifb_loan/app/app_button.dart';
import 'package:ifb_loan/app/utils/app_colors.dart';
import 'package:ifb_loan/app/utils/app_theme.dart';
import 'package:ifb_loan/features/loan_approval_status/presentation/widgets/pdf_dialog.dart';
import 'package:lottie/lottie.dart';

class ProviderUndertakingScreen extends StatefulWidget {
  final String id;
  final String undertakingAgreementtDocument;
  final String agentAgreementDocument;

  const ProviderUndertakingScreen(
      {super.key,
      required this.id,
      required this.undertakingAgreementtDocument,
      required this.agentAgreementDocument});

  @override
  State<ProviderUndertakingScreen> createState() =>
      _ProviderUndertakingScreenState();
}

class _ProviderUndertakingScreenState extends State<ProviderUndertakingScreen> {
  bool loading = false; // to control button state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[100],
      ),
      backgroundColor: Colors.orange[100],
      body: Stack(
        children: [
          // Background Animation
          Positioned.fill(
            child: Lottie.asset('assets/animation/background.json',
                fit: BoxFit.cover, repeat: false),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Step 1: Sign Agreement
                Lottie.asset(
                  'assets/animation/done.json',
                  height: 200,
                  repeat: true,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Step 1: Sign Agreements',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Text(
                    'Sign the product undertaking and supplier as agent agreements to proceed.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                ),
                const SizedBox(height: 20),

                // Step 2: Product Transfer
                const SizedBox(height: 20),
                const Text(
                  'Step 2: Transfer Product',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Text(
                    'Provide the product to the buyer on behalf of the bank to finalize the loan.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                ),

                const SizedBox(height: 40),

                // Finalize Button
                MyButton(
                  height: ScreenConfig.screenHeight * 0.055,
                  width: ScreenConfig.screenWidth,
                  backgroundColor: loading
                      ? AppColors.iconColor
                      : AppColors.primaryDarkColor,
                  onPressed: loading
                      ? () {}
                      : () async {
                          final result1 = await _showPdfDialog(
                              context, widget.agentAgreementDocument);
                          if (result1) {
                            final result2 = await _showPdfDialog(
                                context, widget.undertakingAgreementtDocument);
                            if (result2) {
                            } else {
                              setState(() {
                                loading = false;
                              });
                            }
                          }
                        },
                  buttonText: loading
                      ? SizedBox(
                          height: ScreenConfig.screenHeight * 0.02,
                          width: ScreenConfig.screenHeight * 0.02,
                          child: const CircularProgressIndicator(
                            strokeWidth: 3,
                            color: AppColors.primaryColor,
                          ),
                        )
                      : const Text(
                          "Finalize Loan Process",
                          style: TextStyle(color: AppColors.bg1),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> _showPdfDialog(BuildContext context, String pdfUrl) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return PdfDialog(
          pdfUrl: pdfUrl,
          onAccept: () {
            Navigator.pop(context, true);
          },
          onReject: () {
            Navigator.pop(context, false);
          },
        );
      },
    );

    return result ?? false;
  }
}