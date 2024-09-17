import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart'; // External package for expression evaluation

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(title: 'Jimmy Zhang\'s Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String input = ''; // Holds the input expression
  String result = ''; // Holds the evaluated result

  // Function to handle button presses
  void _buttonPress(String value) {
    setState(() {
      if (value == 'C') {
        // Clear input and result
        input = '';
        result = '';
      } else if (value == '=') {
        try {
          // Parse and evaluate the expression using the expressions package
          final expression = Expression.parse(input);
          const evaluator = ExpressionEvaluator();
          var evalResult = evaluator.eval(expression, {});
          result = evalResult.toString();
        } catch (e) {
          result = 'Error';
        }
      } else if (value == '^2') {
        // Handle squaring the number
        input += '**2'; // Use '**' for exponentiation
      } else if (value == '%') {
        // Handle modulo operation
        input += '%'; // Modulo operator
      } else {
        // Update the input expression
        input += value;
      }
    });
  }

  // Build calculator buttons
  Widget _buildButton(String value) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () => _buttonPress(value),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(20),
            textStyle: const TextStyle(fontSize: 24),
          ),
          child: Text(value),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          // Display input expression
          Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerRight,
            child: Text(
              input,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ),
          // Display result
          Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerRight,
            child: Text(
              result,
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.deepPurple),
            ),
          ),
          const Divider(),
          // Calculator buttons
          Expanded(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    _buildButton('7'),
                    _buildButton('8'),
                    _buildButton('9'),
                    _buildButton('/'),
                  ],
                ),
                Row(
                  children: <Widget>[
                    _buildButton('4'),
                    _buildButton('5'),
                    _buildButton('6'),
                    _buildButton('*'),
                  ],
                ),
                Row(
                  children: <Widget>[
                    _buildButton('1'),
                    _buildButton('2'),
                    _buildButton('3'),
                    _buildButton('-'),
                  ],
                ),
                Row(
                  children: <Widget>[
                    _buildButton('C'),
                    _buildButton('0'),
                    _buildButton('^2'), // Squaring button
                    _buildButton('+'),
                  ],
                ),
                Row(
                  children: <Widget>[
                    _buildButton('%'), // Modulo button
                    _buildButton('='),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}