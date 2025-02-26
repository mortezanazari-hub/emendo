import 'package:flutter/material.dart';
import '../../../../common/widgets/custom_form_field.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomEmailField extends StatelessWidget {
  final TextEditingController email;
  final FocusNode emailFocusNode;
  const CustomEmailField({
    super.key,
    required this.email,
    required this.emailFocusNode
  });

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);

    return CustomFormField(
      textEditingController: email,
      hintText: localization!.emailHintForTextField,
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
}
