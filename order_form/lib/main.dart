import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyFormPage(title: 'Flutter Formular'),
    );
  }
}

class MyFormPage extends StatefulWidget {
  const MyFormPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyFormPageState createState() => _MyFormPageState();
}

class _MyFormPageState extends State<MyFormPage> {
  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    keyboardType: TextInputType.text,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      labelText: 'Benutzername',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Bitte einen Benutzernamen eingeben';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'E-Mail',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Passwort',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Lieblingszahl',
                      border: OutlineInputBorder(),
                    ),
                    validator: zahlValidator,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    maxLines: 5,
                    maxLength: 120,
                    decoration: const InputDecoration(
                      hintText: 'Freitext',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                            textStyle: const TextStyle(color: Colors.white)),
                        onPressed: () {
                          // reset() setzt alle Felder wieder auf den Initalwert zurück.
                          _formKey.currentState!.reset();
                        },
                        child: const Text('Löschen'),
                      ),
                      const SizedBox(width: 25),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            textStyle: const TextStyle(color: Colors.white)),
                        onPressed: () {
                          // Wenn alle Validatoren der Felder des Formulars gültig sind.
                          if (_formKey.currentState!.validate()) {
                            print(
                                "Formular ist gültig und kann verarbeitet werden");
                          } else {
                            print("Formular ist nicht gültig");
                          }
                        },
                        child: const Text('Speichern'),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }

  String? zahlValidator(value) {
    var zahl = int.tryParse(value.toString()) ?? 0;
    if (zahl % 2 == 0) {
      return 'Es sind nur ungerade Zahlen erlaubt';
    }
    return null;
  }
}
