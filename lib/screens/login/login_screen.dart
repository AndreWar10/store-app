import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/helpers/validators.dart';
import 'package:store_app/models/user.dart';
import 'package:store_app/models/user_manager.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Entrar"),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacementNamed("/signup");
            },
            child: const Center(
              child: Padding(
                padding: EdgeInsets.only(right: 16),
                child: Text(
                  "Criar conta",
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
              key: formKey,
              child: Consumer<UserManager>(
                builder: (_, userManager, child) {
                  return ListView(
                    padding: const EdgeInsets.all(16),
                    shrinkWrap: true, //menor altura possivel
                    children: [
                      TextFormField(
                        controller: emailController,
                        enabled: !userManager.loading,
                        decoration: const InputDecoration(hintText: "E-mail"),
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        validator: (email) {
                          if(email!.isEmpty){
                            return "Campo e-mail é obrigatório";
                          }
                          else if (!emailValid(email)) {
                            return "E-mail inválido";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: passwordController,
                        enabled: !userManager.loading,
                        decoration: const InputDecoration(hintText: "Senha"),
                        obscureText: true,
                        autocorrect: false,
                        validator: (pass) {
                          if (pass!.isEmpty || pass.length < 6) {
                            return "Senha inválida";
                          }
                          return null;
                        },
                      ),
                      child!,
                      SizedBox(
                        height: 48,
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                userManager.loading
                                    ? Theme.of(context)
                                        .primaryColor
                                        .withAlpha(100)
                                    : Theme.of(context).primaryColor),
                          ),
                          onPressed: userManager.loading
                              ? null
                              : () {
                                  if (formKey.currentState!.validate()) {
                                    userManager.signIn(
                                        user: UserModel(
                                            email: emailController.text,
                                            password: passwordController.text),
                                        onFail: (error) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content:
                                                  Center(child: Text(error)),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                        },
                                        onSucess: () {
                                          // TODO: FECHAR TELA DE LOGIN
                                        });
                                  }
                                },
                          child: userManager.loading
                              ? const CircularProgressIndicator(
                                  valueColor:
                                      AlwaysStoppedAnimation(Colors.white),
                                )
                              : const Text(
                                  "Entrar",
                                  style: TextStyle(
                                      color: Color(0xFFFFFFFF), fontSize: 18),
                                ),
                        ),
                      )
                    ],
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 12.0, bottom: 24.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {},
                      child: const Text("Esqueci minha senha"),
                    ),
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
