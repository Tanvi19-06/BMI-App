import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final wtController = TextEditingController();
  final ftController = TextEditingController();
  final inController = TextEditingController();
  final ageController = TextEditingController();

  String result = "";
  String healthTip = "";
  String? selectedGender = 'Male';
  Color bgColor = Colors.indigo.shade200;

  final List<String> genders = ['Male', 'Female', 'Other'];

  void _calculateBMI() {
    final wt = wtController.text;
    final ft = ftController.text;
    final inch = inController.text;
    final age = ageController.text;

    if (wt.isNotEmpty && ft.isNotEmpty && inch.isNotEmpty && age.isNotEmpty) {
      final iWt = double.tryParse(wt);
      final iFt = double.tryParse(ft);
      final iInch = double.tryParse(inch);
      final iAge = int.tryParse(age);

      if (iWt != null && iFt != null && iInch != null && iAge != null) {
        final tInch = (iFt * 12) + iInch;
        final tCm = tInch * 2.54;
        final tM = tCm / 100;

        final bmi = iWt / (tM * tM);
        String msg;
        String tip;

        if (bmi > 25) {
          msg = "You are overweight!";
          tip =
              "Consider a balanced diet and regular exercise. Consult a healthcare provider for personalized advice.";
          bgColor = Colors.orange.shade200;
        } else if (bmi < 18) {
          msg = "You are underweight!";
          tip =
              "Focus on nutrient-rich foods and consider consulting a healthcare provider for personalized advice.";
          bgColor = Colors.red.shade200;
        } else {
          msg = "You are healthy!";
          tip =
              "Maintain a balanced diet and regular physical activity to stay fit.";
          bgColor = Colors.green.shade200;
        }

        setState(() {
          result = "$msg \nYour BMI is: ${bmi.toStringAsFixed(2)}";
          healthTip = tip;
        });
      } else {
        setState(() {
          result = "Please enter valid numbers!";
          healthTip = "";
        });
      }
    } else {
      setState(() {
        result = "Please fill all fields!";
        healthTip = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator'),
      ),
      body: Container(
        color: bgColor,
        child: Center(
          child: Container(
            width: 350,
            padding: const EdgeInsets.all(0.0002),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'BMI Calculator',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                DropdownButton<String>(
                  value: selectedGender,
                  items: genders.map((String gender) {
                    return DropdownMenuItem<String>(
                      value: gender,
                      child: Text(gender),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedGender = newValue;
                    });
                  },
                  isExpanded: true,
                  hint: const Text('Select Gender'),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: ageController,
                  decoration: const InputDecoration(
                    labelText: 'Enter your Age',
                    prefixIcon: Icon(Icons.calendar_today),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: wtController,
                  decoration: const InputDecoration(
                    labelText: 'Enter your Weight (kg)',
                    prefixIcon: Icon(Icons.line_weight),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: ftController,
                  decoration: const InputDecoration(
                    labelText: 'Enter your Height (feet)',
                    prefixIcon: Icon(Icons.height),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: inController,
                  decoration: const InputDecoration(
                    labelText: 'Enter your Height (inches)',
                    prefixIcon: Icon(Icons.height),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _calculateBMI,
                  child: const Text('Calculate'),
                ),
                const SizedBox(height: 10),
                Text(result, style: const TextStyle(fontSize: 26)),
                const SizedBox(height: 10),
                Text(
                  healthTip,
                  style: const TextStyle(fontSize: 16, color: Colors.blueGrey),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
