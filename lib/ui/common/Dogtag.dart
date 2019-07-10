import 'package:flutter/material.dart';

class DogTagViewModel {
  String title;
  String number;
  IconData icon;

  DogTagViewModel({this.title, this.icon, this.number});
}

DogTagViewModel buildDogTagViewModel(
    {String title, IconData icon, String number}) {
  return DogTagViewModel(title: title, icon: icon, number: number);
}

class DogTagStyle {
  final Color backgroundColor;
  final BorderRadius borderRadius;
  final EdgeInsets edgePadding;
  final TextStyle titleTextStyle;
  final int maxLines;
  final double iconSize;
  final double spacing;
  final Color iconColor;

  const DogTagStyle(
      {this.backgroundColor,
      this.borderRadius,
      this.edgePadding,
      this.titleTextStyle,
      this.maxLines,
      this.iconSize,
      this.iconColor,
      this.spacing});

  factory DogTagStyle.defaultStyle() {
    return DogTagStyle(
        backgroundColor: Color(0x1425df0c),
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        edgePadding:
            EdgeInsets.only(top: 4.5, right: 12, left: 12, bottom: 4.5),
        titleTextStyle: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Color(0xff21c400)),
        maxLines: 1,
        iconSize: 8,
        iconColor: Colors.black,
        spacing: 5.5);
  }

  factory DogTagStyle.negativeStyle() {
    return DogTagStyle.defaultStyle().copyWith(
      backgroundColor: Color(0x14ff8d4f),
      titleTextStyle: TextStyle(
          fontSize: 15, fontWeight: FontWeight.w500, color: Color(0xffff8d4f)),
    );
  }

  factory DogTagStyle.compactStyle() {
    return DogTagStyle.defaultStyle().copyWith(
        edgePadding:
            EdgeInsets.only(left: 12, top: 5.5, right: 12, bottom: 5.5),
        titleTextStyle: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: Color(0xff21c400)));
  }

  DogTagStyle copyWith(
      {Color backgroundColor,
      BorderRadius borderRadius,
      EdgeInsets edgePadding,
      TextStyle titleTextStyle,
      int maxLines,
      double iconSize,
      Color iconColor,
      double spacing}) {
    return DogTagStyle(
        backgroundColor: backgroundColor ?? this.backgroundColor,
        borderRadius: borderRadius ?? this.borderRadius,
        edgePadding: edgePadding ?? this.edgePadding,
        titleTextStyle: titleTextStyle ?? this.titleTextStyle,
        maxLines: maxLines ?? this.maxLines,
        iconSize: iconSize ?? this.iconSize,
        iconColor: iconColor ?? this.iconColor,
        spacing: spacing ?? this.spacing);
  }
}

class DogTag extends StatelessWidget {
  final DogTagViewModel _viewModel;
  final DogTagStyle _style;

  const DogTag({Key key, DogTagViewModel viewModel, DogTagStyle style})
      : this._viewModel = viewModel,
        this._style = style,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: _style.edgePadding,
      decoration: BoxDecoration(
        color: _style.backgroundColor,
        borderRadius: _style.borderRadius,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
              child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: _buildButtonContent(
              _viewModel,
              _style,
            ),
            spacing: _style.spacing,
          ))
        ],
      ),
    );
  }

  List<Widget> _buildButtonContent(
      DogTagViewModel viewModel, DogTagStyle style) {
    List<Widget> listBuilder = [];

    if (viewModel.icon != null) {
      listBuilder.add(
        Icon(
          viewModel.icon,
          size: style.iconSize,
          color: style.iconColor,
        ),
      );
    }
    if (viewModel.number != null) {
      listBuilder.add(
        Text(
          viewModel.number,
          style: style.titleTextStyle,
          overflow: TextOverflow.ellipsis,
          maxLines: style.maxLines,
        ),
      );
    }
    if (viewModel.title != null) {
      listBuilder.add(
        Text(
          viewModel.title,
          style: style.titleTextStyle,
          overflow: TextOverflow.ellipsis,
          maxLines: style.maxLines,
        ),
      );
    }
    return listBuilder;
  }
}
