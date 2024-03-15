import 'package:flutter/material.dart';

const List<String> list = <String>['Client', 'Seller'];

class MyDropDown extends StatefulWidget {
  const MyDropDown({Key? key}) : super(key: key);

  @override
  State<MyDropDown> createState() => _MyDropDownState();
}

class _MyDropDownState extends State<MyDropDown> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(50, 0, 50, 0),
      color: const Color.fromARGB(255, 236, 236, 236),
      child: DropdownMenu<String>(
        initialSelection: list.first,
        onSelected: (String? value) {
          setState(() {
            dropdownValue = value!;
          });
        },
        expandedInsets: const EdgeInsets.all(0),
        dropdownMenuEntries:
            list.map<DropdownMenuEntry<String>>((String value) {
          return DropdownMenuEntry(
            value: value,
            label: value,
          );
        }).toList(),
      ),
    );
  }
}
