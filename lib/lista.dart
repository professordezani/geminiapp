import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

const String apiKey = 'AIzaSyBZNtpoclq_GC2dOs6xQ4V62lRFdNo4VbY';

class ListaPage extends StatelessWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future predictPlant(File image) async {
    final schema = Schema.object(
      properties: {
        'recognized': Schema.boolean(
            description: 'Indica se reconheceu uma planta ou não na imagem.',
            nullable: false),
        'plant_name':
            Schema.string(description: 'Nome da planta.', nullable: true),
        'healthy': Schema.boolean(
            description: 'Indica se planta está saudável ou não.',
            nullable: true),
        'disease_description': Schema.string(
            description: 'Descrição da doença ou mal cuidados reconhecidos.',
            nullable: true),
        'care_to_take': Schema.string(
            description: 'Descrição de como cuidar para recuperação da planta.',
            nullable: true),
      },
      requiredProperties: ['recognized', 'plant_name', 'healthy'],
    );

    final model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: apiKey,
      generationConfig: GenerationConfig(
        responseMimeType: 'application/json',
        responseSchema: schema,
      ),
    );

    // set the LLM prompt
    final prompt =
        'Você é um especialista em botânica. Eu vou te enviar uma imagem de uma planta e você me responde, apenas se houver uma planta na image, qual é a planta e se ela está saudável ou não. Caso não esteja saudável, indique a doença e me dê dicas para melhorar sua saúde. Caso não encontre uma planta, retorne "Não encontrei nenhuma planta na imagem".';

    var imageInBytes = await image.readAsBytes();

    final content = [
      Content.multi([
        TextPart(prompt),
        DataPart('image/jpeg', imageInBytes),
      ])
    ];

    final response = await model.generateContent(content);

    print(response.text);
    return response.text;
  }

  Future<File?> takePicture() async {
    var photo = await ImagePicker().pickImage(source: ImageSource.camera);
    if (photo == null) return null;
    return File(photo.path);
  }

  Future verifyPlant(BuildContext context) async {
    var image = await takePicture();
    if (image == null) return null;
    String inference = await predictPlant(image);

    var plant_value = json.decode(inference);
    if (plant_value['recognized']) {
      plant_value['image'] = image;
      Navigator.pushNamed(context, '/details', arguments: plant_value);
    } else {
      var snackBar = SnackBar(
        content: Text('Nenhuma planta encontrada.'),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Green Guide'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: firestore.collection('inferences').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            var documents = snapshot.data!.docs;

            return ListView(
                children: documents
                    .map((doc) => ListTile(
                          title: Text(doc['plant_name']),
                          subtitle: doc['healthy'] == true
                              ? Text("Ela está saudável",
                                  style: TextStyle(color: Colors.green[900]))
                              : Text("Ela não está saudável.",
                                  style: TextStyle(color: Colors.red)),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                'https://s1.static.brasilescola.uol.com.br/be/2023/09/vista-aproximada-de-um-girassol-em-uma-plantacao-de-girassois.jpg'),
                          ),
                        ))
                    .toList());
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => verifyPlant(context),
        child: Icon(Icons.camera_alt),
      ),
    );
  }
}
