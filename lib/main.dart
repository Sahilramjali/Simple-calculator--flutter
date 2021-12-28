import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 30.0;
  double resultFontSize = 40.0;

  calculation(String buttonText) {
    setState(() {
      if (buttonText == "AC") {
        equation = "0";
        result = "0";
        equationFontSize = 30.0;
        resultFontSize = 40.0;
      } else if (buttonText == "⌫") {
        equationFontSize = 40.0;
        resultFontSize = 30.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "=") {
        equationFontSize = 30.0;
        resultFontSize = 40.0;

        expression = equation;
        expression = expression.replaceAll('×', '*');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
      } else {
        equationFontSize = 40.0;
        resultFontSize = 30.0;
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  //Button Widget
  Widget calcbutton(String btntxt, Color btncolor, Color txtcolor) {
    return Container(
      child: RaisedButton(
        onPressed: () {
          calculation(btntxt);
        },
        child: Text(
          '$btntxt',
          style: TextStyle(
            fontSize: 35,
            color: txtcolor,
          ),
        ),
        shape: CircleBorder(),
        color: btncolor,
        padding: EdgeInsets.all(20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //Calculator
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Calculator'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            // Calculator display
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Text(
                equation,
                style:
                    TextStyle(fontSize: equationFontSize, color: Colors.grey),
              ),
            ),

            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
              child: Text(
                result,
                style: TextStyle(fontSize: resultFontSize, color: Colors.white),
              ),
            ),

            Expanded(
              child: Divider(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcbutton('AC', Colors.grey, Colors.black),
                calcbutton('⌫', Colors.grey, Colors.black),
                calcbutton('%', Colors.grey, Colors.black),
                calcbutton('/', Color.fromRGBO(255, 160, 0, 1), Colors.white),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcbutton('7', Color.fromRGBO(48, 48, 48, 1), Colors.white),
                calcbutton('8', Color.fromRGBO(48, 48, 48, 1), Colors.white),
                calcbutton('9', Color.fromRGBO(48, 48, 48, 1), Colors.white),
                calcbutton('×', Color.fromRGBO(255, 160, 0, 1), Colors.white),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcbutton('4', Color.fromRGBO(48, 48, 48, 1), Colors.white),
                calcbutton('5', Color.fromRGBO(48, 48, 48, 1), Colors.white),
                calcbutton('6', Color.fromRGBO(48, 48, 48, 1), Colors.white),
                calcbutton('-', Color.fromRGBO(255, 160, 0, 1), Colors.white),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcbutton('1', Color.fromRGBO(48, 48, 48, 1), Colors.white),
                calcbutton('2', Color.fromRGBO(48, 48, 48, 1), Colors.white),
                calcbutton('3', Color.fromRGBO(48, 48, 48, 1), Colors.white),
                calcbutton('+', Color.fromRGBO(255, 160, 0, 1), Colors.white),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcbutton('.', Color.fromRGBO(48, 48, 48, 1), Colors.white),
                calcbutton('0', Color.fromRGBO(48, 48, 48, 1), Colors.white),
                calcbutton('00', Color.fromRGBO(48, 48, 48, 1), Colors.white),
                calcbutton('=', Color.fromRGBO(255, 160, 0, 1), Colors.white),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
