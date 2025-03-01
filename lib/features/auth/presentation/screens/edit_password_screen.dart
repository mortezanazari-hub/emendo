import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';

import 'package:emendo/common/widgets/custom_app_bar.dart';
import 'package:emendo/common/widgets/custom_button.dart';
import 'package:emendo/core/configs/assets.dart';
import 'package:emendo/core/configs/app_colors.dart';
import 'package:emendo/core/configs/app_text_styles.dart';
import 'package:emendo/features/auth/presentation/widgets/custom_password_field.dart';

class EditPasswordScreen extends StatefulWidget {
  const EditPasswordScreen({super.key});

  @override
  State<EditPasswordScreen> createState() => _EditPasswordState();
}

class _EditPasswordState extends State<EditPasswordScreen> {
  late final TextEditingController oldPass;
  late final TextEditingController newPass;
  late final TextEditingController confirmPass;
  final oldPassFocusNode = FocusNode();
  final newPassFocusNode = FocusNode();
  final confirmPassFocusNode = FocusNode();


  @override
  void initState() {
    super.initState();
    oldPass = TextEditingController();
    newPass = TextEditingController();
    confirmPass = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    oldPass.dispose();
    newPass.dispose();
    confirmPass.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final localization = AppLocalizations.of(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
            localization!.editPass,
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
                        _editPassTitle(localization,context),
                        SizedBox(height: constraints.maxHeight / 70),
                        _editPassSubTitle(localization,context),
                        SizedBox(height: constraints.maxHeight / 20),
                        ///new
                        CustomPasswordField(
                          password: newPass,
                          passwordFocusNode: newPassFocusNode,
                          hintText: localization.newPasswordHintForTextField,
                        ),
                        SizedBox(height: constraints.maxHeight / 25),
                        ///old
                        CustomPasswordField(
                          password: oldPass,
                          passwordFocusNode: oldPassFocusNode,
                          hintText: localization.oldPasswordHintForTextField,
                        ),
                        SizedBox(height: constraints.maxHeight / 25),
                        ///confirm
                        CustomPasswordField(
                          password: confirmPass,
                          passwordFocusNode: confirmPassFocusNode,
                          hintText: localization.confirmPasswordHintForTextField,
                        ),
                        SizedBox(height: constraints.maxHeight / 35),
                        CustomButtons.primary(
                          text: localization.confirm,
                          context: context,
                          onPressed: () {},
                        ),
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
Widget _editPassTitle(AppLocalizations localization,context){
  return Text(
    localization.editPassTitle,
    style: AppTextStyles.base(
        context: context,
        fontSize: 25,
        color: LightColors.mainText,
        fontWeight: FontWeight.w900
    ),
  );
}

Widget _editPassSubTitle(AppLocalizations localization,BuildContext context){
  return Text(
    localization.editPassSubTitle,
    style: AppTextStyles.base(
        context: context,
        fontSize: 14,
        color: LightColors.disableText,
        height: 1.7,
        fontWeight: FontWeight.w400
    ),
  );
}