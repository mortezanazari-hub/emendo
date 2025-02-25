import 'package:emendo/common/widgets/custom_app_bar.dart';
import 'package:emendo/common/widgets/custom_form_field.dart';
import 'package:emendo/core/configs/Assets.dart';
import 'package:emendo/core/configs/app_colors.dart';
import 'package:emendo/core/configs/app_text_styles.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';


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
        title: Text(localization!.signUp,style: TextStyle(color: LightColors.mainText),),
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
                        SizedBox(height: constraints.maxHeight / 40),
                        _signUpSubTitle(localization,context),
                        SizedBox(height: constraints.maxHeight / 20),
                        _nameField(localization,name,nameFocusNode),
                        SizedBox(height: constraints.maxHeight / 25),
                        _emailField(localization,email,emailFocusNode),
                        SizedBox(height: constraints.maxHeight / 25),
                        _passwordField(localization,password,passwordFocusNode),
                        SizedBox(height: constraints.maxHeight / 25),

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
      fontSize: 30,
      color: LightColors.mainText,
      fontWeight: FontWeight.w900
      ),
    );
}

Widget _signUpSubTitle(AppLocalizations localization,context){
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

Widget _emailField (AppLocalizations localization,email,emailFocusNode){
  return CustomFormField(
    textEditingController: email,
    hintText: localization.emailHintForTextField,
    validator: (value) {
      if(value == null) return 'cant be Empty';
      if(value.isEmpty)return 'cant be Empty';
      if(!value.endsWith('.com') && !value.contains('@')){
        return 'Value is Invalid';
      }
      return null;
    },
    focusNode: emailFocusNode,
    onSubmit: (value) {},
  );
}

Widget _passwordField (AppLocalizations localization,password,passwordFocusNode){
  return CustomFormField(
    textEditingController: password,
    hintText: localization.passwordHintForTextField,
    validator: (value) {
      if(value == null)return 'cant be Empty';
      if(value.isEmpty)return 'cant be Empty';
      if(value.length < 8){
        return 'Value is To Short';
      }
      return null;
    },
    focusNode: passwordFocusNode,
    onSubmit: (value) {},
  );
}


