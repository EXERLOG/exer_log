import 'package:exerlog/UI/global.dart';
import 'package:flutter/material.dart';

class OutlinedTextField extends StatelessWidget {
  const OutlinedTextField({
    Key? key,
    required this.hinText,
    required this.validator,
    required this.leadingIcon,
    required this.textEditingController,
    this.obscureText = false,
  }) : super(key: key);

  final String hinText;
  final FormFieldValidator validator;
  final IconData leadingIcon;
  final TextEditingController textEditingController;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
      child: TextFormField(
        controller: textEditingController,
        validator: validator,
        style: mediumTitleStyleWhite,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hinText,
          hintStyle: setHintStyle.copyWith(
            color: Colors.white.withOpacity(0.5),
          ),
          prefixIcon: Container(
            width: 40,
            child: Icon(
              leadingIcon,
              color: greenTextColor,
            ),
          ),
          contentPadding: EdgeInsets.all(10),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: greenTextColor),
            borderRadius: BorderRadius.circular(30),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: greenTextColor),
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}
