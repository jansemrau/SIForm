import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());
const List<String> items = <String>['One', 'Two', 'Three', 'Four'];
const List<String> items2 = <String>['HZV', 'HZR', 'DAM', 'KON'];
const List<String> items3 = <String>['SA', 'MA', 'TS', 'KON'];
const List<String> items4 = <String>['ohne', 'später', 'VBL', 'ABL'];
const List<String> items5 = <String>['L', 'LT', 'BS', 'LIS'];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyFormPage(title: 'Bliso Formular'),
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
                      labelText: 'Projekt',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Bitte Projektnummer eingeben';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Mitarbeiternummer 5-stellig',
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
                  const Text(
                    "Zeiterfassung",
                    textAlign: TextAlign.left,
                  ),
                  const DropdownButtonExample(
                    listElements: items,
                  ),
                  const SizedBox(height: 20),
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
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Raum / Ort',
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
                  const DimensionsForm(),
                  const DimensionsForm(),
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

class DimensionsForm extends StatefulWidget {
  const DimensionsForm({super.key});

  @override
  State<DimensionsForm> createState() => _DimensionsFormState();
}

class _DimensionsFormState extends State<DimensionsForm> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        const Row(
          children: [
            Flexible(
              child: DropdownButtonExample(listElements: items2),
            ),
            Flexible(child: DropdownButtonExample(listElements: items3)),
            Flexible(child: DropdownButtonExample(listElements: items4))
          ],
        ),
        Row(
          children: [
            const Flexible(
                child: DropdownButtonExample(
              listElements: items5,
            )),
            Flexible(
              child: TextFormField(
                keyboardType: TextInputType.text,
                autocorrect: false,
                decoration: const InputDecoration(
                  labelText: 'Projekt',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Bitte Projektnummer eingeben';
                  }
                  return null;
                },
              ),
            ),
            Flexible(
              child: TextFormField(
                keyboardType: TextInputType.text,
                autocorrect: false,
                decoration: const InputDecoration(
                  labelText: 'Projekt',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Bitte Projektnummer eingeben';
                  }
                  return null;
                },
              ),
            ),
            Flexible(
              // wrap your Column in Expanded
              child: TextFormField(
                keyboardType: TextInputType.text,
                autocorrect: false,
                decoration: const InputDecoration(
                  labelText: 'Projekt',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Bitte Projektnummer eingeben';
                  }
                  return null;
                },
              ),
            ),
            Flexible(
              // wrap your Column in Expanded
              child: TextFormField(
                keyboardType: TextInputType.text,
                autocorrect: false,
                decoration: const InputDecoration(
                  labelText: 'Projekt',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Bitte Projektnummer eingeben';
                  }
                  return null;
                },
              ),
            ),
            Flexible(
              // wrap your Column in Expanded
              child: TextFormField(
                keyboardType: TextInputType.text,
                autocorrect: false,
                decoration: const InputDecoration(
                  labelText: 'Projekt',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Bitte Projektnummer eingeben';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ],
    ));
  }
}

class DropdownButtonExample extends StatefulWidget {
  final List<String> listElements;
  const DropdownButtonExample(
      {Key? key, required List<String> this.listElements})
      : super(key: key);
  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  @override
  Widget build(BuildContext context) {
    String dropdownValue = widget.listElements.first;
    return DropdownButtonFormField<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      isExpanded: true,
      style: const TextStyle(color: Colors.blue),
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: widget.listElements.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
