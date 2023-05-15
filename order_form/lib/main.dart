import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());
const List<String> items = <String>[
  'passiv',
  'Arbeitsbeginn Baustelle',
  'Pausenbeginn Baustelle',
  'PausenEnde Baustelle',
  'Arbeitsende Baustelle'
];
const List<String> items2 = <String>[
  'wv',
  'HZV',
  'HZR',
  'DAM',
  'KON',
  'TWK',
  'TWW',
  'TWZ',
  'KW',
  'RW',
  'SML',
  'ZU',
  'AB',
  'AU',
  'FO'
];
const List<String> items3 = <String>[
  'wv',
  'SA',
  'MA',
  'TS',
  'TM',
  'WS',
  'WP',
  'FO',
  'PE',
  'GE'
];
const List<String> items4 = <String>[
  'wv',
  'ohne',
  'später',
  'VBL',
  'ABL',
  'GRK',
  'PVC',
  'MA',
  'SA',
  'TS',
  'TM',
  'WS',
  'WP',
  'GE',
  'VBL ende',
  'ABL ende',
  'GRK ende',
  'PVC ende',
  'MA ende',
  'SA ende',
  'TS ende',
  'TM ende',
  'WS ende',
  'WP ende',
  'GE ende'
];
const List<String> items5 = <String>[
  'wv',
  'L',
  'LT',
  'BS',
  'US',
  '15',
  '18',
  '22',
  '28',
  '35',
  '42',
  '48',
  '57',
  '60',
  '76',
  '89',
  '108',
  '110',
  '114',
  '125',
  '140',
  '159',
  '160',
  '168',
  '219',
  '268',
  '323',
  '356'
];
const List<String> items6 = <String>[
  'wv',
  '4',
  '8',
  '13',
  '16',
  '19',
  '20',
  '25',
  '30',
  '32',
  '40',
  '50',
  '60',
  '70',
  '80',
  '90',
  '100',
  '110',
  '120'
];
const List<String> items7 = <String>['wv', 'KI', 'KB'];
const List<String> items8 = <String>[
  'wv',
  'R90 intern 100',
  'R90 intern 150',
  'R90 intern 200',
  'R90 bauseits 100',
  'R90 bauseits 150',
  'R90 bauseits 200',
  'R30 intern 100',
  'R30 intern 150',
  'R30 intern 200',
  'R30 bauseits 100',
  'R30 bauseits 150',
  'R30 bauseits 200',
];
List<DimensionsForm> dimensionForms = [];

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
              padding: const EdgeInsets.all(20),
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
                        backgroundColor: Colors.blue,
                        textStyle: const TextStyle(color: Colors.white)),
                    onPressed: () {
                      // Wenn alle Validatoren der Felder des Formulars gültig sind.
                      if (_formKey.currentState!.validate()) {
                        if (kDebugMode) {
                          if (kDebugMode) {
                            print(
                                "Formular ist gültig und kann verarbeitet werden");
                          }
                        }
                      } else {
                        if (kDebugMode) {
                          print("Formular ist nicht gültig");
                        }
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
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: dimensionForms.length,
                    itemBuilder: (context, i) {
                      return dimensionForms[i];
                    },
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        textStyle: const TextStyle(color: Colors.white)),
                    onPressed: () {
                      setState(() {
                        dimensionForms.add(const DimensionsForm());
                      });
                    },
                    child: const Text('Form hinzufügen'),
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
                            backgroundColor: Colors.blue,
                            textStyle: const TextStyle(color: Colors.white)),
                        onPressed: () {
                          // Wenn alle Validatoren der Felder des Formulars gültig sind.
                          if (_formKey.currentState!.validate()) {
                            if (kDebugMode) {
                              print(
                                  "Formular ist gültig und kann verarbeitet werden");
                            }
                          } else {
                            if (kDebugMode) {
                              print("Formular ist nicht gültig");
                            }
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
    return const SizedBox(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Row(
            children: [
              Flexible(
                child: Padding(
                  padding: EdgeInsets.only(right: 4),
                  child: DropdownButtonExample(listElements: items2),
                ),
              ),
              Flexible(
                child: Padding(
                    padding: EdgeInsets.only(right: 4),
                    child: DropdownButtonExample(listElements: items3)),
              ),
              Flexible(child: DropdownButtonExample(listElements: items4))
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Row(
            children: [
              Flexible(
                  child: Padding(
                padding: EdgeInsets.only(right: 4),
                child: SizedBox(
                    height: 29.0,
                    child: DropdownButtonExample(
                      listElements: items5,
                    )),
              )),
              Flexible(
                child: Padding(
                    padding: EdgeInsets.only(right: 4),
                    child: FormTextField(
                      label: "m STK",
                    )),
              ),
              Flexible(
                child: Padding(
                    padding: EdgeInsets.only(right: 4),
                    child: FormTextField(
                      label: "m A",
                    )),
              ),
              Flexible(
                child: Padding(
                    padding: EdgeInsets.only(right: 4),
                    child: FormTextField(
                      label: "m B",
                    )),
              ),
              Flexible(
                child: Padding(
                    padding: EdgeInsets.only(right: 4),
                    child: FormTextField(
                      label: "m C",
                    )),
              ),
              Flexible(
                  child: FormTextField(
                label: "m D",
              )),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Row(
            children: [
              Flexible(
                child: Padding(
                  padding: EdgeInsets.only(right: 4),
                  child: SizedBox(
                      height: 29.0,
                      child: DropdownButtonExample(
                        listElements: items6,
                      )),
                ),
              ),
              Flexible(
                child: Padding(
                    padding: EdgeInsets.only(right: 4),
                    child: FormTextField(
                      label: "m E",
                    )),
              ),
              Flexible(
                child: Padding(
                    padding: EdgeInsets.only(right: 4),
                    child: FormTextField(
                      label: "m F",
                    )),
              ),
              Flexible(
                child: Padding(
                    padding: EdgeInsets.only(right: 4),
                    child: FormTextField(
                      label: "m R",
                    )),
              ),
              Flexible(
                child: Padding(
                    padding: EdgeInsets.only(right: 4),
                    child: FormTextField(
                      label: "m G",
                    )),
              ),
              Flexible(
                child: Padding(
                    padding: EdgeInsets.only(right: 4),
                    child: FormTextField(
                      label: "m L",
                    )),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Row(
            children: [
              Flexible(
                child: Padding(
                  padding: EdgeInsets.only(right: 4),
                  child: SizedBox(
                      height: 29.0,
                      child: DropdownButtonExample(
                        listElements: items7,
                      )),
                ),
              ),
              Flexible(
                child: Padding(
                    padding: EdgeInsets.only(right: 4),
                    child: FormTextField(
                      label: "BOG",
                    )),
              ),
              Flexible(
                child: Padding(
                    padding: EdgeInsets.only(right: 4),
                    child: FormTextField(
                      label: "STU",
                    )),
              ),
              Flexible(
                child: Padding(
                    padding: EdgeInsets.only(right: 4),
                    child: FormTextField(
                      label: "KON",
                    )),
              ),
              Flexible(
                child: Padding(
                    padding: EdgeInsets.only(right: 4),
                    child: FormTextField(
                      label: "RS",
                    )),
              ),
              Flexible(
                child: Padding(
                    padding: EdgeInsets.only(right: 4),
                    child: FormTextField(
                      label: "KSP",
                    )),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Row(
            children: [
              Flexible(
                child: Padding(
                  padding: EdgeInsets.only(right: 4),
                  child: SizedBox(
                      height: 29.0,
                      child: DropdownButtonExample(
                        listElements: items8,
                      )),
                ),
              ),
              Flexible(
                child: Padding(
                    padding: EdgeInsets.only(right: 4),
                    child: FormTextField(
                      label: "KSS",
                    )),
              ),
              Flexible(
                child: Padding(
                    padding: EdgeInsets.only(right: 4),
                    child: FormTextField(
                      label: "VK",
                    )),
              ),
              Flexible(
                child: Padding(
                    padding: EdgeInsets.only(right: 4),
                    child: FormTextField(
                      label: "FK",
                    )),
              ),
              Flexible(
                child: Padding(
                    padding: EdgeInsets.only(right: 4),
                    child: FormTextField(
                      label: "LT",
                    )),
              ),
              Flexible(
                child: Padding(
                    padding: EdgeInsets.only(right: 4),
                    child: FormTextField(
                      label: "R00",
                    )),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
      ],
    ));
  }
}

class FormTextField extends StatelessWidget {
  final String label;

  const FormTextField({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 29.0,
      child: TextFormField(
        keyboardType: TextInputType.text,
        autocorrect: false,
        style: const TextStyle(fontSize: 10),
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        ),
      ),
    );
  }
}

class DropdownButtonExample extends StatefulWidget {
  final List<String> listElements;
  const DropdownButtonExample({Key? key, required this.listElements})
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
      elevation: 16,
      isExpanded: true,
      style: const TextStyle(color: Colors.blue),
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        isDense: true,
        contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
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
