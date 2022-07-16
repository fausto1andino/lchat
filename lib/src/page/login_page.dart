import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:lchat_rp/src/page/chat_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lchat_rp/src/provider/main_provider.dart';

final TextEditingController _emailController =
    TextEditingController(); //Contenido de la caja de texto
final TextEditingController _passwordController = TextEditingController();

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;
  String? _token; // Logeo
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: Stack(children: [
        Container(
          color: Theme.of(context).primaryColorDark,
          height: size.height * 0.4,
        ),
        SingleChildScrollView(
            child: Center(
                child: SizedBox(
          width: size.width * 0.9,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            SafeArea(child: Container(height: 20.h)),
            inputDecoration(
              size,
              context,
              TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.email),
                      hintText: 'usuario@cinema.com',
                      labelText: 'Correo electrónico')),
            ),
            inputDecoration(
                size,
                context,
                TextField(
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {
                          _obscureText = !_obscureText;
                          setState(() {});
                        },
                        icon: _obscureText
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off)),
                    icon: const Icon(Icons.lock_outline),
                    labelText: 'Contraseña',
                  ),
                )),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: ElevatedButton.icon(
                  onPressed: () async {
                    final mainProvider =
                        Provider.of<MainProvider>(context, listen: false);

                    _token = "usr1";
                    mainProvider.token = _token!;
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChatPage(token: _token!)));
                    setState(() {});
                  },
                  icon: const Icon(Icons.login),
                  label: const Text("Ingresar")),
            ),
          ]),
        )))
      ]),
    ));
  }

  Widget inputDecoration(Size size, BuildContext context, Widget textfield) {
    final sizeinput = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 14.0),
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      width: sizeinput.width * .80,
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(25.0),
          border:
              Border.all(width: 3.0, color: Theme.of(context).highlightColor)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(
                    width: 1.0, color: Theme.of(context).highlightColor))),
      ),
    );
  }
}
