import 'package:emendo/common/helper/is_dark_mode.dart';
import 'package:emendo/common/widgets/custom_app_bar.dart';
import 'package:emendo/common/widgets/custom_button.dart';
import 'package:emendo/common/widgets/custom_form_field.dart';
import 'package:emendo/core/configs/assets.dart';
import 'package:emendo/core/configs/app_colors.dart';
import 'package:emendo/core/configs/app_text_styles.dart';
import 'package:emendo/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:emendo/features/auth/presentation/widgets/custom_email_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:emendo/features/auth/presentation/widgets/custom_password_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late final TextEditingController name;
  late final TextEditingController email;
  late final TextEditingController password;
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final nameFocusNode = FocusNode();


  @override
  void initState() {
    super.initState();
    name = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    name.dispose();
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
            localization!.signUp,
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
                        _signUpTitle(localization,context),
                        SizedBox(height: constraints.maxHeight / 70),
                        _signUpSubTitle(localization,context),
                        SizedBox(height: constraints.maxHeight / 20),
                        _nameField(localization,name,nameFocusNode),
                        SizedBox(height: constraints.maxHeight / 25),
                        CustomEmailField(email: email,focusNode: emailFocusNode),
                        SizedBox(height: constraints.maxHeight / 25),
                        CustomPasswordField(
                          password: password,
                          passwordFocusNode: passwordFocusNode,
                          hintText: localization.passwordHintForTextField,
                        ),
                        SizedBox(height: constraints.maxHeight / 25),
                        CustomButtons.primary(
                          text: localization.signUp,
                          context: context,
                          onPressed: () {},
                        ),
                        SizedBox(height: constraints.maxHeight / 25),
                        _signUpWithText(localization,context),
                        SizedBox(height: constraints.maxHeight / 25),
                        _googleLogo(localization,context),
                        SizedBox(height: constraints.maxHeight / 25),
                        ///Have An Account? SignIN Widget
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              localization.haveAnAccount,
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
                                  MaterialPageRoute(builder: (context) => SignInScreen(),)
                                );
                              },
                              child: Text(
                                " ${localization.signIn}",
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
Widget _signUpTitle(AppLocalizations localization,context){
  return Text(
    localization.signUpTitle,
    style: AppTextStyles.base(
      context: context,
      fontSize: 25,
      color: LightColors.mainText,
      fontWeight: FontWeight.w900
      ),
    );
}

Widget _signUpSubTitle(AppLocalizations localization,BuildContext context){
  return Text(
    localization.signUpSubTitle,
    style: AppTextStyles.base(
        context: context,
        fontSize: 14,
        color: LightColors.disableText,
        height: 1.7,
        fontWeight: FontWeight.w400
    ),
  );
}

Widget _nameField (AppLocalizations localization,email,nameFocusNode){
  return CustomFormField(
    textEditingController: email,
    hintText: localization.userNameHintForTextField,
    validator: (value) {
      if (value == null) return "cant be empty";
      if (value.isEmpty) return "cant be empty";

      if (value.length > 40) {
        return "Name is too long";
      }
      return null;
    },
    focusNode: nameFocusNode,
    onSubmit: (value) {},
  );
}

Widget _signUpWithText(AppLocalizations localization,BuildContext context){
  return Center(
    child: Text(
      localization.signUpWith,
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

