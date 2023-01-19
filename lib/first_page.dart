import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  String equation = '0';
  String result = '0';
  String expression = '';
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;
  buttonTap(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = '0';
        result = '0';
      } else if (buttonText == '⌫') {
        equation = equation.substring(0, equation.length - 1);
        if (equation == '') {
          equation = '0';
          result = '0';
        }
      } else if (buttonText == '=') {
        expression = equation;
        expression = expression.replaceAll('x', '*');
        expression = expression.replaceAll('∻', '/');
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = 'Error';
        }
      } else {
        if (equation == '0') {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return GestureDetector(
      onTap: () => buttonTap(buttonText),
      child: Container(
        height: MediaQuery.of(context).size.height * buttonHeight,
        width: 1,
        padding: EdgeInsets.all(33),
        color: buttonColor,
        child: Text(
          buttonText,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 26, fontWeight: FontWeight.normal, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('MyCalculator')),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              equation,
              style: TextStyle(fontSize: equationFontSize),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(
              result,
              style: TextStyle(fontSize: resultFontSize),
            ),
          ),
          Expanded(
            child: Divider(),
          ),
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.75,
                child: Table(children: [
                  TableRow(children: [
                    buildButton('C', 0.1, Colors.redAccent),
                    buildButton('⌫', 0.1, Colors.blue),
                    buildButton('∻', 0.1, Colors.blue),
                  ]),
                  TableRow(children: [
                    buildButton('7', 0.1, Colors.black54),
                    buildButton('8', 0.1, Colors.black54),
                    buildButton('9', 0.1, Colors.black54),
                  ]),
                  TableRow(children: [
                    buildButton('4', 0.1, Colors.black54),
                    buildButton('5', 0.1, Colors.black54),
                    buildButton('6', 0.1, Colors.black54),
                  ]),
                  TableRow(children: [
                    buildButton('3', 0.1, Colors.black54),
                    buildButton('2', 0.1, Colors.black54),
                    buildButton('1', 0.1, Colors.black54),
                  ]),
                  TableRow(children: [
                    buildButton('.', 0.1, Colors.black54),
                    buildButton('0', 0.1, Colors.black54),
                    buildButton('00', 0.1, Colors.black54),
                  ])
                ]),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton('x', 0.1, Colors.blue),
                    ]),
                    TableRow(children: [
                      buildButton('-', 0.1, Colors.blue),
                    ]),
                    TableRow(children: [
                      buildButton('+', 0.1, Colors.blue),
                    ]),
                    TableRow(children: [
                      buildButton('=', 0.2, Colors.redAccent),
                    ]),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
