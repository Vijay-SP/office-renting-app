import 'package:flutter/material.dart';

class OutlineBtn extends StatefulWidget {
  final String btnText;
  final String? imagePath;
  OutlineBtn({required this.btnText, this.imagePath});

  @override
  _OutlineBtnState createState() => _OutlineBtnState();
}

class _OutlineBtnState extends State<OutlineBtn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(50)),
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (widget.imagePath != null)
            Image.asset(
              widget.imagePath!,
              height: 30,
              width: 30,
            ),
          SizedBox(width: 5),
          Text(
            widget.btnText,
            style:
                TextStyle(color: Theme.of(context).primaryColor, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
