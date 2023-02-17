import 'package:calculator/NeuContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:math_expressions/math_expressions.dart';

Future<void> main() async {
  await Future.delayed(Duration(seconds: 3));
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator Neumorphism',
      home: CalculatorNeuApp(),
    );
  }
}

const Color colorDark = Color(0xFF374352);
const Color colorLight = Color(0xFFe6eeff);

class CalculatorNeuApp extends StatefulWidget {
  @override
  _CalculatorNeuAppState createState() => _CalculatorNeuAppState();
}

class _CalculatorNeuAppState extends State<CalculatorNeuApp> {
  String input = "";
  String result = "0";
  bool darkMode = true;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      backgroundColor: darkMode ? colorDark : colorLight,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(size.width / 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          darkMode ? darkMode = false : darkMode = true;
                        });
                      },
                      child: _switchMode()),
                  SizedBox(height: size.height / 15),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      result,
                      style: TextStyle(
                          fontSize: size.height / 15,
                          fontWeight: FontWeight.bold,
                          color: darkMode ? Colors.white : Colors.red),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '=',
                        style: TextStyle(
                            fontSize: size.height / 30,
                            color: darkMode ? Colors.green : Colors.grey),
                      ),
                      Text(
                        input,
                        style: TextStyle(
                            fontSize: size.height / 40,
                            color: darkMode ? Colors.green : Colors.grey),
                      )
                    ],
                  ),
                  SizedBox(
                    height: size.height / 10,
                  )
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buttonOval(title: 'sin'),
                      _buttonOval(title: 'cos'),
                      _buttonOval(title: 'tan'),
                      _buttonOval(title: '%')
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buttonRounded(
                          title: 'AC',
                          textColor:
                          darkMode ? Colors.green : Colors.redAccent),
                      _buttonRounded(title: '('),
                      _buttonRounded(title: ')'),
                      _buttonRounded(
                          title: '/',
                          textColor: darkMode ? Colors.green : Colors.redAccent)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buttonRounded(title: '7'),
                      _buttonRounded(title: '8'),
                      _buttonRounded(title: '9'),
                      _buttonRounded(
                          title: '*',
                          textColor: darkMode ? Colors.green : Colors.redAccent)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buttonRounded(title: '4'),
                      _buttonRounded(title: '5'),
                      _buttonRounded(title: '6'),
                      _buttonRounded(
                          title: '-',
                          textColor: darkMode ? Colors.green : Colors.redAccent)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buttonRounded(title: '1'),
                      _buttonRounded(title: '2'),
                      _buttonRounded(title: '3'),
                      _buttonRounded(
                          title: '+',
                          textColor: darkMode ? Colors.green : Colors.redAccent)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buttonRounded(title: '0'),
                      _buttonRounded(title: '.'),
                      _buttonRounded(
                          title: "C",
                          textColor:
                          darkMode ? Colors.green : Colors.redAccent),
                      _buttonRounded(
                          title: '=',
                          textColor: darkMode ? Colors.green : Colors.redAccent)
                    ],
                  )
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buttonRounded({String title = "",
    double padding = 17,
    IconData? icon,
    Color? iconColor,
    Color? textColor}) {
    double fontSize;
    var screenSize = MediaQuery
        .of(context)
        .size;
    if (screenSize.width > 800) {
      fontSize = 24;
    } else if (screenSize.width > 600) {
      fontSize = 25;
    } else if (screenSize.height > 850) {
      fontSize = 30;
    } else {
      fontSize = 20;
    }
    return Padding(
      padding: const EdgeInsets.all(8),
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () {
          setState(() {
            handleButtons(title);
          });
        },
        child: NeuContainer(
          darkMode: darkMode,
          borderRadius: BorderRadius.circular(40),
          padding: EdgeInsets.all(MediaQuery
              .of(context)
              .size
              .width / 26),
          child: SizedBox(
            width: padding * 2,
            height: padding * 2,
            child: Center(
                child: title != null
                    ? Text(
                  title,
                  style: TextStyle(
                    color: textColor ??
                        (darkMode ? Colors.white : Colors.black),
                    fontSize: fontSize,
                  ),
                )
                    : Icon(
                  icon,
                  color: iconColor,
                  size: 30,
                )),
          ),
        ),
      ),
    );
  }

  Widget _buttonOval({required String title, double padding = 16}) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () {
          setState(() {
            handleButtons(title);
          });
        },
        child: NeuContainer(
          darkMode: darkMode,
          borderRadius: BorderRadius.circular(50),
          padding:
          EdgeInsets.symmetric(horizontal: padding, vertical: padding / 2),

          child: SizedBox(
            width: MediaQuery
                .of(context)
                .size
                .width / 11,
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                    color: darkMode ? Colors.white : Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _switchMode() {
    final Size size = MediaQuery
        .of(context)
        .size;
    return NeuContainer(
      darkMode: darkMode,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      borderRadius: BorderRadius.circular(40),
      child: SizedBox(
        width: size.width / 5,
        child:
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Icon(
            Icons.wb_sunny,
            color: darkMode ? Colors.grey : Colors.redAccent,
          ),
          Icon(
            Icons.nightlight_round,
            color: darkMode ? Colors.green : Colors.grey,
          ),
        ]),
      ),
    );
  }

  void handleButtons(String title) {
    if (title == "AC") {
      input = "";
      result = "0";
      return;
    }
    if (title == "C") {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
        return;
      }
    }
    if (title == "=") {
      result = calculate();
      input = result;
      if (input.endsWith(".0")) {
        input = input.replaceAll(".0", "");
        return;
      }

      if (result.endsWith(".0")) {
        result = result.replaceAll(".0", "");
        return;
      }
      int decimalIndex = result.indexOf(".");
      if (decimalIndex != -1 && result.length > decimalIndex + 3) {
        result = result.substring(0, decimalIndex + 4);
        return;
      }
    }
    if (title == "(" && input.isNotEmpty) {
      String lastChar = input[input.length - 1];
      if (isNumeric(lastChar) || lastChar == ")") {
        input += "*";
      }
    }
    if (title == "sin") {
      input += "sin(";
      return;
    }
    if (title == "cos") {
      input += "cos(";
      return;
    }
    if (title == "tan") {
      input += "tan(";
      return;
    }
    if (title == "%") {
      input += "%";
      return;
    }

    input = input + title;
  }
  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  String calculate() {
    try {
      // replace instances of )( with *
      var updatedInput = input.replaceAll(')(', ')*(');
      var exp = Parser().parse(updatedInput);
      var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
      return evaluation.toString();
    } catch (e) {
      return "Error";
    }
  }
}
