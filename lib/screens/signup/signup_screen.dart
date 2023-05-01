import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/helpers/validators.dart';
import 'package:store_app/models/user.dart';
import 'package:store_app/models/user_manager.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final UserModel user = UserModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Criar conta")),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(16),
              children: [
                TextFormField(
                  decoration: const InputDecoration(hintText: "Nome Completo"),
                  keyboardType: TextInputType.text,
                  validator: (name) {
                    if (name!.isEmpty) {
                      return "Campo nome é obrigatório";
                    } else if (name.trim().split(" ").length <= 1) {
                      return "Preencha seu nome completo";
                    } else {
                      return null;
                    }
                  },
                  onSaved: (name) => user.name = name!,
                ),
                const SizedBox(height: 16),
                TextFormField(
                    decoration: const InputDecoration(hintText: "E-mail"),
                    keyboardType: TextInputType.emailAddress,
                    validator: (email) {
                      if (email!.isEmpty) {
                        return "Campo e-mail é obrigatório";
                      } else if (!emailValid(email)) {
                        return "E-mail inválido";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (email) => user.email = email!),
                const SizedBox(height: 16),
                TextFormField(
                    decoration: const InputDecoration(hintText: "Senha"),
                    obscureText: true,
                    validator: (password) {
                      if (password!.isEmpty) {
                        return "Campo senha é obrigatório";
                      } else if (password.length < 6) {
                        return "Senha muito curta";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (password) => user.password = password!),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(hintText: "Repita a senha"),
                  obscureText: true,
                  validator: (password) {
                    if (password!.isEmpty) {
                      return "Campo senha é obrigatório";
                    } else if (password.length < 6) {
                      return "Senha muito curta";
                    } else {
                      return null;
                    }
                  },
                  onSaved: (password) => user.confirmPassword = password!,
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 48,
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                          Theme.of(context).primaryColor),
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!
                            .save(); //call onsaved in all textforms

                        if (user.password != user.confirmPassword) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Center(
                                  child: Text("As senhas devem ser iguais!")),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        } else {
                          context.read<UserManager>().signUp(
                              user: user,
                              onFail: (error) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Center(child: Text(error)),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              },
                              onSucess: () {
                                debugPrint("Conta criada com sucesso");
                                //TODO: POP
                              });
                        }
                      }
                    },
                    child: const Text(
                      "Criar Conta",
                      style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 18),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
