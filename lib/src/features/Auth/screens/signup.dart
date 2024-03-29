import 'package:caffae_app/src/Global/Exponents/exponent.dart';
import 'package:caffae_app/src/Global/Export/export.dart';
import 'package:caffae_app/src/Global/widgets/my_text_field.dart';
import 'package:caffae_app/src/features/Auth/services/auth_repository.dart';
import 'package:caffae_app/src/features/Auth/screens/otp_verification.dart';

import 'package:flutter/services.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final emailController = TextEditingController();
// sign -> email , photo
  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    emailController.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  RegExp regExp = RegExp(r'^[0]?[6789]\d{9}$');
  RegExp countryRegExp = RegExp(r'^\+?(\d+)');
  bool divider = false;
  bool isLoaded = false;

  int validatePhone(String phone) {
    String pattern = r'^[0]?[6789]\d{9}$';
    RegExp regExp = RegExp(pattern);
    if (phone.isEmpty) {
      return 1;
    } else if (phone.length < 10) {
      return 2;
    } else if (!regExp.hasMatch(phone)) {
      return 3;
    } else {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final repository = ref.watch(authRepositoryProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: kBackGroundColors,
        body: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: MediaQuery.of(context).size.height / 4.3,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    Container(
                      height: 140,
                      width: 140,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        // shape: BoxShape.circle,

                        image: DecorationImage(
                          fit: BoxFit.contain,
                          filterQuality: FilterQuality.high,
                          image: AssetImage(
                            'assets/images/caffae.png',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 3,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  height: MediaQuery.of(context).size.height / 1.6,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: repository.loading
                      ? const CircularProgressIndicator()
                      : Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Enter your phone number',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 45,
                                    width: 45,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color.fromARGB(
                                              255, 42, 35, 35),
                                          width: 1),
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white,
                                    ),
                                    child: const Text(
                                      '+${91}',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(width: 7),
                                  Expanded(
                                    child: TextFormField(
                                      controller: phoneController,
                                      validator: (value) {
                                        int res = validatePhone(value!);
                                        if (res == 1) {
                                          return "Please enter number";
                                        } else if (res == 2) {
                                          return "Please enter 10 digits phone number";
                                        } else if (res == 3) {
                                          return "Please enter a valid 10 digits phone number";
                                        } else {
                                          return null;
                                        }
                                      },
                                      style: const TextStyle(fontSize: 19),
                                      keyboardType: TextInputType.phone,
                                      onChanged: (value) {
                                        if (value.isEmpty) {
                                          FocusScope.of(context)
                                              .previousFocus();
                                        } else if (value.length == 10) {
                                          FocusScope.of(context).unfocus();
                                        }
                                      },
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(10),
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      decoration: inputDecorationTextField(),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormInput(
                                obscureText: false,
                                suffixIcon: const Icon(Icons.visibility),
                                icon: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.numbers),
                                ),
                                // controller:
                                //     Get.find<SignUpController>().passwordController,
                                controller: passwordController,
                                validator: (String? value) {
                                  List<String> validation = [];
                                  if (value == null || value.isEmpty) {
                                    return 'This field can not be empty';
                                  } else {
                                    if (!value.isValidPasswordHasNumber) {
                                      validation.add('Must contain 1 Number');
                                    }
                                    if (!value
                                        .isValidPasswordHasCapitalLetter) {
                                      validation
                                          .add("Must contain 1 capital letter");
                                    }
                                    if (!value
                                        .isValidPasswordHasLowerCaseLetter) {
                                      validation
                                          .add("Must contain 1 simple letter");
                                    }
                                    if (!value
                                        .isValidPasswordHasSpecialCharacter) {
                                      validation.add(
                                          "Must contain 1 special character[! @ # \$ %]");
                                    }
                                  }
                                  String msg = '';
                                  if (validation.isNotEmpty) {
                                    for (var i = 0;
                                        i < validation.length;
                                        i++) {
                                      msg = msg + validation[i];
                                      if ((i + 1) != validation.length) {
                                        msg = "$msg\n";
                                      }
                                    }
                                  }
                                  return msg.isNotEmpty ? msg : null;
                                },
                                hintText: 'Enter your password',
                                labelText: 'Password',
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormInput(
                                obscureText: false,
                                suffixIcon: const Icon(Icons.visibility),
                                icon: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.visibility),
                                ),
                                controller: confirmPasswordController,
                                validator: (String? value) {
                                  if (passwordController.text.trim() !=
                                      confirmPasswordController.text.trim()) {
                                    return 'Enter your same password';
                                  }
                                  return null;
                                },
                                hintText: 'Enter your confirmation password',
                                labelText: 'Password',
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormInput(
                                maxLines: 1,
                                obscureText: false,
                                hintText: 'Enter your email',
                                labelText: 'Email',
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return "This field can't be empty";
                                  } else if (!value.isValidEmail) {
                                    return "Please enter valid email";
                                  }
                                  return null;
                                },
                                controller: emailController,
                              ),
                              const SizedBox(
                                height: 39,
                              ),
                              phoneController.text.isEmpty &&
                                      emailController.text.isEmpty &&
                                      passwordController.text.isEmpty
                                  ? GlobalContainer(
                                      height: 40,
                                      width: 120,
                                      borderWidth: 1.1,
                                      borderRadius: BorderRadius.circular(6),
                                      color: Colors.grey,
                                      child: ReusableText(
                                        text: 'Send OTP',
                                        textStyle: appStyle(
                                          fw: FontWeight.bold,
                                          fontSize: 12,
                                          color: const Color.fromARGB(
                                              255, 120, 108, 108),
                                        ),
                                      ),
                                    )
                                  : InkWell(
                                      onTap: () {
                                        String phoneNumber =
                                            '+91${phoneController.text.trim()}';

                                        String email =
                                            emailController.text.trim();
                                        String password =
                                            passwordController.text.trim();
                                        if (_formKey.currentState!.validate()) {
                                          repository
                                              .register(
                                            phoneNumber: phoneNumber,
                                            password: password,
                                            confirmPassword:
                                                confirmPasswordController.text
                                                    .trim(),
                                            email: email,
                                            context: context,
                                          )
                                              .then(
                                            (bool? value) {
                                              if (repository.isSignUpComplete ==
                                                  false) {
                                                Navigator.pushAndRemoveUntil(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          VerifyOtpScreen(
                                                        phoneNumber:
                                                            phoneNumber,
                                                        password: password,
                                                      ),
                                                    ),
                                                    (route) => false);
                                              } else {
                                                snackbar(
                                                  context: context,
                                                  content:
                                                      'You have already verified your account please sign in with same credentials',
                                                );
                                                debugPrint(
                                                  'You have already verified your account please sign in',
                                                );
                                              }
                                            },
                                          );
                                        }
                                      },
                                      child: GlobalContainer(
                                        height: 40,
                                        width: 120,
                                        borderWidth: 1.1,
                                        borderRadius: BorderRadius.circular(6),
                                        color: kBackGroundColors,
                                        child: ReusableText(
                                          text: 'Send  OTP',
                                          textStyle: appStyle(
                                            fw: FontWeight.bold,
                                            fontSize: 12,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                              const SizedBox(
                                height: 15,
                              ),
                              RichText(
                                text: TextSpan(
                                  text: 'Do you have have an account',
                                  style: appStyle(
                                    fw: FontWeight.w300,
                                    fontSize: 12,
                                    color:
                                        const Color.fromARGB(255, 42, 57, 42),
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'Login',
                                      style: appStyle(
                                        fw: FontWeight.w300,
                                        fontSize: 12,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
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

InputDecoration inputDecorationTextField() {
  return InputDecoration(
    filled: true,
    alignLabelWithHint: true,
    labelStyle: const TextStyle(
      fontWeight: FontWeight.w500,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(7),
      borderSide:
          const BorderSide(color: Color.fromARGB(255, 78, 63, 63), width: 1),
    ),
    errorBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFee7b64), width: 2),
    ),
    focusColor: const Color.fromARGB(255, 207, 0, 0),
    contentPadding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 15.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(7.0),
    ),
    fillColor: Colors.white,
    hintStyle: const TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    hintText: "XXXXXXXXXX",
  );
}
