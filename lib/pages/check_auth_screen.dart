import 'package:flutter/material.dart';
import 'package:noticias_2023/services/auth_services.dart';
import 'package:provider/provider.dart';

import '../services/services.dart';
import 'pages.dart';

class CheckAuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Obtiene una instancia de la clase AuthService utilizando Provider.
    final authService = Provider.of<AuthService>(context, listen: false);

    // Devuelve un Scaffold con el cuerpo centrado.
    return Scaffold(
      body: Center(
        // Utiliza un FutureBuilder para manejar el resultado de la lectura del token futuro.
        child: FutureBuilder(
          // Lee el token almacenado usando el servicio AuthService.
          future: authService.readToken(),
          // El builder se llama cada vez que cambia el estado del Future.
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            // Verifica si aún no hay datos (por ejemplo, la lectura del token aún no ha finalizado).
            if (!snapshot.hasData) return Text('');

            // Si el token está vacío, redirige a la pantalla de inicio de sesión.
            if (snapshot.data == '') {
              //Si el token es una cadena vacía, se ejecuta una tarea asíncrona utilizando
              // Future.microtask. Future.microtask se utiliza para ejecutar una tarea en el 
              //próximo ciclo de eventos de Flutter, 
              //de manera que se ejecute después de que el árbol de widgets se haya construido.
              Future.microtask(() {
                Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => LoginScreen(),
                        transitionDuration: Duration(seconds: 0)));
              });
            } else {
              // Si hay un token, redirige a la pantalla principal de la aplicación.
              Future.microtask(() {
                Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => HomeScreen(),
                        transitionDuration: Duration(seconds: 0)));
              });
            }

            // Devuelve un contenedor vacío (puede ser cualquier otro widget según sea necesario).
            return Container();
          },
        ),
      ),
    );
  }
}
