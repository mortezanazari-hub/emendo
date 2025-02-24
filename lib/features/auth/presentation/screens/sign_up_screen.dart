import 'package:emendo/common/widgets/app_bar.dart';
import 'package:emendo/core/configs/app_colors.dart';
import 'package:emendo/core/configs/app_text_styles.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController fullName;
  late TextEditingController email;
  late TextEditingController password;

  @override
  void initState() {
    super.initState();
    fullName = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    fullName.dispose();
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.0),
        child: SingleChildScrollView(
          child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 25,),
                  _signUpTitle(localization,context),
                ],
              )
          ),
        ),
      ),
    );
  }
}
Widget _signUpTitle(AppLocalizations localization,context){
  return Text(
    localization.signUpTitle.toString() ?? "a",
    style: AppTextStyles.base(
      context: context,
      fontSize: 30,
      color: LightColors.mainText,
      fontWeight: FontWeight.w900
      ),
    );
}
