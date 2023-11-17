import 'package:flutter/material.dart';

class MyCalculator extends StatefulWidget {
  @override
  _MyCalculatorState createState() => _MyCalculatorState();
}

class _MyCalculatorState extends State<MyCalculator> {
  String _output = '';
  double _num1 = 0;
  double _num2 = 0;
  String _operand = '';

  void _handleNumberPress(String buttonText) {
    setState(() {
      if (_output == '0') {
        _output = buttonText;
      } else {
        _output += buttonText;
      }
    });
  }

  void _handleOperatorPress(String operator) {
    setState(() {
      _num1 = double.parse(_output);
      _operand = operator;
      _output = '0';
    });
  }

  void _handleEqualPress() {
    setState(() {
      _num2 = double.parse(_output);
      double result;

      switch (_operand) {
        case '+':
          result = _num1 + _num2;
          break;
        case '-':
          result = _num1 - _num2;
          break;
        case '*':
          result = _num1 * _num2;
          break;
        case '/':
          if (_num2 == 0) {
            result = double.infinity; // Handle division by zero
          } else {
            result = _num1 / _num2;
          }
          break;
        default:
          result = _num1;
      }

      // Update _output and reset _num1, _num2, and _operand
      _output = result.toStringAsPrecision(6); // Show result with precision
      _num1 = 0;
      _num2 = 0;
      _operand = '';
    });
  }

  void _handleClear() {
    setState(() {
      _output = '0';
      _num1 = 0;
      _num2 = 0;
      _operand = '';
    });
  }

  Widget buildNumberButton(String buttonText) {
    return ElevatedButton(
      onPressed: () => _handleNumberPress(buttonText),
      child: Text(buttonText),
    );
  }

  Widget buildOperatorButton(String buttonText) {
    return ElevatedButton(
      onPressed: () => _handleOperatorPress(buttonText),
      child: Text(buttonText),
    );
  }

  Widget buildEqualButton() {
    return ElevatedButton(
      onPressed: () => _handleEqualPress(),
      child: Text('='),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              _output,
              style: TextStyle(fontSize: 32),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _handleClear(),
                  child: Text('AC'),
                ),
                ElevatedButton(
                  onPressed: () => _handleOperatorPress('/'),
                  child: Text('/'),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildNumberButton('7'),
                buildNumberButton('8'),
                buildNumberButton('9'),
                buildOperatorButton('+'),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildNumberButton('4'),
                buildNumberButton('5'),
                buildNumberButton('6'),
                buildOperatorButton('-'),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildNumberButton('1'),
                buildNumberButton('2'),
                buildNumberButton('3'),
                buildOperatorButton('*'),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildNumberButton('0'),
                buildNumberButton('.'),
                buildEqualButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MyCalculator(),
  ));
}
