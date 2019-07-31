import 'dart:ui';

import 'package:farmsmart_flutter/ui/common/ActionSheet.dart';
import 'package:farmsmart_flutter/ui/common/ActionSheetListItem.dart';
import 'package:farmsmart_flutter/ui/common/roundedButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class _Strings {
  static final englishAction = "English";
  static final swahiliAction = "Swahili";
  static final confirmAction = "Confirm";
  static final cancelAction = "Cancel";
}

class _Languages {
  static final english = "en";
  static final swahili = "sw";
}

class _Icons {
  static final englishIcon = "assets/icons/flag_usa.png";
  static final swahiliIcon = "assets/icons/flag_kenya.png";
  static final checkBoxIcon = "assets/icons/radio_button_default.png";
}

class _Constants {
  static final EdgeInsets generalPadding =
      EdgeInsets.only(left: 32, right: 32, top: 40, bottom: 18);
  static final double bottomContainerHeight = 350;
  static final int imageFlexValue = 2;
  static final double subtitleLineSpace = 10;
  static final double actionLineSpace = 34;
  static final EdgeInsets actionTapArea = EdgeInsets.all(10);
}

class LandingPageViewModel {
  String detailText;
  String actionText;
  String footerText;

  String headerImage;
  String subtitleImage;
  Function continueAction;
  ActionSheetViewModel actionSheetViewModel;
  Function (String) switchLanguageTapped;

  LandingPageViewModel({
    this.detailText,
    this.actionText,
    this.headerImage,
    this.subtitleImage,
    this.footerText,
    this.continueAction,
    this.actionSheetViewModel,
    this.switchLanguageTapped,
  });
}

class LandingPageStyle {
  final TextStyle detailTextStyle;
  final TextStyle footerTextStyle;
  final TextStyle actionTextStyle;

  final int detailTextMaxLines;
  final int footerTextMaxLines;

  const LandingPageStyle({
    this.detailTextStyle,
    this.footerTextStyle,
    this.actionTextStyle,
    this.detailTextMaxLines,
    this.footerTextMaxLines,
  });

  LandingPageStyle copyWith({
    TextStyle detailTextStyle,
    TextStyle footerTextStyle,
    TextStyle actionTextStyle,
    int detailTextMaxLines,
    int footerTextMaxLines,
  }) {
    return LandingPageStyle(
      detailTextStyle: detailTextStyle ?? this.detailTextStyle,
      footerTextStyle: footerTextStyle ?? this.footerTextStyle,
      actionTextStyle: actionTextStyle ?? this.actionTextStyle,
      detailTextMaxLines: detailTextMaxLines ?? this.detailTextMaxLines,
      footerTextMaxLines: footerTextMaxLines ?? this.footerTextMaxLines,
    );
  }
}

class _DefaultStyle extends LandingPageStyle {
  final TextStyle detailTextStyle = const TextStyle(
      fontSize: 17,
      height: 1.1,
      fontWeight: FontWeight.normal,
      color: Color(0xff4c4e6e));
  final TextStyle footerTextStyle = const TextStyle(
      fontWeight: FontWeight.normal, fontSize: 15, color: Color(0xff4c4e6e));
  final TextStyle actionTextStyle = const TextStyle(
      fontWeight: FontWeight.w500, fontSize: 17, color: Color(0xffffffff));

  final int detailTextMaxLines = 3;
  final int footerTextMaxLines = 1;

  const _DefaultStyle({
    TextStyle detailTextStyle,
    TextStyle footerTextStyle,
    int detailTextMaxLines,
    int footerTextMaxLines,
  });
}

const LandingPageStyle _defaultStyle = const _DefaultStyle();

class LandingPage extends StatelessWidget {
  final LandingPageViewModel _viewModel;
  final LandingPageStyle _style;

  const LandingPage({
    Key key,
    LandingPageViewModel viewModel,
    LandingPageStyle style = _defaultStyle,
  })  : this._viewModel = viewModel,
        this._style = style,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: _Constants.generalPadding,
      child: Column(
        children: <Widget>[
          Flexible(
            flex: _Constants.imageFlexValue,
            fit: FlexFit.loose,
            child: Container(
              child: Image.asset(
                _viewModel.headerImage,
                width: double.infinity,
              ),
            ),
          ),
          Container(
            height: _Constants.bottomContainerHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Image.asset(_viewModel.subtitleImage),
                    SizedBox(
                      height: _Constants.subtitleLineSpace,
                    ),
                    Text(
                      Intl.message(_viewModel.detailText),
                      style: _style.detailTextStyle,
                      maxLines: _style.detailTextMaxLines,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    RoundedButton(
                      viewModel: RoundedButtonViewModel(
                        title: Intl.message(_viewModel.actionText),
                        onTap: () => _viewModel.continueAction(),
                      ),
                      style: RoundedButtonStyle.largeRoundedButtonStyle()
                          .copyWith(buttonTextStyle: _style.actionTextStyle),
                    ),
                    SizedBox(
                      height: _Constants.actionLineSpace,
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => _languageTapped(_languageMenu(), context),
                      child: Container(
                        margin: _Constants.actionTapArea,
                        child: Text(
                          Intl.message(_viewModel.footerText),
                          style: _style.footerTextStyle,
                          maxLines: _style.footerTextMaxLines,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _languageTapped(ActionSheet sheet, BuildContext context) {
    ActionSheet.present(sheet, context);
  }

  ActionSheet _languageMenu() {
    final actions = [
      ActionSheetListItemViewModel(
        title: Intl.message(_Strings.englishAction),
        type: ActionType.selectable,
        icon: _Icons.englishIcon,
        checkBoxIcon: _Icons.checkBoxIcon,
        onTap: () => _viewModel.switchLanguageTapped(_Languages.english),
      ),
      ActionSheetListItemViewModel(
        title: Intl.message(_Strings.swahiliAction),
        type: ActionType.selectable,
        icon: _Icons.swahiliIcon,
        checkBoxIcon: _Icons.checkBoxIcon,
        onTap: () => _viewModel.switchLanguageTapped(_Languages.swahili),
      ),
    ];

    final actionSheetViewModel = ActionSheetViewModel(
      actions,
      Intl.message(_Strings.cancelAction),
      confirmButtonTitle: _Strings.confirmAction,
    );
    return ActionSheet(
      viewModel: actionSheetViewModel,
      style: ActionSheetStyle.defaultStyle(),
    );
  }
}