import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class PutClimateScreen extends StatefulWidget {
  final String documentId;
  final double initialTemperature;
  final double initialHumidity;

  const PutClimateScreen({super.key,required this.documentId, required this.initialHumidity, required this.initialTemperature});

  @override
  State<PutClimateScreen> createState() => _PutClimateScreenState();
}

class _PutClimateScreenState extends State<PutClimateScreen> {
   TextEditingController temperatureController = TextEditingController();
   TextEditingController humidityController = TextEditingController();

   Future<void> updateClimate() async{
    double? temp = double.tryParse(temperatureController.text);
    double? hum = double.tryParse(humidityController.text);

    await FirebaseFirestore.instance.collection('Monte Mor').doc(widget.documentId).set({
      'temperature' : temp,
      'humidity' : hum,
    }, SetOptions(merge: true));

    ScaffoldMessenger.of(context).showSnackBar( // Notificação que avisa que os dados foram entregues
      SnackBar(content: Text('Dados enviados com sucesso!'))
    );

    Navigator.pop(context);

   } // Função Future

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tela de Alteração de dados')),

      body:Column(children: [
        Text('Temperatura Anterior: ${widget.initialTemperature}'),
        TextField(
          controller: temperatureController, // variavel que visualiza as informaçoes
          keyboardType: TextInputType.number, // tipo de teclado para o usuario inserir dados.
          decoration: InputDecoration(labelText: 'insira sua temperatura') , // mensagem para o usuario inserir os dados
        ),
        TextField(
            controller: humidityController, // variavel que visualiza as informaçoes
            keyboardType: TextInputType.number, 
            decoration: InputDecoration(labelText: 'insira sua humidade') ,
        ),
        ElevatedButton(onPressed: updateClimate, child: Text('Alterar')), // envia os dados da função
      ],) ,
    );
  }
}