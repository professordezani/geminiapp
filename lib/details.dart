import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
              'https://s1.static.brasilescola.uol.com.br/be/2023/09/vista-aproximada-de-um-girassol-em-uma-plantacao-de-girassois.jpg'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Nome da Planta"),
              Icon(Icons.check),
            ],
          ),
          Text("Cuidados com a planta"),
        ],
      ),
    );
  }
}
