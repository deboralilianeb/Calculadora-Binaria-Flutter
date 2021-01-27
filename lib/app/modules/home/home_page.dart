import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_teste/app/modules/resources/utils.dart';
import 'package:toast/toast.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Calculadora Binária"})
      : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  //use 'controller' variable to access controller
  final _formKey = GlobalKey<FormState>();
  var n1TaskController = new TextEditingController();
  var n2TaskController = new TextEditingController();
  String result = "";
  String dropdownValue = 'Selecione a operação';
  bool mostrarResultado = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fundo,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: fundo,
        title: Text(
          widget.title,
          style: TextStyle(
            color: cor_principal,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.1,
                  left: 10,
                  right: 10 ),
              child: Container(
                  margin: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      border: Border.all(
                          color: cor_principal, 
                          width: 3.0), 
                      borderRadius: BorderRadius.all(Radius.circular(10.0))), //
                  child: Form(
                      autovalidate: true,
                      key: _formKey,
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              controller: n1TaskController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                hintText: 'Insira o número binário',
                                labelText: 'Número 1',
                              ),
                              validator: _validarBinarios,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            DropdownButton<String>(
                              value: dropdownValue,
                              icon: Icon(Icons.arrow_downward),
                              iconSize: 10,
                              elevation: 16,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: font_size_medium),
                              underline: Container(
                                height: 2,
                                color: Colors.black,
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  dropdownValue = newValue;
                                });
                              },
                              items: <String>[
                                'Selecione a operação',
                                '+',
                                '-',
                                '*',
                                '/',
                                '%'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: n2TaskController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                hintText: 'Insira o número binário',
                                labelText: 'Número 2',
                              ),
                              validator: _validarBinarios,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            RaisedButton(
                              color: cor_principal,
                              onPressed: () {
                                if (!_formKey.currentState.validate()) {
                                  Toast.show(
                                      "Os campos não foram preenchidos corretamente.",
                                      context,
                                      gravity: Toast.CENTER,
                                      duration: Toast.LENGTH_LONG);
                                } else if (n1TaskController.text == "" ||
                                    n2TaskController.text == "") {
                                  Toast.show(
                                      "É necessário inserir o números da operação.",
                                      context,
                                      gravity: Toast.CENTER,
                                      duration: Toast.LENGTH_LONG);
                                } else if (dropdownValue ==
                                    "Selecione a operação") {
                                  Toast.show(
                                      "Nenhuma operação foi selecionada.",
                                      context,
                                      gravity: Toast.CENTER,
                                      duration: Toast.LENGTH_LONG);
                                } else {
                                  String num1Dec = controller
                                      .binToDec(n1TaskController.text);
                                  String num2Dec = controller
                                      .binToDec(n2TaskController.text);

                                  setState(() {
                                    result = controller.calcula(
                                        num1Dec, num2Dec, dropdownValue);
                                    mostrarResultado = true;
                                  });
                                }
                              },
                              textColor: Colors.white,
                              padding: const EdgeInsets.all(0.0),
                              child: Container(
                                padding: const EdgeInsets.all(10.0),
                                child: const Text('Calcular',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: fundo)),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Visibility(
                                visible: mostrarResultado,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text("Resultado:",
                                          style:
                                              TextStyle(color: cor_principal))
                                    ])),
                            SizedBox(
                              height: 10,
                            ),
                            Visibility(
                                visible: mostrarResultado,
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.90,
                                  child: Center(
                                      child: Text(
                                    result,
                                    style: TextStyle(
                                        fontSize: font_size_large,
                                        fontWeight: FontWeight.bold),
                                  )),
                                  height: 50,
                                  color: Colors.teal[50],
                                ))
                          ],
                        ),
                      ))))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            n1TaskController.clear();
            n2TaskController.clear();
            dropdownValue = 'Selecione a operação';
            result = "";
            mostrarResultado = false;
          });

          Toast.show("Os dados foram limpos", context, gravity: Toast.CENTER);
        },
        elevation: 5,
        tooltip: "Limpar",
        child: Icon(Icons.clear, color: Colors.white, size: 30,),
        backgroundColor: Colors.red
      ),
    );
  }

  String _validarBinarios(String value) {
    String pattern = r'^(0|1){1,8}$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Nenhum número adicionado";
    } else if (!regExp.hasMatch(value)) {
      return "Número inválido";
    } else {
      return null;
    }
  }
}
