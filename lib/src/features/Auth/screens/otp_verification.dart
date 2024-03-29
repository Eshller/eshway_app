import 'package:caffae_app/src/Global/Export/export.dart';
import 'package:caffae_app/src/features/Auth/services/auth_repository.dart';
import 'package:caffae_app/src/features/Auth/screens/login_screen.dart';
import 'package:pinput/pinput.dart';

class VerifyOtpScreen extends ConsumerStatefulWidget {
  final String phoneNumber;
  final String password;

  const VerifyOtpScreen({
    super.key,
    required this.phoneNumber,
    required this.password,
  });

  @override
  ConsumerState<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends ConsumerState<VerifyOtpScreen> {
  final pinController = TextEditingController();

  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  String? otpCode;

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final repository = ref.watch(authRepositoryProvider);

    const focusedBorderColor = Color.fromRGBO(205, 245, 238, 1);
    const fillColor = Color.fromRGBO(242, 245, 228, 0);
    const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor),
      ),
    );

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: kBackGroundColors,
        appBar: AppBar(
          backgroundColor: kBackGroundColors,
          automaticallyImplyLeading: false,
          title: const Text(
            'Verify your OTP',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Form(
          key: formKey,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 169,
                    width: 169,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage(
                        'assets/images/caffae.png',
                      ),
                    )),
                  ),
                  ReusableText(
                    text: 'We have sent an SMS with a code',
                    textStyle: appStyle(
                      fw: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    height: 80,
                    child: Pinput(
                      length: 6,
                      mouseCursor: MouseCursor.defer,
                      controller: pinController,
                      focusNode: focusNode,
                      androidSmsAutofillMethod:
                          AndroidSmsAutofillMethod.smsUserConsentApi,
                      listenForMultipleSmsOnAndroid: true,
                      defaultPinTheme: defaultPinTheme,
                      hapticFeedbackType: HapticFeedbackType.lightImpact,
                      onCompleted: (value) {
                        setState(() {
                          otpCode = value;
                        });
                        debugPrint('onChanged: $value');
                      },
                      cursor: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 9),
                            width: 22,
                            height: 1,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      focusedPinTheme: defaultPinTheme.copyWith(
                        textStyle: const TextStyle(color: Colors.white),
                        decoration: defaultPinTheme.decoration!.copyWith(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: focusedBorderColor),
                        ),
                      ),
                      submittedPinTheme: defaultPinTheme.copyWith(
                        decoration: defaultPinTheme.decoration!.copyWith(
                          color: fillColor,
                          borderRadius: BorderRadius.circular(19),
                          border: Border.all(color: Colors.white),
                        ),
                      ),
                      errorPinTheme: defaultPinTheme.copyBorderWith(
                        border: Border.all(color: Colors.redAccent),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  repository.loading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : InkWell(
                          onTap: () {
                            focusNode.unfocus();
                            if (formKey.currentState!.validate()) {
                              repository
                                  .confirmPhoneNumber(
                                confirmationCode: pinController.text.trim(),
                                password: widget.password,
                                phoneNumber: widget.phoneNumber,
                                context: context,
                              )
                                  .then((bool value) {
                                if (value) {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginPhoneScreen()),
                                      (route) => false);
                                } else {
                                  snackbar(
                                      context: context,
                                      content:
                                          'Phone number verification failed');
                                  debugPrint(
                                      'Phone number verification failed');
                                }
                              });
                            }

                            // formKey.currentState!.validate();
                          },
                          child: GlobalContainer(
                            height: 36,
                            borderWidth: 1.0,
                            width: MediaQuery.of(context).size.width / 2.4,
                            borderRadius: BorderRadius.circular(14),
                            color: kBackGroundColors,
                            child: ReusableText(
                              text: 'Verify Otp',
                              textStyle: appStyle(
                                fw: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
