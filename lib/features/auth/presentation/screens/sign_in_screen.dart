import 'package:emendo/common/helper/is_dark_mode.dart';
import 'package:emendo/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../common/widgets/custom_app_bar.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../../../core/configs/Assets.dart';
import '../../../../core/configs/app_colors.dart';
import '../../../../core/configs/app_text_styles.dart';
import '../widgets/custom_email_field.dart';
import '../widgets/custom_password_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late final TextEditingController email;
  late final TextEditingController password;
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();


  @override
  void initState() {
    super.initState();
    email = TextEditingController();
    password = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    email.dispose();
    password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final localization = AppLocalizations.of(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          localization!.signIn,
          style: AppTextStyles.base(
            context: context,
            color: LightColors.mainText,
            fontSize: 18,
            fontWeight: FontWeight.bold
          )),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: SingleChildScrollView(
              child: Form(
                  key: formKey,
                  /// I used Transform widget because i don't like using stack and position
                  child: Transform.translate(
                    offset: Offset(0, -30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ///Beautiful Circles
                        Transform.translate(
                          offset: Offset(constraints.maxWidth / 1.4, 10), // Moves right by 30 and down by 50
                          child: SvgPicture.asset(Assets.authCirclesView),
                        ),
                        _signInTitle(localization,context),
                        SizedBox(height: constraints.maxHeight / 70),
                        _signInSubTitle(localization,context),
                        SizedBox(height: constraints.maxHeight / 25),
                        CustomEmailField(email: email,focusNode: emailFocusNode),
                        SizedBox(height: constraints.maxHeight / 25),
                        CustomPasswordField(
                          password: password,
                          passwordFocusNode: passwordFocusNode,
                          hintText: localization.passwordHintForTextField,
                        ),
                        SizedBox(height: constraints.maxHeight / 50),
                        _forgetPass(localization,context),
                        SizedBox(height: constraints.maxHeight / 35),
                        CustomButtons.primary(
                          text: localization.signUp,
                          context: context,
                          onPressed: () {},
                        ),
                        SizedBox(height: constraints.maxHeight / 25),
                        _signInWithText(localization,context),
                        SizedBox(height: constraints.maxHeight / 25),
                        _googleLogo(localization,context),
                        SizedBox(height: constraints.maxHeight / 25),
                        ///NotRegisterYet? SIGN UP
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              localization.noRegisterYet,
                              style: AppTextStyles.base(
                                  color: context.isDarkMode ? DarkColors.disableText : LightColors.disableText,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  context: context),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => SignUpScreen(),)
                                );
                              },
                              child: Text(
                                " ${localization.signUp}",
                                style: AppTextStyles.base(
                                    color: context.isDarkMode ? DarkColors.primeColor : LightColors.primeColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    context: context),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
              ),
            ),
          );
        },
      ),
    );
  }
}
Widget _signInTitle(AppLocalizations localization,context){
  return Text(
    localization.signInTitle,
    style: AppTextStyles.base(
        context: context,
        fontSize: 25,
        color: LightColors.mainText,
        fontWeight: FontWeight.w900
    ),
  );
}

Widget _signInSubTitle(AppLocalizations localization,BuildContext context){
  return Text(
    localization.signInSubTitle,
    style: AppTextStyles.base(
        context: context,
        fontSize: 14,
        color: LightColors.disableText,
        height: 1.7,
        fontWeight: FontWeight.w400
    ),
  );
}

Widget _forgetPass(AppLocalizations localization,context){
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Text(
        localization.signInForgetPass,
        style: AppTextStyles.base(
            context: context,
            fontSize: 14,
            color: LightColors.mainText,
            fontWeight: FontWeight.bold
        ),
      ),
    ],
  );
}

Widget _signInWithText(AppLocalizations localization,BuildContext context){
  return Center(
    child: Text(
      localization.signInWith,
      style: AppTextStyles.base(
          context: context,
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: context.isDarkMode ? DarkColors.disableText : LightColors.disableText
      ),
    ),
  );
}

Widget _googleLogo(AppLocalizations localization,BuildContext context){
  return Center(
    child: Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(width: 1, color: LightColors.outLineBorder),
          color: Colors.white
      ),
      child: Center(child: SvgPicture.asset(Assets.googleLogo)),
    ),
  );
}

