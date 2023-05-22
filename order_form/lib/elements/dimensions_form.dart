import 'package:flutter/material.dart';
import 'package:order_form/data/drop_down_lists.dart';
import 'package:order_form/elements/dropdown.dart';
import 'package:order_form/elements/form_text_field.dart';

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
