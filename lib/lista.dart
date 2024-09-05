import 'package:flutter/material.dart';

class ListaPage extends StatelessWidget {
  const ListaPage({super.key});

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
      body: ListView(
        children: [
          ListTile(
            title: Text("Girassol"),
            subtitle: Text("Ela está saudável"),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://s1.static.brasilescola.uol.com.br/be/2023/09/vista-aproximada-de-um-girassol-em-uma-plantacao-de-girassois.jpg'),
            ),
          ),
          ListTile(
            title: Text("Girassol"),
            subtitle: Text("Ela está saudável"),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://s1.static.brasilescola.uol.com.br/be/2023/09/vista-aproximada-de-um-girassol-em-uma-plantacao-de-girassois.jpg'),
            ),
          ),
          ListTile(
            title: Text("Girassol"),
            subtitle: Text("Ela está saudável"),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://s1.static.brasilescola.uol.com.br/be/2023/09/vista-aproximada-de-um-girassol-em-uma-plantacao-de-girassois.jpg'),
            ),
          ),
          ListTile(
            title: Text("Girassol"),
            subtitle: Text("Ela está saudável"),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://s1.static.brasilescola.uol.com.br/be/2023/09/vista-aproximada-de-um-girassol-em-uma-plantacao-de-girassois.jpg'),
            ),
          ),
          ListTile(
            title: Text("Girassol"),
            subtitle: Text("Ela está saudável"),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://s1.static.brasilescola.uol.com.br/be/2023/09/vista-aproximada-de-um-girassol-em-uma-plantacao-de-girassois.jpg'),
            ),
          ),
          ListTile(
            title: Text("Girassol"),
            subtitle: Text("Ela está saudável"),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://s1.static.brasilescola.uol.com.br/be/2023/09/vista-aproximada-de-um-girassol-em-uma-plantacao-de-girassois.jpg'),
            ),
          ),
          ListTile(
            title: Text("Girassol"),
            subtitle: Text("Ela está saudável"),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://s1.static.brasilescola.uol.com.br/be/2023/09/vista-aproximada-de-um-girassol-em-uma-plantacao-de-girassois.jpg'),
            ),
          ),
          ListTile(
            title: Text("Girassol"),
            subtitle: Text("Ela está saudável"),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://s1.static.brasilescola.uol.com.br/be/2023/09/vista-aproximada-de-um-girassol-em-uma-plantacao-de-girassois.jpg'),
            ),
          ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.camera_alt),
      ),
    );
  }
}
