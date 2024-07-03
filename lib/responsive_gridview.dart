library responsive_gridview;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ResponsiveGridView extends StatefulWidget {
  const ResponsiveGridView(
      {super.key,
      this.column = 1,
      required this.children,
      this.verticalSpacing = 12,
      this.horizontalSpacing = 12,
      this.padding = const EdgeInsets.all(12),
      this.crossAxisAlignment = CrossAxisAlignment.start});

  final int column;
  final List<Widget> children;
  final double verticalSpacing;
  final double horizontalSpacing;
  final EdgeInsets padding;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  _ResponsiveGridViewState createState() => _ResponsiveGridViewState();
}

class _ResponsiveGridViewState extends State<ResponsiveGridView> {
  int rows = 0;
  late List<List<Widget>> rowItem;
  late List<GlobalKey> rowKey;

  @override
  void initState() {
    assert(widget.column >= 1, "column should be at least 1.");
    assert(widget.verticalSpacing >= 0, "mainAxisSpacing should be positive.");
    calculateRow();
    rowItem = List.generate(rows, (i) => []);
    rowKey = List.generate(rows, (i) => GlobalKey());
    super.initState();
  }

  @override
  void didUpdateWidget(prev) {
    if (!listEquals(prev.children, widget.children) ||
        prev.column != widget.column ||
        prev.verticalSpacing != widget.verticalSpacing ||
        prev.crossAxisAlignment != widget.crossAxisAlignment) {
      setState(() {
        calculateRow();
        rowItem = List.generate(rows, (i) => []);
        rowKey = List.generate(rows, (i) => GlobalKey());
      });
    }
    super.didUpdateWidget(prev);
  }

  void calculateRow() {
    rows = widget.children.length ~/ widget.column;
    if (widget.children.length % widget.column > 0) {
      rows++;
    }
  }

  @override
  Widget build(BuildContext context) {
    try {
      rowItem = _generateChunks(
          widget.children.map((e) {
            return Expanded(
                child: Padding(
              padding: widget.column > 1
                  ? EdgeInsets.only(
                      left: widget.children.indexOf(e) % widget.column > 1
                          ? widget.horizontalSpacing
                          : 0,
                      right: widget.children.indexOf(e) % widget.column == 0
                          ? widget.horizontalSpacing
                          : 0,
                    )
                  : EdgeInsets.zero,
              child: e,
            ));
          }).toList(),
          widget.column,
          defaultValue: Expanded(child: Container()));

      final List<Widget> row = widget.verticalSpacing == 0
          ? List.generate(
              rows,
              (i) => Row(
                    // key: this.rowKey[i],
                    crossAxisAlignment: widget.crossAxisAlignment,
                    // key: this.rowKey[i],
                    children: rowItem[i],
                  ))
          : List.generate(
              rows + (rows - 1),
              (i) => i.isEven
                  ? Row(
                      // key: this.rowKey[(i / 2).floor()],
                      crossAxisAlignment: widget.crossAxisAlignment,
                      // key: this.rowKey[(i / 2).floor()],
                      children: rowItem[(i / 2).floor()],
                    )
                  : SizedBox(
                      height: widget.verticalSpacing,
                    ));

      return Padding(
        padding: widget.padding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: row,
        ),
      );
    } catch (e) {
      return Padding(
        padding: widget.padding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widget.children,
        ),
      );
    }
  }
}

List<List<T>> _generateChunks<T>(List<T> inList, int chunkSize,
    {dynamic defaultValue}) {
  List<List<T>> outList = [];
  List<T> tmpList = [];
  int counter = 0;

  for (int current = 0; current < inList.length; current++) {
    if (counter != chunkSize) {
      tmpList.add(inList[current]);
      counter++;
    }
    if (counter == chunkSize || current == inList.length - 1) {
      if (defaultValue != null && tmpList.length < chunkSize) {
        tmpList.addAll(
            List.generate(chunkSize - tmpList.length, (i) => defaultValue));
      }
      outList.add(tmpList.toList());
      tmpList.clear();
      counter = 0;
    }
  }

  return outList;
}
