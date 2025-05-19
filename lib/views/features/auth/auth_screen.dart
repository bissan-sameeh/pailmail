import 'dart:math';

import 'package:animated_toggle_switch/animated_toggle_switch.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/helpers/routers/router.dart';
import '../../../core/utils/awesome_dialog.dart';
import '../../../core/utils/constants.dart';
import '../../../core/utils/snckbar.dart';
import '../../../repositories/auth_repository.dart';
import '../../../storage/shared_prefs.dart';
import '../../widgets/animated_auth_widget.dart';
import '../../widgets/custom_auth_button_widget.dart';
import '../../widgets/custom_logo_widget.dart';
import '../../widgets/custom_outlined_button_widget.dart';
import '../../widgets/custom_text_forn_field_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with AwesomeDialogMixin, ShowSnackBar {
  final _formKey = GlobalKey<FormState>();

  late AuthRepository auth;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  late bool showSignUp;
  late bool showLogin;
  late bool showPass;
  bool showConfirm = false;
  bool isLoginResponse = false;

  int value = 0; //for the AnimatedToggleSwitch

  void toggleView() {
    setState(() {
      _formKey.currentState
          ?.reset(); //to remove validation error & content on toggle
      showSignUp = !showSignUp;
      showLogin = !showLogin;
    });
  }

  void toggleObsecure() {
    setState(() {
      showPass = !showPass;
    });
  }

  void toggleConfirm() {
    setState(() {
      showConfirm = !showConfirm;
    });
  }

  signUp() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoginResponse = true;
      });
      auth
          .register(
        email: emailController.text,
        name: nameController.text,
        password: passwordController.text,
        password_confirmation: passwordController.text,
      )
          .then((user) async {
        // showSnackBar(
        //   context,
        //   message: 'user created successfully',
        // );
        await buildSuccessDialog(context, 'Account Created Successfully!', '')
            .show();

        if (mounted) {
          if (SharedPreferencesController().roleId == 1) {
            NavigationRoutes()
                .jump(context, Routes.guest_screen, replace: true);
          } else {
            NavigationRoutes().jump(context, Routes.home_screen, replace: true);
          }
        }
      }).catchError((e) {
        setState(() {
          isLoginResponse = false;
          _formKey.currentState?.reset();
        });
        showSnackBar(context,
            message: handleErrorMessage(e.toString()), error: true);
      });
    }
  }

  logIn() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoginResponse = true;
      });
      auth
          .login(
        email: emailController.text,
        password: passwordController.text,
      )
          .then((user) async {
        // showSnackBar(
        //   context,
        //   message: 'logged in successfully',
        // );
        await buildSuccessDialog(context, 'Logged In Successfully!', '').show();

        if (mounted) {
          if (SharedPreferencesController().roleId == 1) {
            NavigationRoutes()
                .jump(context, Routes.guest_screen, replace: true);
          } else {
            NavigationRoutes().jump(context, Routes.home_screen, replace: true);
          }
        }
      }).catchError((e) {
        setState(() {
          isLoginResponse = false;
          _formKey.currentState?.reset();
        });

        showSnackBar(context,
            message: handleErrorMessage(e.toString()), error: true);
      });
    }
  }

  String handleErrorMessage(String e) {
    print(e);
    if (e.contains('Invalid credentials')) {
      return 'Email or password is wrong.';
    } else if (e.contains('422')) {
      return "The password must be at least 6 characters.";
    } else if (e.contains('name')) {
      return 'The name field is required';
    } else if (e.contains('email has already been taken')) {
      return 'The email has already been taken.';
    }
    return e;
  }

  @override
  void initState() {
    auth = AuthRepository();
    showSignUp = true;
    showLogin = false;
    showPass = false;
    showConfirm = false;
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
        backgroundColor: kBackgroundColor,
        body: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: -170.h,
                child: Container(
                  height: 571.h,
                  width: 571.w,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: kGradient,
                  ),
                  child: const CustomLogoWidget(),
                ),
              ),
              Center(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(48),
                      margin:
                          const EdgeInsets.only(left: 31, right: 31, top: 200),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(59),
                        color: kWhiteColor,
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromRGBO(205, 204, 241, 0.3),
                            blurRadius:
                                7.5.r, // has the effect of softening the shadow
                            spreadRadius:
                                0.r, // has the effect of extending the shadow
                            offset: const Offset(
                              5.0, // horizontal, move right 5
                              0,
                            ),
                          )
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          DefaultTextStyle(
                            style: theme.textTheme.titleLarge!,
                            textAlign: TextAlign.center,
                            child: SingleChildScrollView(
                              child: AnimatedToggleSwitch<int>.size(
                                current: min(value, 1),
                                style: ToggleStyle(
                                  backgroundColor: Colors.transparent,
                                  indicatorColor: kPrimaryBlueColor,
                                  borderColor: kLightGreyColor,
                                  borderRadius: BorderRadius.circular(25.0),
                                  indicatorBorderRadius:
                                      BorderRadius.circular(50.0),
                                ),
                                values: const [0, 1],
                                selectedIconScale: 1.0, //change font scaLe
                                indicatorSize: const Size.fromWidth(100),
                                styleAnimationType: AnimationType.onHover,
                                spacing: 2.0,

                                customIconBuilder: (context, local, global) {
                                  final text = [
                                    'sign_up'.tr(),
                                    'log_in'.tr(),
                                  ][local.index];
                                  return Center(
                                    child: Text(
                                      text,
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.lerp(
                                          FontWeight.normal,
                                          FontWeight.bold,
                                          local.animationValue,
                                        ), //adjust fontweight on toggle
                                        fontSize: 14,

                                        letterSpacing: 0.25,
                                        color: Color.lerp(
                                          kPrimaryBlueColor,
                                          Colors.white,
                                          local.animationValue,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                borderWidth: 1.0,
                                onChanged: (i) => setState(() {
                                  value = i;
                                  toggleView();
                                }),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                AnimatedAuthWidget(
                                    textEditingController:
                                        CustomTextFormFieldWidget(
                                      controller: nameController,
                                      hint: 'enter_name'.tr(),
                                      keyboardType: TextInputType.emailAddress,
                                      autofillHints: const [AutofillHints.name],
                                      validator: (value) {
                                        if ((value == null || value.isEmpty) &&
                                            showSignUp) {
                                          return 'please_enter_the_name'.tr();
                                        }
                                        return null;
                                      },
                                    ),
                                    condition: showSignUp),
                                SizedBox(
                                  height: 10.h,
                                ),
                                CustomTextFormFieldWidget(
                                  controller: emailController,
                                  hint: 'enter_email_or_username'.tr(),
                                  keyboardType: TextInputType.emailAddress,
                                  autofillHints: const [AutofillHints.email],
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'please_enter_the_email'.tr();
                                    } else if (!EmailValidator.validate(
                                        value)) {
                                      return 'please enter a valid email';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                CustomTextFormFieldWidget(
                                  password: true,
                                  controller: passwordController,
                                  hint: 'enter_password'.tr(),
                                  isObscure: showPass,
                                  changeVisibility: toggleObsecure,
                                  keyboardType: TextInputType.emailAddress,
                                  autofillHints: const [AutofillHints.password],
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'please_enter_the_password'.tr();
                                    } else if (value.length < 6) {
                                      return "password must be at least 6 characters.";
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                AnimatedAuthWidget(
                                    textEditingController:
                                        CustomTextFormFieldWidget(
                                      password: true,
                                      controller: confirmPasswordController,
                                      hint: 'confirm_password'.tr(),
                                      isObscure: showConfirm,
                                      changeVisibility: toggleConfirm,
                                      keyboardType: TextInputType.emailAddress,
                                      autofillHints: const [
                                        AutofillHints.password
                                      ],
                                      validator: (value) {
                                        if (value == null ||
                                            value.isEmpty && showSignUp) {
                                          return 'Please confirm your password'
                                              .tr();
                                        }

                                        return null;
                                      },
                                    ),
                                    condition: showSignUp),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 40.h,
                          ),
                          isLoginResponse
                              ? CustomAuthButtonWidget(
                                  child: progressSpinkit,
                                  onTap: () {
                                    signUp();
                                  },
                                )
                              : showSignUp == true
                                  ? CustomAuthButtonWidget(
                                      child: Text(
                                        'sign_up'.tr(),
                                        style: GoogleFonts.poppins(
                                            color: kWhiteColor,
                                            fontSize: 14,
                                            letterSpacing: 0.25),
                                      ),
                                      onTap: () {
                                        signUp();
                                      },
                                    )
                                  : CustomAuthButtonWidget(
                                      child: Text(
                                        'log_in'.tr(),
                                        style: GoogleFonts.poppins(
                                            color: kWhiteColor,
                                            fontSize: 14,
                                            letterSpacing: 0.25),
                                      ),
                                      onTap: () {
                                        logIn();
                                      },
                                    ),
                          const SizedBox(
                            height: 22,
                          ),
                          Text(
                            'OR'.tr(),
                            style: GoogleFonts.poppins(
                                color: const Color(0xFFA8A7A7),
                                fontSize: 14,
                                letterSpacing: 0.25),
                          ),
                          const SizedBox(
                            height: 22,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CustomOtlinedButton(
                                child:
                                    Image.asset('assets/images/facebook.png'),
                              ),
                              CustomOtlinedButton(
                                child: Image.asset('assets/images/twitter.png'),
                              ),
                              CustomOtlinedButton(
                                child: Image.asset('assets/images/google.png'),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
