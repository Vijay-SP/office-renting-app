import 'package:flutter/material.dart';

class PrimaryButton extends StatefulWidget {
  final String btnText;
  final void Function() onPressed;
  PrimaryButton({required this.btnText, required this.onPressed});

  @override
  _PrimaryButtonState createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(50),
        ),
        padding: EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Center(
                child: Text(
              widget.btnText,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            ),
          ],
        ),
      ),
    );
  }
}

class PrimaryOutlineButton extends StatefulWidget {
  final String btnText;
  final void Function() onPressed;
  PrimaryOutlineButton({required this.btnText,required this.onPressed});

  @override
  _PrimaryOutlineButtonState createState() => _PrimaryOutlineButtonState();
}

class _PrimaryOutlineButtonState extends State<PrimaryOutlineButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: Theme.of(context).primaryColor),
        ),
        padding: EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Text(
                  widget.btnText,
                  style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 16),
                ),
            ),
          ],
        ),
      ),
    );
  }
}

