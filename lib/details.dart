import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class DetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: Text(args['plant_name']),
        actions: [
          IconButton(
            onPressed: () async {
              var args2 = Map<String, dynamic>.from(args);
              args2.remove('image');
              await FirebaseFirestore.instance
                  .collection('inferences')
                  .add(args2);
            },
            icon: Icon(Icons.bookmark_add_outlined),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 5 / 4,
                child: Image.file(
                  args['image'],
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(args['plant_name'],
                      style: TextStyle(
                        fontSize: 22,
                      )),
                  Icon(args['healthy']
                      ? Icons.check_circle_outline
                      : Icons.local_hospital),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                args['disease_description'] ?? '',
                style: TextStyle(color: Colors.red[700]),
              ),
              SizedBox(
                height: 10,
              ),
              MarkdownBody(data: args['care_to_take'] ?? '')
            ],
          ),
        ),
      ),
    );
  }
}