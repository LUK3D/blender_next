import 'package:blender_next/vendor/flutter_simple_multiselect/flutter_simple_multiselect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class BnSelectItem {
  final int id;
  final String name;
  final String? searchTerms;
  final Widget? nameWidget;
  final Widget? icon;

  BnSelectItem(
      {required this.id,
      required this.name,
      this.icon,
      this.nameWidget,
      this.searchTerms});
}

class BnSelect extends StatefulWidget {
  final List<BnSelectItem> items;
  final List<BnSelectItem> initialitems;
  final Function(List<int> ids) onChange;
  final Function(List<int> ids) onRemove;

  const BnSelect(
      {super.key,
      required this.onChange,
      required this.onRemove,
      required this.items,
      this.initialitems = const []});

  @override
  State<BnSelect> createState() => _BnSelectState();
}

class _BnSelectState extends State<BnSelect> {
  late Color lineColor = const Color.fromRGBO(36, 37, 51, 0.04);
  List<BnSelectItem> selectedItems = [];
  List selectedItemsAsync = [];
  Map? singleItem;
  bool isLoading = false;

  Future<List<BnSelectItem>> searchFunction(query) async {
    return widget.items.where((element) {
      return element.name.toLowerCase().contains(query.toLowerCase()) ||
          (element.searchTerms?.toLowerCase().contains(query.toLowerCase()) ??
              false);
    }).toList();
  }

  Future<List<BnSelectItem>> searchFunctionAsync(query) async {
    return Future.delayed(const Duration(seconds: 1), () {
      return widget.items.where((element) {
        return element.name.toLowerCase().contains(query.toLowerCase()) ||
            (element.searchTerms?.toLowerCase().contains(query.toLowerCase()) ??
                false);
      }).toList();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedItems = widget.initialitems;
    selectedItemsAsync = widget.initialitems;
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
        tagBuilder: (context, index) {
          final item = selectedItems[index];
          return SelectTag(
            index: index,
            label: item.name,
            icon: item.icon,
            nameWidget: item.nameWidget,
            searchTerms: item.searchTerms,
            onDeleted: (value) {
              selectedItems.removeAt(index);
              widget.onRemove(
                  List<int>.from(selectedItems.map((e) => e.id).toList()));
              widget.onChange(
                  List<int>.from(selectedItems.map((e) => e.id).toList()));
              setState(() {});
            },
          );
        },
        suggestionBuilder: (context, state, data) {
          var existingIndex =
              selectedItems.indexWhere((element) => element.id == data.id);
          var selectedData = data;
          widget.onChange(
              List<int>.from(selectedItems.map((e) => e.id).toList()));
          return Material(
            elevation: 0,
            child: GestureDetector(
              //HERE
              behavior: HitTestBehavior.translucent,
              onPanDown: (_) {
                if (existingIndex >= 0) {
                  selectedItems.removeAt(existingIndex);
                } else {
                  selectedItems.add(data);
                }

                state.selectAndClose(data);
                widget.onChange(
                    List<int>.from(selectedItems.map((e) => e.id).toList()));
                setState(() {});
              },
              child: ListTile(
                leading: selectedData.icon,
                dense: false,
                selected: existingIndex >= 0,
                trailing: existingIndex >= 0 ? const Icon(Icons.check) : null,
                selectedColor: Colors.white,
                selectedTileColor:
                    Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                title: selectedData.nameWidget ??
                    Text(selectedData.name.toString()),
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
    this.searchTerms,
    this.nameWidget,
    this.icon,
  });

  final String? searchTerms;
  final Widget? nameWidget;
  final Widget? icon;

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
      avatar: icon ??
          Icon(
            LucideIcons.blocks,
            color: Theme.of(context).colorScheme.onSurface,
          ),
      label: Row(
        children: [
          const SizedBox(
            width: 10,
          ),
          nameWidget ?? Text(label),
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
