import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


class PostClimateScreen extends StatefulWidget {
  const PostClimateScreen({super.key});

  @override
  State<PostClimateScreen> createState() => _PostClimateScreenState();
}

class _PostClimateScreenState extends State<PostClimateScreen> {
  final TextEditingController temperatureController = TextEditingController();
  final TextEditingController humidityController = TextEditingController();

  Future<void> postData() async{

    final timeStamp = DateTime.timestamp();
    final double temp = double.parse(temperatureController.text);
    final double humi = double.parse(humidityController.text);


    await FirebaseFirestore.instance.collection('Monte Mor').add(
      {
        'timeStamp' : timeStamp,
        'temperature' : temp,
        'humidity': humi,

      }
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content:Text('Seus dados foram enviados com sucesso!'))
      );

      temperatureController.clear(); 
      humidityController.clear();

  }//Future
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: Text('Sua tela de Post'),
    ),
    body: Column(
      children: [
        TextField(
          controller: temperatureController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: 'Insira Temperatura'),
        ),

        TextField(
          controller: humidityController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: 'Insira a Umidade'),
        ),
        ElevatedButton(onPressed: postData, child: Text('Enviar'))
      ],
    ),);
  }
}