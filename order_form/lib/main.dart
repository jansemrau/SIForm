import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:order_form/data/drop_down_lists.dart';
import 'package:order_form/elements/dimensions_form.dart';
import 'package:order_form/elements/dropdown.dart';
import 'package:order_form/service/network.dart';

void main() => runApp(const MyApp());

double fontSize = 12;
Color backgroundColor = const Color.fromARGB(255, 26, 5, 141);
List dimensionFormValues = [];
List<DimensionsForm> dimensionForms = [];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyFormPage(title: 'Bliso Formular'),
    );
  }
}

class MyFormPage extends StatefulWidget {
  const MyFormPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyFormPage> createState() => _MyFormPageState();
}

class _MyFormPageState extends State<MyFormPage> {
  final projectController = TextEditingController();
  final employeeNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final timingRecordController = TextEditingController();
  final placeController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    projectController.dispose();
    employeeNumberController.dispose();
    passwordController.dispose();
    timingRecordController.dispose();
    placeController.dispose();
    super.dispose();
  }

  _summariseValues() {
    List dimensionFormList = [];
    for (var element in dimensionForms) {
      dimensionFormList.add(element.newDimensionsForm);
    }
    Map returnObject = {
      "project": projectController.text,
      "employeeNumber": employeeNumberController.text,
      "password": passwordController.text,
      "timingRecord": timingRecordController.text,
      "place": placeController.text,
      "dimensionForms": dimensionFormList
    };
    if (kDebugMode) {
      print(returnObject);
    }
    return postRequest(returnObject);
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: backgroundColor,
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
                  SizedBox(
                    height: 30.0,
                    child: TextFormField(
                      controller: projectController,
                      keyboardType: TextInputType.text,
                      autocorrect: false,
                      style: TextStyle(fontSize: fontSize, color: Colors.black),
                      decoration: const InputDecoration(
                        labelText: 'Projekt',
                        labelStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 30.0,
                    child: TextFormField(
                      controller: employeeNumberController,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(fontSize: fontSize, color: Colors.black),
                      decoration: const InputDecoration(
                        labelText: 'Mitarbeiternummer 5-stellig',
                        labelStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      ),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 30.0,
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      style: TextStyle(fontSize: fontSize, color: Colors.black),
                      decoration: const InputDecoration(
                        labelText: 'Passwort',
                        labelStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Zeiterfassung",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: fontSize),
                    ),
                  ),
                  DropdownButtonExample(
                      listElements: items,
                      dropdownValue: timingRecordController),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: backgroundColor,
                        textStyle: const TextStyle(color: Colors.white)),
                    onPressed: () async {
                      var response = await _summariseValues();
                      if (context.mounted) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              if (response.statusCode != 200) {
                                return AlertDialog(
                                    title: const Text("Network error"),
                                    content:
                                        const Text("No Internetconnection"),
                                    actions: [
                                      TextButton(
                                        child: const Text("OK"),
                                        onPressed: () {
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop('dialog');
                                        },
                                      )
                                    ]);
                              } else {
                                return AlertDialog(
                                    title: const Text("Formular versendet"),
                                    content: const Text(
                                        "Formular erfolgreich versendet"),
                                    actions: [
                                      TextButton(
                                        child: const Text("OK"),
                                        onPressed: () {
                                          Navigator.pushNamedAndRemoveUntil(
                                              context, '/', (_) => false);
                                          setState(() {
                                            dimensionForms = [];
                                          });
                                        },
                                      )
                                    ]);
                              }
                            });
                      }
                    },
                    child: const Text('Speichern'),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 30.0,
                    child: TextFormField(
                      controller: placeController,
                      keyboardType: TextInputType.number,
                      style: TextStyle(fontSize: fontSize, color: Colors.black),
                      decoration: const InputDecoration(
                        labelText: 'Raum / Ort',
                        labelStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: dimensionForms.length,
                    itemBuilder: (context, i) {
                      return dimensionForms[i];
                    },
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: backgroundColor,
                        textStyle: const TextStyle(color: Colors.white)),
                    onPressed: () {
                      setState(() {
                        Map newDimensionsForm = {};
                        dimensionFormValues.add(newDimensionsForm);
                        dimensionForms.add(DimensionsForm(
                            newDimensionsForm: newDimensionsForm));
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
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/', (_) => false);
                          setState(() {
                            dimensionForms = [];
                          });
                        },
                        child: const Text('Löschen'),
                      ),
                      const SizedBox(width: 25),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: backgroundColor,
                            textStyle: const TextStyle(color: Colors.white)),
                        onPressed: () {
                          _summariseValues();
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
}
