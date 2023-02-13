import 'package:calculator/colors.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Calculator(),
  ));
}


class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}


class _CalculatorState extends State<Calculator> {
  double firstNumber = 0.0;
  double secondNumber = 0.0;
  String input = '';
  String output = '';
  String operation = '';


  buttonClick(value) {
    inputSplitSpace() {
      String inputSplitSpaceNumber(number) {
        number = number.replaceAllMapped(RegExp(r' '), (match) => '');
        number = number.split('').reversed.join('').replaceAllMapped(RegExp(r'.{3}'),
                (match) => '${match.group(0)} ').trimRight();
        number = number.split('').reversed.join('');

        return number;
      }


      if (operation == '') {
        input = inputSplitSpaceNumber(input);
      }
      else {
        String firstPart = input.split(operation).elementAt(0);
        String secondPart = input.split(operation).elementAt(1);
        input = firstPart + operation + inputSplitSpaceNumber(secondPart);
      }
    }


    roundProcess(result) {
      if (result % 1 == 0) {
        output = result.round().toString();
      }
      else {
        output = result.toString().replaceAllMapped(RegExp(r'\.'), (match) => ',');
      }
    }


    calculate() {
      double result = 0.0;

      if (operation == '+') {
        result = firstNumber + secondNumber;
      }
      else if (operation == '-') {
        result = firstNumber - secondNumber;
      }
      else if (operation == '×') {
        result = firstNumber * secondNumber;
      }
      else if (operation == '÷') {
        result = firstNumber / secondNumber;
      }
      else if (operation == '%') {
        result = firstNumber / 100 * secondNumber;
      }

      return result;
    }


    parseInput() {
      if (operation != '') {
        List numbers = input.split(operation);
        List numbersResult = [];

        for (int i = 0; i < numbers.length; i++){
          numbersResult.insert(i,
              numbers.elementAt(i).replaceAllMapped(RegExp(r','), (match) => '.'));
        }

        firstNumber = double.parse(
            numbersResult.elementAt(0).replaceAllMapped(RegExp(r' '), (match) => ''));

        if (numbers.length == 1) {
          secondNumber = 1;
        }
        else {
          String valueSecond = numbersResult.elementAt(1).replaceAllMapped(RegExp(r' '), (match) => '');
          if (valueSecond == '') {
            secondNumber = 0;
            output = '';
          }
          else {
            secondNumber = double.parse(
                numbersResult.elementAt(1).replaceAllMapped(RegExp(r' '), (match) => ''));

            double result = calculate();
            roundProcess(result);
          }
        }
      }
    }


    if (value == 'C') {
      input = '';
      output = '';
      operation = '';
    }
    else if (value == 'backspace-outline') {
      if (input.length > 0.0) {
        if (operation != '') {
          if (!input.substring(input.length - 1).contains(RegExp(r'\d'))) {
            operation = '';
            output = '';
          }
          else if (!input.substring(input.length - 2, input.length - 1).contains(RegExp(r'\d'))) {
            output = '';
          }
        }
        input = input.substring(0, input.length - 1);
        parseInput();
        // inputSplitSpace();
      }
    }
    else if (value == 'percent-outline') {
      double result = double.parse(input) / 100;
      roundProcess(result);

      operation = '%';
      input += operation;
    }
    else if (value == 'division') {
      operation = '÷';
      input += operation;
    }
    else if (value == 'multiplication') {
      operation = '×';
      input += operation;
    }
    else if (value == 'minus') {
      operation = '-';
      input += operation;
    }
    else if (value == 'plus') {
      operation = '+';
      input += operation;
    }
    else if (value == 'equal') {

    }
    else if (value == ',') {
      input += ',';
    }
    else {
      input += value;
      parseInput();
      // inputSplitSpace();
    }

    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(right: 20, bottom: 30, left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    child: FittedBox(
                      child: Text(
                        input,
                        softWrap: false,
                        style: const TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: whiteColor),
                      ),
                    )
                  ),
                  Text(
                    output,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.normal,
                      color: Color(0xff696969)),
                  ),
                ],
              ),
            )),
            Container(
              padding: const EdgeInsets.only(top: 20, right: 20, bottom: 0, left: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buttonText(text: 'C', backgroundColor: operationsColor),
                      buttonIcon(icon: 'percent-outline'),
                      buttonIcon(icon: 'backspace-outline'),
                      buttonIcon(icon: 'division'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buttonText(text: '7'),
                      buttonText(text: '8'),
                      buttonText(text: '9'),
                      buttonIcon(icon: 'multiplication'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buttonText(text: '4'),
                      buttonText(text: '5'),
                      buttonText(text: '6'),
                      buttonIcon(icon: 'minus'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buttonText(text: '1'),
                      buttonText(text: '2'),
                      buttonText(text: '3'),
                      buttonIcon(icon: 'plus'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buttonText(text: '00'),
                      buttonText(text: '0'),
                      buttonText(text: ','),
                      buttonIcon(icon: 'equal', backgroundColor: orangeColor),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buttonText({text, textColor=Colors.white, backgroundColor=numbersColor}) {
    return Container(
        padding: const EdgeInsets.only(bottom: 20),
        child: ElevatedButton(
            onPressed: () => buttonClick(text),
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(16),
              backgroundColor: backgroundColor,
            ),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.normal,
                color: textColor,
              ),
            )));
  }

  Widget buttonIcon({icon, iconColor=Colors.white,
    backgroundColor=operationsColor, heightIcon=30.0}) {
    return Container(
        padding: const EdgeInsets.only(bottom: 18),
        child: ElevatedButton(
          onPressed: () => buttonClick(icon),
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(16),
            backgroundColor: backgroundColor,
          ),
          child: SizedBox(
            height: heightIcon,
            child: Image.asset(
              'lib/icons/$icon.png',
              color: iconColor,
            ),
          ),
        ));
  }
}
