import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

const String apiKey = 'AIzaSyBZNtpoclq_GC2dOs6xQ4V62lRFdNo4VbY';

class ListaPage extends StatefulWidget {
  @override
  State<ListaPage> createState() => _ListaPageState();
}

class _ListaPageState extends State<ListaPage> {
  String result = 'Resultado';

  Future predictPlant(File image) async {
    // set Gemini Model and it API KEY
    final model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: apiKey,
    );

    // set the LLM prompt
    final prompt =
        'Você é um especialista em botânica. Eu vou te enviar uma imagem de uma planta e você me responde, apenas se houver uma planta na image, qual é a planta e se ela está saudável ou não. Caso não esteja saudável, me dê dicas para melhorar sua saúde. Caso não encontre uma planta, retorne "Não encontrei nenhuma planta na imagem".';

    var imageInBytes = await image.readAsBytes();

    final content = [
      Content.multi([
        TextPart(prompt),
        DataPart('image/jpeg', imageInBytes),
      ])
    ];

    final response = await model.generateContent(content);

    return response.text;
  }

  Future<File?> takePicture() async {
    var photo = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (photo == null) return null;
    return File(photo.path);
  }

  Future verifyPlant() async {
    var image = await takePicture();
    if (image == null) return null;
    String resultado = await predictPlant(image);
    setState(() => result = resultado);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gemini'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        children: [
          Flexible(
            child: Container(
              // height: 50,
              width: double.infinity,
              color: Colors.grey[200],
              child: MarkdownBody(
                data: result,
              ),
            ),
          ),
          Flexible(
            child: ListView(
              children: [
                ListTile(
                  title: Text("Girassol"),
                  subtitle: Text("Ela está saudável"),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://s1.static.brasilescola.uol.com.br/be/2023/09/vista-aproximada-de-um-girassol-em-uma-plantacao-de-girassois.jpg'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => verifyPlant(),
        child: Icon(Icons.camera_alt),
      ),
    );
  }
}
