import 'package:flutter/material.dart';

class SingleSelectionDropdownView<ITEM> extends StatelessWidget {

  final List<ITEM> options;
  final String Function(ITEM item) getTitle;
  final ITEM selected;
  final Color backgroundColor;
  final TextStyle textStyle;
  final TextStyle selectedTextStyle;
  final DividerThemeData dividerTheme;
  final Widget Function(BuildContext context, ITEM item) createItemView;
  final int columnNum;

  SingleSelectionDropdownView({
    Key key,
    @required this.options,
    @required this.getTitle,
    this.selected,
    this.backgroundColor,
    this.textStyle,
    this.selectedTextStyle,
    this.dividerTheme,
    this.createItemView,
    this.columnNum = 2,
  }) : super(key: key);

  SingleSelectionDropdownView.builder({
    Key key,
    @required this.options,
    @required this.getTitle,
    this.selected,
    this.backgroundColor,
    this.textStyle,
    this.selectedTextStyle,
    this.dividerTheme,
    this.columnNum = 2,
  }) : createItemView = null;

  SingleSelectionDropdownView.custom({
    Key key,
    @required this.options,
    @required this.getTitle,
    this.selected,
    this.backgroundColor,
    @required this.createItemView,
    this.columnNum = 2,
  }) : textStyle = null,
        selectedTextStyle = null,
        dividerTheme = null;

  @override
  Widget build(BuildContext context) {
    List<Widget> child = [];
    Row row;
    var rowIndex = 0;
    for (int i = 0; i < options.length; i++) {
      final option = options[i];
      if (i % columnNum == 0) {
        row = Row(
          children: <Widget>[],
        );
        if(rowIndex > 0) {
          child.add(
            Divider(
              height: dividerTheme?.space,
              thickness: dividerTheme?.thickness,
              indent: dividerTheme?.indent,
              endIndent: dividerTheme?.endIndent,
              color: dividerTheme?.color,
            )
          );
        }
        child.add(
          Container(
            height: 46,
            child: row,
          )
        );
        rowIndex++;
      }
      row.children.add(
        Expanded(
          flex: 1,
          child: InkWell(
            onTap: () => Navigator.of(context).pop(option),
            child: SingleSelectionDropdownItemView(
              title: getTitle(option),
              isSelected: option == selected,
              textStyle: textStyle,
              selectedTextStyle: selectedTextStyle,
            ),
          )
        )
      );
    }

    return SingleChildScrollView(
      child: Container(
        color: backgroundColor,
        child: Column(children: child),
      ),
    );
  }
}

class SingleSelectionDropdownItemView<ITEM> extends StatelessWidget {

  final String title;
  final bool isSelected;
  final TextStyle textStyle;
  final TextStyle selectedTextStyle;

  const SingleSelectionDropdownItemView({
    Key key,
    @required this.title,
    @required this.isSelected,
    this.textStyle,
    this.selectedTextStyle
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: title,
              style: isSelected ? selectedTextStyle : textStyle,
            ),
            WidgetSpan(
              child: Visibility(
                visible: isSelected,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Icon(Icons.check, size: 20, color: selectedTextStyle.color),
                ),
              ),
            ),
          ]
        ),
      ),
    );
  }
}