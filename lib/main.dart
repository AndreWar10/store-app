import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/models/user_manager.dart';
import 'package:store_app/screens/base/base_screen.dart';
import 'package:store_app/screens/signup/signup_screen.dart';

import 'firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());

  //Pegar dados
  // DocumentSnapshot doc = await FirebaseFirestore.instance.collection("pedidos").doc("0001").get();
  // print(doc["preco"]);

  //Escutar mudancas no Firebase em tempo real
  // FirebaseFirestore.instance.collection("pedidos").doc("0001").snapshots().listen((doc) {
  //   print(doc);
  // });

  //Todos documentos da colecao pedidos
  // QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("pedidos").get();
  // for (DocumentSnapshot doc in snapshot.docs) {
  //   print(snapshot);
  // }

  //Escrever dados
  //FirebaseFirestore.instance.collection("pedidos").add({"preco": "199.99"});
  //FirebaseFirestore.instance.collection("pedidos").doc("0001").set({"preco": "300"}); //Acessa / Cria documento da colecao e cria os dados.
  //FirebaseFirestore.instance.doc("pedidos/0001").set({"preco": "300"}); //Pode ser feito assim, para facilitar nomeclatura.
  //FirebaseFirestore.instance.collection("pedidos").doc("0001").update({"preco": "300"}); //Atualiza os dados do documento.
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserManager(),
      child: MaterialApp(
        title: 'Store App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primaryColor: const Color.fromARGB(255, 4, 125, 141),
          appBarTheme: const AppBarTheme(
            elevation: 0,
            centerTitle: true,
            color:Color.fromARGB(255, 4, 125, 141),
          ),
          scaffoldBackgroundColor: const Color.fromARGB(255, 4, 125, 141),
        ),
        initialRoute: "/base",
       onGenerateRoute: (settings) {
         switch(settings.name){
          case "/base" : return MaterialPageRoute(builder: (_)=> BaseScreen());
          case "/signup" : return MaterialPageRoute(builder: (_)=> SignUpScreen());
          default: return MaterialPageRoute(builder: (_)=> BaseScreen());
         }
       },        //BaseScreen(),
      ),
    );
  }
}
