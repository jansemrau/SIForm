import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';

void main() => runApp(const MyApp());

double fontSize = 12;
Color backgroundColor = Color.fromARGB(255, 26, 5, 141);
List dimensionFormValues = [];
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
      home: const MyFormPage(title: 'Bliso Formular'),
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
    // Clean up the controller when the widget is disposed.
    projectController.dispose();
    employeeNumberController.dispose();
    passwordController.dispose();
    timingRecordController.dispose();
    placeController.dispose();
    super.dispose();
  }

  Future<http.Response> postRequest(data) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.mobile &&
        connectivityResult != ConnectivityResult.wifi) {
      AlertDialog(
          title: const Text("Network error"),
          content: const Text("No Internetconnection"),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () {},
            )
          ]);
      throw ("Error");
    } else {
      var url = Uri.parse("https://www.mygrab.at/out.php");

      //encode Map to JSON
      var body = json.encode(data);

      var response = await http.post(url,
          headers: {"Content-Type": "application/json"}, body: body);
      if (kDebugMode) {
        print("${response.statusCode}");
        print(response.body);
      }
      return response;
    }
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
    postRequest(returnObject);
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
                      // validator: (value) {
                      //   if (value!.isEmpty) {
                      //     return 'Bitte Projektnummer eingeben';
                      //   }
                      //   return null;
                      // },
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
                    onPressed: () {
                      _summariseValues();
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

class DimensionsForm extends StatefulWidget {
  Map newDimensionsForm;
  DimensionsForm({super.key, required this.newDimensionsForm});

  @override
  State<DimensionsForm> createState() => _DimensionsFormState();
}

class _DimensionsFormState extends State<DimensionsForm> {
  final dropdown1Controller = TextEditingController();
  final dropdown2Controller = TextEditingController();
  final dropdown3Controller = TextEditingController();

  final dropdown4Controller = TextEditingController();
  final mSTKController = TextEditingController();
  final mAController = TextEditingController();
  final mBController = TextEditingController();
  final mCController = TextEditingController();
  final mDController = TextEditingController();

  final dropdown5Controller = TextEditingController();
  final mEController = TextEditingController();
  final mFController = TextEditingController();
  final mRController = TextEditingController();
  final mGController = TextEditingController();
  final mLController = TextEditingController();

  final dropdown6Controller = TextEditingController();
  final bOGController = TextEditingController();
  final sTUController = TextEditingController();
  final kONController = TextEditingController();
  final rSController = TextEditingController();
  final kSPController = TextEditingController();

  final dropdown7Controller = TextEditingController();
  final kSSController = TextEditingController();
  final vKController = TextEditingController();
  final fKController = TextEditingController();
  final lTController = TextEditingController();
  final r00Controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    dropdown1Controller.addListener(_updateForm);
    dropdown2Controller.addListener(_updateForm);
    dropdown3Controller.addListener(_updateForm);

    dropdown4Controller.addListener(_updateForm);
    mSTKController.addListener(_updateForm);
    mAController.addListener(_updateForm);
    mBController.addListener(_updateForm);
    mCController.addListener(_updateForm);
    mDController.addListener(_updateForm);

    dropdown5Controller.addListener(_updateForm);
    mEController.addListener(_updateForm);
    mFController.addListener(_updateForm);
    mRController.addListener(_updateForm);
    mGController.addListener(_updateForm);
    mLController.addListener(_updateForm);

    dropdown6Controller.addListener(_updateForm);
    bOGController.addListener(_updateForm);
    sTUController.addListener(_updateForm);
    kONController.addListener(_updateForm);
    rSController.addListener(_updateForm);
    kSPController.addListener(_updateForm);

    dropdown7Controller.addListener(_updateForm);
    kSSController.addListener(_updateForm);
    vKController.addListener(_updateForm);
    fKController.addListener(_updateForm);
    lTController.addListener(_updateForm);
    r00Controller.addListener(_updateForm);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    super.dispose();
    dropdown1Controller.dispose();
    dropdown2Controller.dispose();
    dropdown3Controller.dispose();

    dropdown4Controller.dispose();
    mSTKController.dispose();
    mAController.dispose();
    mBController.dispose();
    mCController.dispose();
    mDController.dispose();

    dropdown5Controller.dispose();
    mEController.dispose();
    mFController.dispose();
    mRController.dispose();
    mGController.dispose();
    mLController.dispose();

    dropdown6Controller.dispose();
    bOGController.dispose();
    sTUController.dispose();
    kONController.dispose();
    rSController.dispose();
    kSPController.dispose();

    dropdown7Controller.dispose();
    kSSController.dispose();
    vKController.dispose();
    fKController.dispose();
    lTController.dispose();
    r00Controller.dispose();
  }

  _updateForm() {
    widget.newDimensionsForm = {
      'd1': dropdown1Controller.text,
      'd2': dropdown2Controller.text,
      'd3': dropdown3Controller.text,
      'd4': dropdown4Controller.text,
      'mSTK': mSTKController.text,
      'mA': mAController.text,
      'mB': mBController.text,
      'mC': mCController.text,
      'mD': mDController.text,
      'd5': dropdown5Controller.text,
      'mE': mEController.text,
      'mF': mFController.text,
      'mR': mRController.text,
      'mG': mGController.text,
      'mL': mLController.text,
      'd6': dropdown6Controller.text,
      'bOG': bOGController.text,
      'sTU': sTUController.text,
      'kON': kONController.text,
      'rS': rSController.text,
      'kSP': kSPController.text,
      'd7': dropdown7Controller.text,
      'kSS': kSSController.text,
      'vK': vKController.text,
      'fK': fKController.text,
      'lT': lTController.text,
      'r00': r00Controller.text
    };
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Massen",
            textAlign: TextAlign.left,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: DropdownButtonExample(
                      listElements: items2, dropdownValue: dropdown1Controller),
                ),
              ),
              Flexible(
                child: Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: DropdownButtonExample(
                        listElements: items3,
                        dropdownValue: dropdown2Controller)),
              ),
              Flexible(
                  child: DropdownButtonExample(
                      listElements: items4, dropdownValue: dropdown3Controller))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            children: [
              Flexible(
                  child: Padding(
                padding: const EdgeInsets.only(right: 4),
                child: SizedBox(
                    height: 30.0,
                    child: DropdownButtonExample(
                        listElements: items5,
                        dropdownValue: dropdown4Controller)),
              )),
              Flexible(
                child: Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: FormTextField(
                        label: "m STK", textController: mSTKController)),
              ),
              Flexible(
                child: Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: FormTextField(
                        label: "m A", textController: mAController)),
              ),
              Flexible(
                child: Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: FormTextField(
                        label: "m B", textController: mBController)),
              ),
              Flexible(
                child: Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: FormTextField(
                        label: "m C", textController: mCController)),
              ),
              Flexible(
                  child: FormTextField(
                      label: "m D", textController: mDController)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: SizedBox(
                      height: 30.0,
                      child: DropdownButtonExample(
                          listElements: items6,
                          dropdownValue: dropdown5Controller)),
                ),
              ),
              Flexible(
                child: Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: FormTextField(
                        label: "m E", textController: mEController)),
              ),
              Flexible(
                child: Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: FormTextField(
                        label: "m F", textController: mFController)),
              ),
              Flexible(
                child: Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: FormTextField(
                        label: "m R", textController: mRController)),
              ),
              Flexible(
                child: Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: FormTextField(
                        label: "m G", textController: mGController)),
              ),
              Flexible(
                child: Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: FormTextField(
                        label: "m L", textController: mLController)),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: SizedBox(
                      height: 30.0,
                      child: DropdownButtonExample(
                          listElements: items7,
                          dropdownValue: dropdown6Controller)),
                ),
              ),
              Flexible(
                child: Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: FormTextField(
                        label: "BOG", textController: bOGController)),
              ),
              Flexible(
                child: Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: FormTextField(
                        label: "STU", textController: sTUController)),
              ),
              Flexible(
                child: Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: FormTextField(
                        label: "KON", textController: kONController)),
              ),
              Flexible(
                child: Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: FormTextField(
                        label: "RS", textController: rSController)),
              ),
              Flexible(
                child: Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: FormTextField(
                        label: "KSP", textController: kSPController)),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: SizedBox(
                      height: 30.0,
                      child: DropdownButtonExample(
                          listElements: items8,
                          dropdownValue: dropdown7Controller)),
                ),
              ),
              Flexible(
                child: Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: FormTextField(
                        label: "KSS", textController: kSSController)),
              ),
              Flexible(
                child: Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: FormTextField(
                        label: "VK", textController: vKController)),
              ),
              Flexible(
                child: Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: FormTextField(
                        label: "FK", textController: fKController)),
              ),
              Flexible(
                child: Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: FormTextField(
                        label: "LT", textController: lTController)),
              ),
              Flexible(
                child: Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: FormTextField(
                        label: "R00", textController: r00Controller)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    ));
  }
}

class FormTextField extends StatelessWidget {
  final String label;
  final TextEditingController textController;

  const FormTextField(
      {Key? key, required this.label, required this.textController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30.0,
      child: TextFormField(
        controller: textController,
        keyboardType: TextInputType.text,
        autocorrect: false,
        style: const TextStyle(fontSize: 10, color: Colors.black),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.black),
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        ),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
        ],
      ),
    );
  }
}

class DropdownButtonExample extends StatefulWidget {
  final List<String> listElements;
  TextEditingController dropdownValue;
  DropdownButtonExample(
      {Key? key, required this.listElements, required this.dropdownValue})
      : super(key: key);
  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  @override
  Widget build(BuildContext context) {
    widget.dropdownValue.text = widget.listElements.first;
    return DropdownButtonFormField<String>(
      value: widget.dropdownValue.text,
      elevation: 16,
      isExpanded: true,
      style: TextStyle(fontSize: fontSize, color: Colors.black),
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        isDense: true,
        contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          widget.dropdownValue.text = value!;
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
