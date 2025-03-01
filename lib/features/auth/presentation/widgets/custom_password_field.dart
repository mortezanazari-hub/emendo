import 'package:flutter/material.dart';

import 'package:emendo/common/widgets/custom_form_field.dart';

class CustomPasswordField extends StatelessWidget {
  final TextEditingController password;
  final FocusNode passwordFocusNode;
  final String hintText;
  const CustomPasswordField({
    super.key,
    required this.hintText,
    required this.password,
    required this.passwordFocusNode
  });

  @override
  Widget build(BuildContext context) {
    return CustomFormField(
      textEditingController: password,
      hintText: hintText,
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
}
