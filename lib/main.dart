import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:tarea_2_2/types/post.dart';

List<String> img = <String>[];
void main() async {
  var url = Uri.https('jsonplaceholder.typicode.com', '/photos');

  try {
    var jsonPost = await http.get(url);
    if (jsonPost.statusCode == 200) {
      final posts = postFromJson(jsonPost.body);
      for (var post in posts) {
        img.add(post.url);
      }
    } else {
      print('No se pudo conectar con el servidor');
    }
  } catch (e) {
    print('Error: $e');
  }

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App para mostrar imagenes',
      home: cargar_imagenes(),
    );
  }

  cargar_imagenes() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 1.0,
      ),
      itemCount: img.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.network(
            img[index],
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}
