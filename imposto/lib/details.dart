import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ShowDetails extends StatefulWidget {
  double _salario;
  double _imposto;

  ShowDetails(salario, imposto) {
    this._salario = salario;
    this._imposto = imposto;
  }

  @override
  _ShowDetailsState createState() => _ShowDetailsState(_salario, _imposto);
}

class _ShowDetailsState extends State<ShowDetails> {
  double _salario;
  double _imposto;

  _ShowDetailsState(salario, imposto) {
    this._salario = salario;
    this._imposto = imposto;
  }

  double _calcImpostoAnual() {
    var salarioAnual = _salario * 12;

    if (salarioAnual <= 22847.76) {
      return 0;
    } else if (salarioAnual > 22847.76 && salarioAnual <= 33919.80) {
      return salarioAnual * 7.5 / 100;
    } else if (salarioAnual > 33919.80 && salarioAnual <= 45012.60) {
      return salarioAnual * 15 / 100;
    } else if (salarioAnual > 45012.60 && salarioAnual <= 55976.16) {
      return salarioAnual * 22.5 / 100;
    } else if (salarioAnual > 55976.16) {
      return salarioAnual * 27.5 / 100;
    }
  }

  @override
  Widget build(BuildContext context) {
    var formatter = new NumberFormat.currency(
        decimalDigits: 2, symbol: 'R\$', locale: 'pt_BR');

    var impostoAnual = formatter.format(_calcImpostoAnual());
    var impostoRetido = formatter.format((_imposto * 12));
    var impostoDiferenca =
        formatter.format((_calcImpostoAnual() - (_imposto * 12)).abs());

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('O valor do imposto anual seria de: ' + impostoAnual),
            Text('Valor de imposto anual retido na fonte: ' + impostoRetido),
            Text('Pagar ou restituir: ' +
                (_calcImpostoAnual() > (_imposto * 12) ? 'Pagar' : 'Receber')),
            Text('Devera transacionar o valor de: ' + impostoDiferenca),
          ],
        ),
      ),
    );
  }
}
