import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ifb_loan/app/utils/dialog_utils.dart';
import 'package:ifb_loan/features/forgot_password/presentation/widget/email_password_section.dart';
import 'package:ifb_loan/features/otp/bloc/otp_bloc.dart';
import 'package:ifb_loan/features/otp/presentation/screen/otp_screen.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _otpController = TextEditingController();
  GlobalKey<FormState> myKey = GlobalKey();
  GlobalKey<FormState> myKey1 = GlobalKey();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool loading = false;
    // bool phoneSent = false;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Forgot Password".tr,
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
      body: BlocListener<OtpBloc, OtpState>(
        listener: (context, state) {
          if (state is PhoneNumberSentFailure) {
            setState(() {
              loading = true;
            });
          } else if (state is PhoneNumberSentSuccess) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => OtpScreen(
                          phoneNumber: _emailController.text,
                          password: _passwordController.text,
                        )));
          } else if (state is PhoneNumberSentFailure) {
            setState(() {
              loading = false;
            });
            displaySnack(context, state.errorMessage, Colors.red);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Email and Password Inputs with Send OTP Button
              EmailPasswordSection(
                myKey: myKey,
                emailController: _emailController,
                passwordController: _passwordController,
                confirmPasswordController: _confirmPasswordController,
                loading: loading,
                onSendOtp: () async {
                  if (myKey.currentState!.validate()) {
                    context.read<OtpBloc>().add(
                        SendPhoneNumber(phoneNumber: _emailController.text));

                    // phoneSent = true;
                  }
                },
              ),

              const SizedBox(height: 24),

              // // Divider
              // const Divider(
              //   color: Colors.grey,
              //   thickness: 1,
              // ),

              // const SizedBox(height: 24),

              // OTP Input and Submit Button
              // OtpSection(
              //   myKey1: myKey1,
              //   otpController: _otpController,
              //   loading: loading,
              //   onSubmit: () async {
              //     if (myKey1.currentState!.validate() && phoneSent) {
              //       setState(() {
              //         loading = true;
              //       });
              //       await Future.delayed(const Duration(seconds: 4));
              //       setState(() {
              //         loading = false;
              //       });
              //     }
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
