import 'package:blender_next/vendor/flutter_simple_multiselect/flutter_simple_multiselect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class BnSelect extends StatefulWidget {
  const BnSelect({super.key});

  @override
  State<BnSelect> createState() => _BnSelectState();
}

class _BnSelectState extends State<BnSelect> {
  late Color lineColor = const Color.fromRGBO(36, 37, 51, 0.04);
  List selectedItems = [];
  List selectedItemsAsync = [];
  Map? singleItem;
  bool isLoading = false;

  List<Map<String, dynamic>> testData = [
    {"uuid": 1, "name": "Cycles Render Engine"},
    {"uuid": 2, "name": "FBX format"},
    {"uuid": 3, "name": "glTF"},
    {"uuid": 4, "name": "Node wrangler"},
    {"uuid": 5, "name": "OCD"},
    {"uuid": 6, "name": "Rigify"},
    {"uuid": 7, "name": "Scalable Vector Graphic"},
    {"uuid": 8, "name": "UV Layout"}
  ];

  Future<List<Map<String, dynamic>>> searchFunction(query) async {
    return testData.where((element) {
      return element["name"].toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  Future<List<Map<String, dynamic>>> searchFunctionAsync(query) async {
    return Future.delayed(const Duration(seconds: 1), () {
      return testData.where((element) {
        return element["name"].toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: SingleChildScrollView(
        child: _staticData(),
      ),
    );
  }

  Widget _staticData() {
    return FlutterMultiselect(
        autofocus: false,
        padding:
            const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
        enableBorderColor: lineColor,
        focusedBorderColor: lineColor,
        borderRadius: 5,
        borderSize: 4,
        resetTextOnSubmitted: true,
        minTextFieldWidth: 300,
        suggestionsBoxMaxHeight: 300,
        length: selectedItems.length,
        tagBuilder: (context, index) => SelectTag(
              index: index,
              label: selectedItems[index]["name"],
              onDeleted: (value) {
                selectedItems.removeAt(index);
                setState(() {});
              },
            ),
        suggestionBuilder: (context, state, data) {
          var existingIndex = selectedItems
              .indexWhere((element) => element["uuid"] == data["uuid"]);
          var selectedData = data;
          return Material(
            elevation: 0,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onPanDown: (_) {
                if (existingIndex >= 0) {
                  selectedItems.removeAt(existingIndex);
                } else {
                  selectedItems.add(data);
                }

                state.selectAndClose(data);
                setState(() {});
              },
              child: ListTile(
                dense: false,
                selected: existingIndex >= 0,
                trailing: existingIndex >= 0 ? const Icon(Icons.check) : null,
                selectedColor: Colors.white,
                selectedTileColor: Theme.of(context).colorScheme.secondary,
                title: Text(selectedData["name"].toString()),
              ),
            ),
          );
        },
        // suggestionsBoxElevation: 10,
        suggestionsBoxRadius: 12,
        findSuggestions: (String query) async {
          setState(() {
            isLoading = true;
          });
          var data = await searchFunction(query);
          setState(() {
            isLoading = false;
          });
          return data;
        });
  }
}

class SelectTag extends StatelessWidget {
  const SelectTag({
    super.key,
    required this.label,
    required this.onDeleted,
    required this.index,
  });

  final String label;
  final ValueChanged<int> onDeleted;
  final int index;
  final Color darkAlias6 = const Color.fromRGBO(36, 37, 51, 0.06);

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
            color: Theme.of(context).canvasColor,
          )),
      labelPadding: const EdgeInsets.only(left: 8.0),
      label: Row(
        children: [
          Icon(
            LucideIcons.blocks,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(label),
        ],
      ),
      deleteIcon: const Icon(
        Icons.close,
        size: 18,
      ),
      onDeleted: () {
        onDeleted(index);
      },
    );
  }
}
