import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ClimaScreen extends StatefulWidget {
  const ClimaScreen({super.key});

  @override
  State<ClimaScreen> createState() => _ClimaScreenState();
}

class _ClimaScreenState extends State<ClimaScreen> {
  double temperature = 0.0;
  double humidity = 0.0;
  double rain = 0.0;
  @override
  void initState(){
    super.initState();
    fetchData();
  }
  void fetchData() {
    FirebaseFirestore.instance.collection('Monte Mor').snapshots().listen((snapshot) {
      var data = snapshot.docs.first.data();
      setState(() {
        temperature = (data['temperature'] ?? 0).toDouble();
        humidity = (data['humidity'] ?? 0).toDouble();
        rain = (data['rain'] ?? 0).toDouble();
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        
        child: 
        
        Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Temperatura: $temperature°C',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              'Umidade: $humidity%',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'Previsão de chuva: $rain%',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            
          ],
        ),
      ),
    );
  }
} 

 