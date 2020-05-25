import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ButtonBase extends StatelessWidget{
  String text;
  Function onPressed;
  Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
              child: Container(
                  height: 46,
                  child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                      color: color,
                      child: Text(
                        text,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      onPressed: onPressed)))
        ]);
  }
}

// ignore: must_be_immutable
class ButtonPrimary extends ButtonBase {

  ButtonPrimary(String text, Function onPressed){
    super.text = text;
    super.onPressed = onPressed;
    super.color = Colors.blue;
  }
}

// ignore: must_be_immutable
class ButtonDanger extends ButtonBase {

  ButtonDanger(String text, Function onPressed){
    super.text = text;
    super.onPressed = onPressed;
    super.color = Colors.red;
  }
}

// ignore: must_be_immutable
class ButtonDefault extends ButtonBase {

  ButtonDefault(String text, Function onPressed){
    super.text = text;
    super.onPressed = onPressed;
    super.color = Colors.grey;
  }
}