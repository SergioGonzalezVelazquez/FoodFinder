import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CreditoCuentaPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CreditoCuentaState();
  }
}

class _CreditoCuentaState extends State<CreditoCuentaPage> {
  TextEditingController codigoController = TextEditingController();
  bool _isButtonDisabled;

  @override
  void initState() {
    super.initState();
    _isButtonDisabled = true;
    codigoController.addListener(_listenerController);
  }

  void _listenerController() {
    setState(() {
      _isButtonDisabled = false;
    });
  }

  void dispose() {
    super.dispose();
    codigoController.dispose();
  }

  Widget _creditoCuentaPage(BuildContext context) {
    return Center(
      child: new Container(
        padding: EdgeInsets.all(25),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Saldo',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              SizedBox(height: 10),
              Text(
                '€0,00',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 34,
                    color: Colors.green),
              ),
              SizedBox(height: 20),
              Text(
                'Puedes pagar con tu crédido de cuenta en el próximo pedido. No podrás usarlo en pedidios en efectivo',
              ),
              SizedBox(height: 10),
              TextField(
                  controller: codigoController,
                  decoration: InputDecoration(
                      labelText: 'Introduce un código promocional',
                      labelStyle: TextStyle(fontSize: 14))),
              SizedBox(height: 10),
              _btnAplicar(context),
            ]),
      ),
    );
  }

  Widget _btnAplicar(BuildContext context) {
    return RaisedButton(
      color: Theme.of(context).primaryColor,
      onPressed: _isButtonDisabled
          ? null
          : () {
              Fluttertoast.showToast(
                  msg: "Has introducido un código no válido");
            },
      child: Center(
        child: Text(
          "Aplicar",
          style: TextStyle(
            color: _isButtonDisabled ? Colors.black : Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        //elevation: 0.0, //Quitar sombra de la appBar
        title: new Text('Crédito de la cuenta'),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor,
        ),
        backgroundColor: Theme.of(context).bottomAppBarColor,
      ),
      body: _creditoCuentaPage(context),
    );
  }
}
