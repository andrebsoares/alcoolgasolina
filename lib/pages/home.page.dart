import 'package:alcoolgasolina/widgets/logo.widget.dart';
import 'package:alcoolgasolina/widgets/submit-form.dart';
import 'package:alcoolgasolina/widgets/success.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color _color = Colors.deepPurple;
  var _gasCtrl = new MoneyMaskedTextController();
  var _alcCtrl = new MoneyMaskedTextController();
  var _busy = false;
  var _complete = false;
  var _resultText = "Compensa utilizar X";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: AnimatedContainer(
          duration: Duration(
            milliseconds: 1200,
          ),
          color: _color,
          child: ListView(
            children: <Widget>[
              Logo(),
              _complete
                  ? Success(
                      reset: reset,
                      result: _resultText,
                    )
                  : SubmitForm(
                      gasCtrl: _gasCtrl,
                      alcCtrl: _alcCtrl,
                      busy: _busy,
                      submitFunc: calculate)
            ],
          ),
        ));
  }

  Future calculate() {
    double alc =
        double.parse(_alcCtrl.text.replaceAll(new RegExp(r'[,.]'), '')) / 100;

    double gas =
        double.parse(_gasCtrl.text.replaceAll(new RegExp(r'[,.]'), '')) / 100;

    double res = alc / gas;

    setState(() {
      _color = Colors.deepPurpleAccent;
      _complete = false;
      _busy = true;
    });

    return new Future.delayed(
        const Duration(seconds: 3),
        () => {
              setState(() {
                if (res >= 0.7) {
                  _resultText = "Compensa utilizar Gasolina!";
                } else {
                  _resultText = "Compensa utlizar Álcool!";
                }

                _busy = false;
                _complete = true;
              })
            });
  }

  reset() {
    setState(() {
      _alcCtrl = new MoneyMaskedTextController();
      _gasCtrl = new MoneyMaskedTextController();
      _complete = false;
      _busy = false;
      _color = Colors.deepPurple;
    });
  }
}
