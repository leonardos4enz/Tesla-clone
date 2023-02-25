import 'package:flutter/material.dart';
import 'package:saenz/screens/explore_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool hidePassword = false;

  void updateHidePassword() {
    setState(() {
      hidePassword = !hidePassword;
    });
  }

  cambiarOjo() {
    setState(() {
      hidePassword = !hidePassword;
    });
  }

  // void _resetValue() {
  //   setState(() {
  //     value = 100;
  //   });
  //   _saveValue();
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Text(
                      "TESLA",
                      style: TextStyle(
                        fontFamily: 'Tesla',
                        letterSpacing: 7,
                        fontSize: 25,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.public),
                    Text(
                      " es-ES",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                espacio(50),
                const Text("Iniciar sesión",
                    style: TextStyle(fontSize: 40, fontFamily: 'SanFranciscoPro', fontWeight: FontWeight.bold)),
                espacio(50),
                textoDescriptivo("Correo electrónico"),
                espacio(5),
                contenedorTexto(_emailController, 0, hidePassword),
                espacio(20),
                textoDescriptivo("Contraseña"),
                espacio(5),
                contenedorTexto(_passwordController, 1, hidePassword),
                espacio(50),
                loginButton(context, _emailController, _passwordController),
                espacio(30),
                const Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "¿Tienes problemas para iniciar sesión?",
                    style: TextStyle(
                      shadows: [Shadow(color: Color.fromARGB(255, 128, 128, 128), offset: Offset(0, -7))],
                      fontFamily: 'SanFranciscoPro',
                      decoration: TextDecoration.underline,
                      // letterSpacing: 0.8,
                      color: Colors.transparent, decorationColor: Color.fromARGB(255, 128, 128, 128),
                      decorationThickness: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget espacio(double espacio) {
    return SizedBox(
      height: espacio,
    );
  }

  Row textoDescriptivo(String texto) {
    return Row(
      children: [
        Text('$texto ',
            style: const TextStyle(
                fontSize: 18, fontFamily: 'SanFranciscoPro', color: Color.fromARGB(255, 128, 128, 128))),
        const Icon(
          Icons.info_outline,
          size: 18,
          color: Color.fromARGB(255, 128, 128, 128),
        ),
      ],
    );
  }

  SizedBox contenedorTexto(TextEditingController controller, int type, bool a) {
    return SizedBox(
      height: 50,
      child: CajaText2(
        controller: controller,
        type: type,
        hidePassword: a,
        updateHidePassword: cambiarOjo,
      ),
    );
  }
}

class CajaText2 extends StatefulWidget {
  final TextEditingController controller;
  final int type;
  final bool hidePassword;
  final void Function() updateHidePassword;

  const CajaText2({
    required this.hidePassword,
    required this.controller,
    required this.type,
    required this.updateHidePassword,
    Key? key,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CajaText2State createState() => _CajaText2State();
}

class _CajaText2State extends State<CajaText2> {
  @override
  Widget build(BuildContext context) {
    bool isEmailValid = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(widget.controller.text);

    return TextField(
      obscureText: widget.type == 0 ? false : !widget.hidePassword,
      keyboardType: widget.type == 0 ? TextInputType.emailAddress : TextInputType.visiblePassword,
      controller: widget.controller,
      style:
          const TextStyle(fontFamily: 'SanFranciscoPro', fontSize: 17, fontWeight: FontWeight.bold, letterSpacing: 0.8),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          // borderSide: BorderSide(color: isEmailValid ? Colors.grey.shade400 : Colors.red),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        // hintText: type == 0 ? 'Correo electrónico' : 'Contraseña',
        suffixIcon: widget.type == 0
            ? Icon(
                isEmailValid
                    ? widget.controller.text.isNotEmpty
                        ? Icons.check
                        : null
                    : widget.controller.text.isNotEmpty
                        ? Icons.close
                        : null,
                color: isEmailValid ? Colors.green : Colors.red)
            : IconButton(
                onPressed: () {
                  widget.updateHidePassword();
                },
                icon: Icon(widget.hidePassword ? Icons.visibility : Icons.visibility_off),
              ),
      ),
      onChanged: (text) {
        setState(() {});
      },
    );
  }
}

Widget loginButton(
    BuildContext context, TextEditingController emailController, TextEditingController passwordController) {
  bool isEmailValid = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(emailController.text);

  return Container(
    width: MediaQuery.of(context).size.width * 0.85,
    constraints: const BoxConstraints(
      maxWidth: 500,
    ),
    height: 40,
    child: MaterialButton(
      splashColor: Colors.transparent,
      color: emailController.text.isNotEmpty && passwordController.text.isNotEmpty && isEmailValid
          ? const Color.fromARGB(255, 61, 123, 255)
          : const Color.fromARGB(255, 174, 200, 255),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      onPressed: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 500),
            pageBuilder: (context, animation, secondaryAnimation) => const ExploreScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              var begin = const Offset(0.0, 1.0);
              var end = Offset.zero;
              var curve = Curves.ease;

              var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
          ),
        );
      },
      child: const Text(
        "Siguiente",
        style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'SanFranciscoPro'),
      ),
    ),
  );
}
