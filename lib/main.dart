import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ConsultaCepPage(),
    );
  }
}


class ConsultaCepPage extends StatefulWidget {
  const ConsultaCepPage({super.key});

  @override
  State<ConsultaCepPage> createState() => _ConsultaCepPageState();
}

class _ConsultaCepPageState extends State<ConsultaCepPage> {
  TextEditingController cepController = TextEditingController();
  String resultado = "";

  Future<void> consultarCep() async{
    String url = "https://viacep.com.br/ws/${cepController.text}/json/";

    var response = await http.get(Uri.parse(url));

    Map dados = json.decode(response.body);

    setState(() {
      resultado = "CEP: ${dados['cep']}\n"
          "Logradouro: ${dados['logradouro']}\n"
          "Bairro: ${dados['bairro']}\n"
          "Cidade: ${dados['localidade']}\n"
          "Estado: ${dados['uf']}";
    });
  }
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consulta de CEP'),
      ), 
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: cepController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Digite o CEP',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: consultarCep,
              child: const Text('Consultar'),
            ),
            const SizedBox(height: 20),
            const Text(
              "Resultado da consulta:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(resultado),
          ],
        ),
      ),
    );
  }
}