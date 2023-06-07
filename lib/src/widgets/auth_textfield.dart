import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moduluenergy/src/utils/app_colors.dart';
import 'package:moduluenergy/src/utils/app_styles.dart';

class ModulgyTextField extends StatefulWidget {
  final String hintText;
  final String label;
  final String prefix;
  final bool obscureText;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  final bool postFix;
  final String postfixPath;

  const ModulgyTextField({
    Key? key,
    this.hintText = '',
    this.label = '',
    this.obscureText = false,
    this.onSaved,
    this.validator,
    this.prefix = 'assets/lock.svg',
    this.postFix = false,
    this.postfixPath = '',
  }) : super(key: key);

  @override
  State<ModulgyTextField> createState() => _ModulgyTextFieldState();
}

class _ModulgyTextFieldState extends State<ModulgyTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: AppStyles.textInpuStyle,
      obscureText: widget.obscureText,
      obscuringCharacter: '●',
      validator: widget.validator,
      onSaved: widget.onSaved,
      decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.primaryColor)),
          hintText: widget.hintText,
          labelText: widget.label,
          labelStyle: AppStyles.textFieldStyle,
          hintStyle: AppStyles.textFieldStyle,
          prefixIcon: Container(
              padding: const EdgeInsets.all(12),
              child: SvgPicture.asset(widget.prefix))),
    );
  }
}
