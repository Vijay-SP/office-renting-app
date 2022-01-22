import 'package:flutter/material.dart';

class InputWithIcon extends StatefulWidget {
  final IconData? btnIcon;
  final String? hintText;
  final TextStyle? hintTextStyle;
  final TextStyle? textStyle;
  final TextEditingController myController;
  final String? Function(String?)? validateFunc;
  final Function(String)? onChange;
  final bool? obscure;
  final TextInputType? keyboardType;
  final String? initialValue;
  final int? maxLines;
  InputWithIcon({
    this.btnIcon,
    this.hintText,
    this.hintTextStyle,
    this.textStyle,
    required this.myController,
    required this.onChange,
    this.obscure,
    this.keyboardType,
    this.validateFunc,
    this.initialValue,
    this.maxLines
  });

  @override
  _InputWithIconState createState() => _InputWithIconState();
}

class _InputWithIconState extends State<InputWithIcon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300, width: 2),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: <Widget>[
          Container(
              width: 60,
              child: Icon(
                widget.btnIcon,
                size: 20,
                color: Colors.grey.shade500,
              )),
          Expanded(
            child: SizedBox(
              height: 50,
              child: TextFormField(
                initialValue: widget.initialValue,
                decoration: InputDecoration(
                  errorStyle: TextStyle(
                    fontSize: 9,
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                  border: InputBorder.none,
                  hintText: widget.hintText,
                  hintStyle: widget.hintTextStyle,
                ),
                minLines: 1,//Normal textInputField will be displayed
                maxLines: widget.maxLines ?? 1,
                style: widget.textStyle,
                autocorrect: false,
                controller: widget.myController,
                validator: widget.validateFunc,
                onChanged: widget.onChange,
                obscureText: widget.obscure ?? false,
                keyboardType: widget.keyboardType ?? TextInputType.emailAddress,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
