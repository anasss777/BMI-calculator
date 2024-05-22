import 'package:flutter/material.dart';

void main() {
  runApp(const BMICalculator());
}

class BMICalculator extends StatelessWidget {
  const BMICalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: InputPage(),
    );
  }
}

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  double _bmi = 0;
  String _bmiCategory = '';

  void calculateBMI() {
    double height = double.parse(heightController.text) / 100;
    double weight = double.parse(weightController.text);

    setState(() {
      _bmi = weight / (height * height);
      _bmiCategory = _getBMICategory(_bmi);
    });
  }

  String _getBMICategory(double bmi) {
    if (bmi < 16) {
      return 'Severe Thinness 😱';
    } else if (bmi >= 16 && bmi < 17) {
      return 'Moderate Thinness 😟';
    } else if (bmi >= 17 && bmi < 18.5) {
      return 'Mild Thinness 😕';
    } else if (bmi >= 18.5 && bmi < 25) {
      return 'Normal 😊';
    } else if (bmi >= 25 && bmi < 30) {
      return 'Overweight 😐';
    } else if (bmi >= 30 && bmi < 35) {
      return 'Obese Class I 😟';
    } else if (bmi >= 35 && bmi < 40) {
      return 'Obese Class II 😟';
    } else {
      return 'Obese Class III 😱';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('BMI Calculator'),
          backgroundColor: const Color(0xff102010),
          foregroundColor: Colors.white,
        ),
        backgroundColor: const Color(0xff102010),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 50.0, 16.0, 16.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: heightController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff006600))),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff009900)),
                    ),
                    labelText: 'Height in cm',
                    labelStyle: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: weightController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff006600))),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff009900)),
                    ),
                    labelText: 'Weight in kg',
                    labelStyle: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: calculateBMI,
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(const Color(0xff005500)),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  elevation: MaterialStateProperty.all<double>(10),
                  shadowColor: MaterialStateProperty.all<Color>(Colors.black),
                ),
                child: const Text('Calculate'),
              ),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: _bmi == 0
                          ? 'Enter values and press calculate'
                          : 'Your BMI is ${_bmi.toStringAsFixed(2)} ',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                    TextSpan(
                      text: _bmiCategory,
                      style: TextStyle(
                        color: _getBMICategoryColor(_bmiCategory),
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getBMICategoryColor(String category) {
    switch (category) {
      case 'Severe Thinness 😱':
        return Colors.red;
      case 'Moderate Thinness 😟':
        return Colors.orange;
      case 'Mild Thinness 😕':
        return Colors.yellow;
      case 'Normal 😊':
        return Colors.green;
      case 'Overweight 😐':
        return Colors.yellow;
      case 'Obese Class I 😟':
        return Colors.orange;
      case 'Obese Class II 😟':
        return Colors.red;
      case 'Obese Class III 😱':
        return Colors.red.shade900;
      default:
        return Colors.white;
    }
  }
}
