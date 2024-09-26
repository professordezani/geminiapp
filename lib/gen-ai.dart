import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';

const String apiKey = 'AIzaSyAMQjZV5-cWYgscpcIjiWhWJRzu072I3dQ';

class GenAiPage extends StatefulWidget {
  @override
  State<GenAiPage> createState() => _GenAiPageState();
}

class _GenAiPageState extends State<GenAiPage> {
  Image? image;
  Map<String, dynamic>? inferenceJson;
  bool loading = false;

  Future predictPlant(Uint8List image) async {
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

    // var imageInBytes = await image.readAsBytes();

    final content = [
      Content.multi([
        TextPart(prompt),
        DataPart('image/jpeg', image),
      ])
    ];

    final response = await model.generateContent(content);

    return response.text;
  }

  Future<Uint8List?> takePicture() async {
    var photo = await ImagePicker().pickImage(source: ImageSource.camera);
    if (photo == null) {
      throw Exception('Não foi possível capturar a imagem.');
    }
    return await photo.readAsBytes();
  }

  Future verifyPlant(BuildContext context) async {
    try {
      setState(() => loading = true);

      var image = await takePicture();

      var inference = await predictPlant(image!);

      if (inference == null) {
        throw Exception('Não foi possível processar a imagem.');
      }

      setState(() {
        inferenceJson = json.decode(inference!);
        this.image = Image.memory(
          image,
          fit: BoxFit.cover,
        );
      });
    } on Exception catch (ex) {
      var snackBar = SnackBar(
        content: Text(ex.toString()),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } finally {
      setState(() => loading = false);
    }
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
      body: inferenceJson == null
          ? Container()
          : SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AspectRatio(
                      aspectRatio: 5 / 4,
                      child: image,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(inferenceJson!['plant_name'],
                            style: TextStyle(
                              fontSize: 22,
                            )),
                        Icon(inferenceJson!['healthy']
                            ? Icons.check_circle_outline
                            : Icons.local_hospital),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      inferenceJson!['disease_description'] ?? '',
                      style: TextStyle(color: Colors.red[700]),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    MarkdownBody(data: inferenceJson!['care_to_take'] ?? '')
                  ],
                ),
              ),
            ),
      floatingActionButton: loading == true
          ? CircularProgressIndicator()
          : FloatingActionButton(
              onPressed: () => verifyPlant(context),
              child: Icon(Icons.camera_alt),
            ),
    );
  }
}
