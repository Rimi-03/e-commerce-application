import 'package:ecommerce_app/utils/app_textstyles.dart';
import 'package:flutter/material.dart';

class CustomTextfield extends StatefulWidget {
  final String label;
  final IconData prefixIcon;
  final TextInputType keyboardType;
  final bool isPassword;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final String? initialValue;
  final bool readOnly;
  final int maxLines;

  const CustomTextfield({
    super.key,
    required this.label,
    required this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.controller,
    this.validator,
    this.onChanged,
    this.initialValue,
    this.readOnly = false,
    this.maxLines = 1,
  });

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return TextFormField(
      controller: widget.controller,
      initialValue: widget.initialValue,
      keyboardType: widget.keyboardType,
      obscureText: widget.isPassword && _obscureText,
      validator: widget.validator,
      onChanged: widget.onChanged,
      readOnly: widget.readOnly,
      maxLines: widget.maxLines,

      style: AppTextStyle.withColor(
        AppTextStyle.bodyMedium,
        Theme.of(context).textTheme.bodyLarge!.color!,
      ),
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: AppTextStyle.withColor(
          AppTextStyle.bodyMedium,
          isDark ? Colors.grey.shade400 : Colors.grey.shade600,
        ),
        prefixIcon: Icon(
          widget.prefixIcon,
          color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
          ),
        ),
      ),
    );
  }
}
