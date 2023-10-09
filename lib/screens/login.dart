import 'package:flutter/material.dart';
import 'package:productos_app/providers/loguin_provider.dart';
import 'package:productos_app/services/services.dart';
import 'package:productos_app/ui/input_decorations.dart';
import 'package:productos_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthFondo(
        child: SingleChildScrollView(
          // scrollDirection: Axis.horizontal,
          child: Column(
            children: [
              const SizedBox(height: 250),
              CardContainer(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Text('Inicio de Sesion',
                        style: Theme.of(context).textTheme.headlineMedium),
                    const SizedBox(height: 30),
                    ChangeNotifierProvider(
                      create: (context) => LoguinProvider(),
                      child: const _Formm(),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 50),
              const Text('Crear una nueva cuenta'),
              TextButton(
                onPressed: () => Navigator.popAndPushNamed(context, 'registro'),
                child: const Text('Registro'),
              ),
              // SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}

class _Formm extends StatelessWidget {
  const _Formm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoguinProvider>(context);
    return Form(
      key: loginForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInpDecorat(
              hintText: 'correo@electronico.com',
              labelText: 'Correo',
              prefixIcon: Icons.alternate_email_rounded,
            ),
            onChanged: (value) => loginForm.email = value,
            validator: ((value) {
              String pattern =
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

              RegExp regExp = RegExp(pattern);
              return regExp.hasMatch(value ?? '')
                  ? null
                  : 'Eso no es un correo';
            }),
          ),
          const SizedBox(height: 30),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInpDecorat(
              hintText: '*****',
              labelText: 'Constraseña',
              prefixIcon: Icons.lock_outline,
            ),
            onChanged: (value) => loginForm.password = value,
            validator: (value) {
              return (value != null && value.length >= 6)
                  ? null
                  : 'La contraseña debe de ser de 6 digitos';
            },
          ),
          const SizedBox(height: 30),
          MaterialButton(
            onPressed: loginForm.isLoading
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    final authService =
                        Provider.of<AuthService>(context, listen: false);
                    if (!loginForm.esValido()) return;
                    loginForm.isLoading = true;
                    final String? errorMessage = await authService.login(
                        loginForm.email, loginForm.password);
                    if (errorMessage == null) {
                      Navigator.pushReplacementNamed(context, 'home');
                    } else {
                      NotificationsService.showSnackbar(errorMessage);
                      loginForm.isLoading = false;
                    }
                  },
            disabledColor: Colors.grey,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            // elevation: 0,
            color: Colors.deepPurple,
            child: Text(loginForm.isLoading ? 'Espere un momento' : 'Ingresar'),
          ),
        ],
      ),
    );
  }
}
