import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(
  MaterialApp(
    title: 'EMI Calculator',

    theme: ThemeData(
      primaryColor: Colors.indigoAccent,
    ),

    home: MyHomePage()
  )
);

// ignore: use_key_in_widget_constructors
class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List _tenureTypes = [ 'Month(s)', 'Year(s)'];
  String _tenureType = 'Year(s)';
  String _emiResult = "";
  bool _switchValue = true;
  final TextEditingController _principalAmount = TextEditingController();
  final TextEditingController _interestRate = TextEditingController();
  final TextEditingController _tenure = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('EMI Calculator'),
      ),

      body: Center(
        child: Container(

          child: Column(
            children: <Widget>[

              // Principle Amount
              Container(
                padding: EdgeInsets.all(30.0),
                child: TextField(
                  controller: _principalAmount,
                  decoration: InputDecoration(
                    labelText: "Principle Amount"
                  ),
                ),
              ),

              // Interest Rate
              Container(
                padding: EdgeInsets.all(30.0),
                child: TextField(
                  controller: _interestRate,
                  decoration: InputDecoration(
                      labelText: "Interest Rate"
                  ),
                ),
              ),

              // Tenure
              Container(
                padding: EdgeInsets.all(30.0),
                child: Row(
                  children: <Widget>[

                    Flexible(
                      flex: 4,
                      fit: FlexFit.tight,
                      child: TextField(
                        controller: _tenure,
                        decoration: InputDecoration(
                          labelText: "Tenure"
                        ),
                      )
                    ),

                    Flexible(
                      flex: 1,
                      child: Column(
                        children: [

                          Text(
                            _tenureType,
                            style: TextStyle(
                              fontWeight: FontWeight.bold
                            )
                          ),

                          Switch(value: _switchValue,
                              onChanged: (bool value) {
                              print(value);

                              if(value)
                                _tenureType = _tenureTypes[1];
                              else
                                _tenureType = _tenureTypes[0];

                              setState(() {
                                _switchValue = value;
                              });
                            }
                          )

                        ],
                      ),
                    )
                  ],
                )
              ),

              Container(
                color: Colors.indigoAccent,
                child: Flexible(
                  fit: FlexFit.loose,
                  child: TextButton(
                    onPressed: () { _doCalculation(); },
                    child: Text(
                      "Calculate",
                      style: TextStyle(
                        color: Colors.white,
                      ),

                    ),
                  ),
                ),
                padding: EdgeInsets.only(left: 24.0, top: 10.0, right: 24.0, bottom: 10.0),
              ),
              
              emiResults(_emiResult)
              
            ],
          ),
        ),
      ),
    );
  }

  void _doCalculation() {
    double A = 0.0;
    int P = int.parse(_principalAmount.text);
    double r = int.parse(_interestRate.text)/(12*100);
    int n = int.parse(_tenure.text);
    if(_tenureType == "Year(s)") {
      n = n * 12;
    }

      A = (P*r*pow(1+r, n))/(pow(1+r, n)-1);
      _emiResult = A.toStringAsFixed(2);

      setState(() {

      });
    }
  }

  Widget emiResults(emiResult) {

    bool canShow = false;
    String _emiResult = emiResult;

    if(_emiResult.isNotEmpty) {
      canShow = true;
    }

      return Container(
        margin: EdgeInsets.only(top: 40.0),
        child: canShow ? Column(
          children: [
            Text("Your Monthly EMI is",
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold
              ),
            ),
            Container(
              child: Text(_emiResult,
                style: TextStyle(
                    fontSize: 50.0,
                    fontWeight: FontWeight.bold
                ),
              ),
            )
          ],
        ): Container()
      );
    }


