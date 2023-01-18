// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../view/resources/app_colors.dart';
import '../view/resources/app_spacing.dart';
import '../view/resources/app_textstyle.dart';

class Field extends StatelessWidget {
  final String hintText;
  final VoidCallback? func;
  final String? errorText;
  final FormFieldValidator? validator;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusederrorBorder;
  final String? suffixText;
  final TextInputAction textInputAction;
  final TextInputType? keyType;
  final int? minLines;
  final List<TextInputFormatter>? formatter;
  final TextEditingController controller;

  const Field({
    Key? key, this.formatter, required this.hintText, this.func, this.validator, this.enabledBorder, this.focusedBorder, this.errorBorder, this.focusederrorBorder, required this.textInputAction, this.keyType, this.errorText, this.suffixText, this.minLines,  required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color: kBlackColor, width: 0.1),
                // color: kTextFieldFillColor.withOpacity(0.7),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                inputFormatters: formatter,
                controller: controller,
                textInputAction: textInputAction,
                keyboardType: keyType,
                // maxLines: whatever,
                maxLines: minLines,
                validator: validator,
                style: bodySmallText(context),
                textCapitalization:
                    TextCapitalization.sentences,
                cursorColor: kBlackColor,
                decoration: InputDecoration(
                  suffixText: suffixText,
                  errorText: errorText,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(kPad - 10),
                      borderSide: BorderSide(color: kTextFieldFillColor)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(kPad - 10),
                      borderSide: BorderSide(color: kTextFieldFillColor)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(kPad - 10),
                      borderSide: BorderSide(color: kPrimaryColor)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(kPad - 10),
                      borderSide: BorderSide(color: kTextFieldFillColor)),
                  labelText: hintText,
                  labelStyle: bodySmallText(context).copyWith(color:Colors.black45),
                ),
              )),
        ],
      ),
    );
  }
}