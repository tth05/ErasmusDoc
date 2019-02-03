/*
    Copyright (C) 2018-2019 Tim Theisinger
    This project is licensed under the terms of the GNU General Public License v3.0, see LICENSE.txt
*/

import 'dart:math' as math;

import 'package:erasmus_app/managers/manager_context.dart';
import 'package:erasmus_app/models/school.dart';
import 'package:flutter/material.dart';

class SelectSchoolDropdownButton extends FormField<School> {
  SelectSchoolDropdownButton(School initialValue, {FormFieldSetter<School> onSaved, FormFieldValidator<School> validator})
      : super(
          onSaved: onSaved,
          validator: validator == null
              ? (value) {
                  if (value == null) return 'Bitte wähle deine Schule aus.';
                }
              : validator,
          initialValue: initialValue,
          builder: (FormFieldState<School> state) {
            final isSchoolSelected = state.value != null;
            final jsonManager = ManagerContext.of(state.context).jsonManager;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FixedDropdownButton(
                  items: jsonManager.schools.map((School val) {
                    return DropdownMenuItem(
                      value: val,
                      child: Text(val.translatedName),
                    );
                  }).toList(),
                  hint: Text(
                    isSchoolSelected ? state.value.translatedName : "Schule auswählen",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: isSchoolSelected ? Colors.black : Colors.grey,
                    ),
                  ),
                  onChanged: (School s) {
                    state.didChange(s);
                  },
                ),
                state.hasError
                    ? Text(
                        state.errorText,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Theme.of(state.context).errorColor,
                          fontSize: 12.0,
                        ),
                      )
                    : Container()
              ],
            );
          },
        );
}

/*
  Copyright 2015 The Chromium Authors. All rights reserved.
  Use of this source code is governed by a BSD-style license that can be
  found in the LICENSE file.

  Edited by Tim Theisinger
*/
const Duration _kDropdownMenuDuration = Duration(milliseconds: 300);
const double _kMenuItemHeight = 48.0;
const double _kDenseButtonHeight = 24.0;
const EdgeInsets _kMenuItemPadding = EdgeInsets.symmetric(horizontal: 16.0);
const EdgeInsetsGeometry _kAlignedButtonPadding = EdgeInsetsDirectional.only(start: 16.0, end: 4.0);
const EdgeInsets _kUnalignedButtonPadding = EdgeInsets.zero;
const EdgeInsets _kAlignedMenuMargin = EdgeInsets.zero;
const EdgeInsetsGeometry _kUnalignedMenuMargin = EdgeInsetsDirectional.only(start: 16.0, end: 24.0);

class _DropdownMenuPainter extends CustomPainter {
  _DropdownMenuPainter({
    this.color,
    this.elevation,
    this.selectedIndex,
    this.resize,
  }) : _painter = BoxDecoration(
    // If you add an image here, you must provide a real
    // configuration in the paint() function and you must provide some sort
    // of onChanged callback here.
      color: color,
      borderRadius: BorderRadius.circular(2.0),
      boxShadow: kElevationToShadow[elevation]
  ).createBoxPainter(),
        super(repaint: resize);

  final Color color;
  final int elevation;
  final int selectedIndex;
  final Animation<double> resize;

  final BoxPainter _painter;

  @override
  void paint(Canvas canvas, Size size) {
    final double selectedItemOffset = selectedIndex * _kMenuItemHeight + kMaterialListPadding.top;
    final Tween<double> top = Tween<double>(
      begin: selectedItemOffset.clamp(0.0, size.height - _kMenuItemHeight),
      end: 0.0,
    );

    final Tween<double> bottom = Tween<double>(
      begin: (top.begin + _kMenuItemHeight).clamp(_kMenuItemHeight, size.height),
      end: size.height,
    );

    final Rect rect = Rect.fromLTRB(0.0, top.evaluate(resize), size.width, bottom.evaluate(resize));

    _painter.paint(canvas, rect.topLeft, ImageConfiguration(size: rect.size));
  }

  @override
  bool shouldRepaint(_DropdownMenuPainter oldPainter) {
    return oldPainter.color != color
        || oldPainter.elevation != elevation
        || oldPainter.selectedIndex != selectedIndex
        || oldPainter.resize != resize;
  }
}

class _DropdownScrollBehavior extends ScrollBehavior {
  const _DropdownScrollBehavior();

  @override
  TargetPlatform getPlatform(BuildContext context) => Theme.of(context).platform;

  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) => child;

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) => const ClampingScrollPhysics();
}

class _DropdownMenu<T> extends StatefulWidget {
  const _DropdownMenu({
    Key key,
    this.padding,
    this.route,
  }) : super(key: key);

  final _DropdownRoute<T> route;
  final EdgeInsets padding;

  @override
  _DropdownMenuState<T> createState() => _DropdownMenuState<T>();
}

class _DropdownMenuState<T> extends State<_DropdownMenu<T>> {
  CurvedAnimation _fadeOpacity;
  CurvedAnimation _resize;

  @override
  void initState() {
    super.initState();
    _fadeOpacity = CurvedAnimation(
      parent: widget.route.animation,
      curve: const Interval(0.0, 0.25),
      reverseCurve: const Interval(0.75, 1.0),
    );
    _resize = CurvedAnimation(
      parent: widget.route.animation,
      curve: const Interval(0.25, 0.5),
      reverseCurve: const Threshold(0.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    final MaterialLocalizations localizations = MaterialLocalizations.of(context);
    final _DropdownRoute<T> route = widget.route;
    final double unit = 0.5 / (route.items.length + 1.5);
    final List<Widget> children = <Widget>[];
    for (int itemIndex = 0; itemIndex < route.items.length; ++itemIndex) {
      CurvedAnimation opacity;
      if (itemIndex == route.selectedIndex) {
        opacity = CurvedAnimation(parent: route.animation, curve: const Threshold(0.0));
      } else {
        final double start = (0.5 + (itemIndex + 1) * unit).clamp(0.0, 1.0);
        final double end = (start + 1.5 * unit).clamp(0.0, 1.0);
        opacity = CurvedAnimation(parent: route.animation, curve: Interval(start, end));
      }
      children.add(FadeTransition(
        opacity: opacity,
        child: InkWell(
          child: Container(
            padding: widget.padding,
            child: route.items[itemIndex],
          ),
          onTap: () => Navigator.pop(
            context,
            _DropdownRouteResult<T>(route.items[itemIndex].value),
          ),
        ),
      ));
    }

    return FadeTransition(
      opacity: _fadeOpacity,
      child: CustomPaint(
        painter: _DropdownMenuPainter(
          color: Theme.of(context).canvasColor,
          elevation: route.elevation,
          selectedIndex: route.selectedIndex,
          resize: _resize,
        ),
        child: Semantics(
          scopesRoute: true,
          namesRoute: true,
          explicitChildNodes: true,
          label: localizations.popupMenuLabel,
          child: Material(
            type: MaterialType.transparency,
            textStyle: route.style,
            child: ScrollConfiguration(
              behavior: const _DropdownScrollBehavior(),
              child: Scrollbar(
                child: ListView(
                  controller: widget.route.scrollController,
                  padding: kMaterialListPadding,
                  itemExtent: _kMenuItemHeight,
                  shrinkWrap: true,
                  children: children,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DropdownMenuRouteLayout<T> extends SingleChildLayoutDelegate {
  _DropdownMenuRouteLayout({
    @required this.buttonRect,
    @required this.menuTop,
    @required this.menuHeight,
    @required this.textDirection,
  });

  final Rect buttonRect;
  final double menuTop;
  final double menuHeight;
  final TextDirection textDirection;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    final double maxHeight = math.max(0.0, constraints.maxHeight - 2 * _kMenuItemHeight);
    final double width = math.min(constraints.maxWidth, buttonRect.width);
    return BoxConstraints(
      minWidth: width,
      maxWidth: width,
      minHeight: 0.0,
      maxHeight: maxHeight,
    );
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    assert(() {
      final Rect container = Offset.zero & size;
      if (container.intersect(buttonRect) == buttonRect) {
        assert(menuTop >= 0.0);
        assert(menuTop + menuHeight <= size.height);
      }
      return true;
    }());
    assert(textDirection != null);
    double left;
    switch (textDirection) {
      case TextDirection.rtl:
        left = buttonRect.right.clamp(0.0, size.width) - childSize.width;
        break;
      case TextDirection.ltr:
        left = buttonRect.left.clamp(0.0, size.width - childSize.width);
        break;
    }
    return Offset(left, menuTop);
  }

  @override
  bool shouldRelayout(_DropdownMenuRouteLayout<T> oldDelegate) {
    return buttonRect != oldDelegate.buttonRect
        || menuTop != oldDelegate.menuTop
        || menuHeight != oldDelegate.menuHeight
        || textDirection != oldDelegate.textDirection;
  }
}

class _DropdownRouteResult<T> {
  const _DropdownRouteResult(this.result);

  final T result;

  @override
  bool operator ==(dynamic other) {
    if (other is! _DropdownRouteResult<T>)
      return false;
    final _DropdownRouteResult<T> typedOther = other;
    return result == typedOther.result;
  }

  @override
  int get hashCode => result.hashCode;
}

class _DropdownRoute<T> extends PopupRoute<_DropdownRouteResult<T>> {
  _DropdownRoute({
    this.items,
    this.padding,
    this.buttonRect,
    this.selectedIndex,
    this.elevation = 8,
    this.theme,
    @required this.style,
    this.barrierLabel,
  }) : assert(style != null);

  final List<DropdownMenuItem<T>> items;
  final EdgeInsetsGeometry padding;
  final Rect buttonRect;
  final int selectedIndex;
  final int elevation;
  final ThemeData theme;
  final TextStyle style;

  ScrollController scrollController;

  @override
  Duration get transitionDuration => _kDropdownMenuDuration;

  @override
  bool get barrierDismissible => true;

  @override
  Color get barrierColor => null;

  @override
  final String barrierLabel;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    assert(debugCheckHasDirectionality(context));
    final double screenHeight = MediaQuery.of(context).size.height;
    final double maxMenuHeight = screenHeight - 2.0 * _kMenuItemHeight;

    final double buttonTop = buttonRect.top;
    final double buttonBottom = buttonRect.bottom;

    final double topLimit = math.min(_kMenuItemHeight, buttonTop);
    final double bottomLimit = math.max(screenHeight - _kMenuItemHeight, buttonBottom);

    final double selectedItemOffset = selectedIndex * _kMenuItemHeight + kMaterialListPadding.top;

    double menuTop = (buttonTop - selectedItemOffset) - (_kMenuItemHeight - buttonRect.height) / 2.0;
    final double preferredMenuHeight = (items.length * _kMenuItemHeight) + kMaterialListPadding.vertical;

    final double menuHeight = math.min(maxMenuHeight, preferredMenuHeight);

    double menuBottom = menuTop + menuHeight;

    if (menuTop < topLimit)
      menuTop = math.min(buttonTop, topLimit);
    if (menuBottom > bottomLimit) {
      menuBottom = math.max(buttonBottom, bottomLimit);
      menuTop = menuBottom - menuHeight;
    }

    if (scrollController == null) {
      final double scrollOffset = preferredMenuHeight > maxMenuHeight ? math.max(0.0, selectedItemOffset - (buttonTop - menuTop)) : 0.0;
      scrollController = ScrollController(initialScrollOffset: scrollOffset);
    }

    final TextDirection textDirection = Directionality.of(context);
    Widget menu = _DropdownMenu<T>(
      route: this,
      padding: padding.resolve(textDirection),
    );

    if (theme != null)
      menu = Theme(data: theme, child: menu);

    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      removeBottom: true,
      removeLeft: true,
      removeRight: true,
      child: Builder(
        builder: (BuildContext context) {
          return CustomSingleChildLayout(
            delegate: _DropdownMenuRouteLayout<T>(
              buttonRect: buttonRect,
              menuTop: menuTop,
              menuHeight: menuHeight,
              textDirection: textDirection,
            ),
            child: menu,
          );
        },
      ),
    );
  }

  void _dismiss() {
    navigator?.removeRoute(this);
  }
}

class FixedDropdownButton<T> extends StatefulWidget {
  FixedDropdownButton({
    Key key,
    @required this.items,
    this.value,
    this.hint,
    this.disabledHint,
    @required this.onChanged,
    this.elevation = 8,
    this.style,
    this.iconSize = 24.0,
    this.isDense = false,
    this.isExpanded = false,
  }) : assert(items == null || value == null || items.where((DropdownMenuItem<T> item) => item.value == value).length == 1),
        super(key: key);

  final List<DropdownMenuItem<T>> items;

  final T value;

  final Widget hint;

  final Widget disabledHint;

  final ValueChanged<T> onChanged;

  final int elevation;

  final TextStyle style;

  final double iconSize;

  final bool isDense;

  final bool isExpanded;

  @override
  _FixedDropdownButtonState<T> createState() => _FixedDropdownButtonState<T>();
}

class _FixedDropdownButtonState<T> extends State<FixedDropdownButton<T>> with WidgetsBindingObserver {
  int _selectedIndex;
  _DropdownRoute<T> _dropdownRoute;

  @override
  void initState() {
    super.initState();
    _updateSelectedIndex();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _removeDropdownRoute();
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    _removeDropdownRoute();
  }

  void _removeDropdownRoute() {
    _dropdownRoute?._dismiss();
    _dropdownRoute = null;
  }

  @override
  void didUpdateWidget(FixedDropdownButton<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateSelectedIndex();
  }

  void _updateSelectedIndex() {
    if (!_enabled) {
      return;
    }

    assert(widget.value == null ||
        widget.items.where((DropdownMenuItem<T> item) => item.value == widget.value).length == 1);
    _selectedIndex = null;
    for (int itemIndex = 0; itemIndex < widget.items.length; itemIndex++) {
      if (widget.items[itemIndex].value == widget.value) {
        _selectedIndex = itemIndex;
        return;
      }
    }
  }

  TextStyle get _textStyle => widget.style ?? Theme.of(context).textTheme.subhead;

  void _handleTap() {
    final RenderBox itemBox = context.findRenderObject();
    final Rect itemRect = itemBox.localToGlobal(Offset.zero) & itemBox.size;
    final TextDirection textDirection = Directionality.of(context);
    final EdgeInsetsGeometry menuMargin = ButtonTheme.of(context).alignedDropdown
        ?_kAlignedMenuMargin
        : _kUnalignedMenuMargin;

    assert(_dropdownRoute == null);
    _dropdownRoute = _DropdownRoute<T>(
      items: widget.items,
      buttonRect: menuMargin.resolve(textDirection).inflateRect(itemRect),
      padding: _kMenuItemPadding.resolve(textDirection),
      selectedIndex: _selectedIndex ?? 0,
      elevation: widget.elevation,
      theme: Theme.of(context, shadowThemeOnly: true),
      style: _textStyle,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    );

    Navigator.push(context, _dropdownRoute).then<void>((_DropdownRouteResult<T> newValue) {
      _dropdownRoute = null;
      if (!mounted || newValue == null)
        return;
      if (widget.onChanged != null)
        widget.onChanged(newValue.result);
    });
  }

  double get _denseButtonHeight {
    return math.max(_textStyle.fontSize, math.max(widget.iconSize, _kDenseButtonHeight));
  }

  Color get _downArrowColor {
    if (_enabled) {
      if (Theme.of(context).brightness == Brightness.light) {
        return Colors.grey.shade700;
      } else {
        return Colors.white70;
      }
    } else {
      if (Theme.of(context).brightness == Brightness.light) {
        return Colors.grey.shade400;
      } else {
        return Colors.white10;
      }
    }
  }

  bool get _enabled => widget.items != null && widget.items.isNotEmpty && widget.onChanged != null;

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    assert(debugCheckHasMaterialLocalizations(context));

    final List<Widget> items = _enabled ? List<Widget>.from(widget.items) : <Widget>[];
    int hintIndex;
    if (widget.hint != null || (!_enabled && widget.disabledHint != null)) {
      final Widget emplacedHint =
      _enabled ? widget.hint : DropdownMenuItem<Widget>(child: widget.disabledHint ?? widget.hint);
      hintIndex = items.length;
      items.add(DefaultTextStyle(
        style: _textStyle.copyWith(color: Theme.of(context).hintColor),
        child: IgnorePointer(
          child: emplacedHint,
          ignoringSemantics: false,
        ),
      ));
    }

    final EdgeInsetsGeometry padding = ButtonTheme.of(context).alignedDropdown
        ? _kAlignedButtonPadding
        : _kUnalignedButtonPadding;

    // If value is null (then _selectedIndex is null) or if disabled then we
    // display the hint or nothing at all.
    final IndexedStack innerItemsWidget = IndexedStack(
      index: _enabled ? (_selectedIndex ?? hintIndex) : hintIndex,
      alignment: AlignmentDirectional.centerStart,
      children: items,
    );

    Widget result = DefaultTextStyle(
      style: _textStyle,
      child: Container(
        padding: padding.resolve(Directionality.of(context)),
        height: widget.isDense ? _denseButtonHeight : null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(child: innerItemsWidget),
            Icon(Icons.arrow_drop_down,
              size: widget.iconSize,
              color: _downArrowColor,
            ),
          ],
        ),
      ),
    );

    if (!DropdownButtonHideUnderline.at(context)) {
      final double bottom = widget.isDense ? 0.0 : 8.0;
      result = Stack(
        children: <Widget>[
          result,
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: bottom,
            child: Container(
              height: 1.0,
              decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Color(0xFFBDBDBD), width: 0.0))
              ),
            ),
          ),
        ],
      );
    }

    return Semantics(
      button: true,
      child: GestureDetector(
          onTap: _enabled ? _handleTap : null,
          behavior: HitTestBehavior.opaque,
          child: result
      ),
    );
  }
}