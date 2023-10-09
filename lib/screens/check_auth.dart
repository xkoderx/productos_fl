import 'package:flutter/material.dart';
import 'package:productos_app/screens/home.dart';
import 'package:productos_app/screens/login.dart';
import 'package:productos_app/services/services.dart';
import 'package:provider/provider.dart';

class CheckAuthScreen extends StatelessWidget {
  const CheckAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: authService.readToken(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Text('Espere');
            if (snapshot.data == '') {
              // Navigator.of(context).pushReplacementNamed('login')
              Future.microtask(
                () => {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => LoginScreen(),
                      transitionDuration: const Duration(seconds: 0),
                    ),
                  ),
                },
              );
            } else {
              // Navigator.of(context).pushReplacementNamed('login')
              Future.microtask(
                () => {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => HomeScreen(),
                      transitionDuration: const Duration(seconds: 0),
                    ),
                  ),
                },
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
