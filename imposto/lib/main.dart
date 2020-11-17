import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:imposto/details.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _valorController = new MoneyMaskedTextController(
      decimalSeparator: ',', thousandSeparator: '.', leftSymbol: 'R\$ ');
  final _valorImpostoController = new MoneyMaskedTextController(
      decimalSeparator: ',', thousandSeparator: '.', leftSymbol: 'R\$ ');
  final _cpfController = new MaskedTextController(mask: '000.000.000-00');
  final _nomeController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informacoes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Image.asset(
                    'assets/leao.png',
                    height: 200,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: TextFormField(
                        textCapitalization: TextCapitalization.words,
                        controller: _nomeController,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.create),
                          helperText: 'Informe seu nome',
                          border: OutlineInputBorder(),
                          labelText: 'Nome',
                          labelStyle: TextStyle(color: Colors.black87),
                          hintText: 'Ex: Onicio',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Insira o nome';
                          }

                          return null;
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: TextFormField(
                        controller: _cpfController,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.create),
                          helperText: 'Informe somente os numeros do seu cpf',
                          border: OutlineInputBorder(),
                          labelText: 'CPF',
                          labelStyle: TextStyle(color: Colors.black87),
                          hintText: 'Ex: 123.456.789-00',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Insira o cpf';
                          }

                          return null;
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _valorController,
                        decoration: InputDecoration(
                          helperText: 'Informe o valor do salario mensal',
                          border: OutlineInputBorder(),
                          labelText: 'Valor',
                          labelStyle: TextStyle(color: Colors.black87),
                        ),
                        validator: (value) {
                          var valueParsed = double.parse(value
                              .replaceAll('R\$ ', '')
                              .replaceAll('.', '')
                              .replaceAll(',', '.'));

                          if (valueParsed <= 0) {
                            return 'Insira o valor';
                          }

                          return null;
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _valorImpostoController,
                        decoration: InputDecoration(
                          helperText:
                              'Informe o valor do imposto retido no salario mensal',
                          border: OutlineInputBorder(),
                          labelText: 'Valor',
                          labelStyle: TextStyle(color: Colors.black87),
                        ),
                        validator: (value) {
                          var valueParsed = double.parse(value
                              .replaceAll('R\$ ', '')
                              .replaceAll('.', '')
                              .replaceAll(',', '.'));

                          if (valueParsed <= 0) {
                            return 'Insira o valor';
                          }

                          return null;
                        }),
                  ),
                ],
              )),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          if (_formKey.currentState.validate()) {
            var valueSalario = _valorController.numberValue;
            var valueImposto = _valorController.numberValue;

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ShowDetails(valueSalario, valueImposto)));
          }
        },
        tooltip: 'Save',
        child: Icon(Icons.check),
      ),
    );
  }
}
