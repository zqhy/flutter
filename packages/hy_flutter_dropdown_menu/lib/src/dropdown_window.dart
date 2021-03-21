import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// http://webcache.googleusercontent.com/search?q=cache:8XOXMM4DkjUJ:flutter-dev.cn/post/452+&cd=1&hl=zh-CN&ct=clnk

const Duration _kWindowDuration = const Duration(milliseconds: 60);
const double _kWindowCloseIntervalEnd = 2.0 / 3.0;
const double _kWindowMaxWidth = 5.0 * _kWindowWidthStep;
const double _kWindowMinWidth = 2.0 * _kWindowWidthStep;
const double _kWindowVerticalPadding = 0.0;
const double _kWindowWidthStep = 56.0;
const double _kWindowScreenPadding = 0.0;

Future<T?> showAsDropDown<T>(BuildContext context, {
  required Widget popupWindow,
  Offset offset = Offset.zero,
  bool fullWidth = true,
}) {
  ///获取本控件的渲染对象
  final RenderBox button = context.findRenderObject() as RenderBox;

  ///获取本控件覆盖物的渲染对象
  final RenderBox overlay = Overlay.of(context)?.context.findRenderObject() as RenderBox;

  ///计算弹窗的弹出位置，widget.offset为偏移数据，默认在button底部弹出。
  final RelativeRect position = new RelativeRect.fromRect(
    new Rect.fromPoints(
      button.localToGlobal(button.size.bottomLeft(offset),
          ancestor: overlay),
      button.localToGlobal(button.size.bottomRight(offset),
          ancestor: overlay),
    ),
    Offset.zero & overlay.size,
  );

  return showPopupWindow(
    context: context,
    popupWindow: popupWindow,
    position: position,
    fullWidth: fullWidth,
  );
}

///弹窗方法
Future<T?> showPopupWindow<T>({
  required BuildContext context,
  required Widget popupWindow,
  double elevation: 8.0,
  String? semanticLabel,
  required RelativeRect position,
  bool fullWidth: false,
}) {
  var label = semanticLabel;
  switch (defaultTargetPlatform) {
    case TargetPlatform.iOS:
      label = semanticLabel;
      break;
    default:
      label = semanticLabel ?? MaterialLocalizations.of(context).popupMenuLabel;
  }

  return Navigator.push<T>(
      context,
      new _PopupWindowRoute(
        // context: context,
        position: position,
        child: popupWindow,
        elevation: elevation,
        semanticLabel: label,
        theme: Theme.of(context),
        barrierLabel:
        MaterialLocalizations.of(context).modalBarrierDismissLabel,
        fullWidth: fullWidth,
      ));
}

///自定义弹窗路由：参照_PopupMenuRoute修改的
class _PopupWindowRoute<T> extends PopupRoute<T> {
  _PopupWindowRoute({
    // @required BuildContext context,
    RouteSettings? settings,
    required this.child,
    required this.position,
    this.elevation: 8.0,
    this.theme,
    this.barrierLabel,
    this.semanticLabel,
    this.fullWidth: false,
  }) : super(settings: settings);

  final Widget child;
  final RelativeRect position;
  double elevation;
  final ThemeData? theme;
  final String? semanticLabel;
  final bool fullWidth;

  @override
  Color? get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  final String? barrierLabel;

  @override
  Duration get transitionDuration => _kWindowDuration;

  @override
  Animation<double> createAnimation() {
    return new CurvedAnimation(
        parent: super.createAnimation(),
        curve: Curves.linear,
        reverseCurve: const Interval(0.0, _kWindowCloseIntervalEnd));
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    final mediaQuery = MediaQuery.of(context);
    final maxHeight = mediaQuery.size.height - mediaQuery.padding.bottom - position.top;
    Widget win = new _PopupWindow<T>(
      route: this,
      semanticLabel: semanticLabel,
      fullWidth: fullWidth,
      maxHeight: maxHeight,
    );

    if (theme != null) {
      win = new Theme(data: theme!, child: win);
    }

    print("位置：$position");
    return new MediaQuery.removePadding(
      context: context,
      removeTop: true,
      removeBottom: true,
      removeLeft: true,
      removeRight: true,
      child: new Builder(
        builder: (BuildContext context) {
          return new CustomSingleChildLayout(
            delegate: new _PopupWindowLayoutDelegate(
                position, null, Directionality.of(context)),
            child: win,
          );
        },
      ),
    );
  }
}

///自定义弹窗控件：对自定义的弹窗内容进行再包装，添加长宽、动画等约束条件
class _PopupWindow<T> extends StatelessWidget {
  const _PopupWindow({
    Key? key,
    required this.route,
    this.semanticLabel,
    this.fullWidth: false,
    required this.maxHeight,
  }) : super(key: key);

  final _PopupWindowRoute<T> route;
  final String? semanticLabel;
  final bool fullWidth;
  final double maxHeight;

  @override
  Widget build(BuildContext context) {
    final double length = 10.0;
    final double unit = 1.0 /
        (length + 1.5); // 1.0 for the width and 0.5 for the last item's fade.

    final CurveTween opacity =
    new CurveTween(curve: const Interval(0.0, 1.0 / 3.0));
    final CurveTween width = new CurveTween(curve: new Interval(0.0, unit));
    final CurveTween height =
    new CurveTween(curve: new Interval(0.0, unit * length));

    final Widget child = new ConstrainedBox(
      constraints: new BoxConstraints(
        minWidth: fullWidth ? double.infinity : _kWindowMinWidth,
        maxWidth: fullWidth ? double.infinity : _kWindowMaxWidth,
        maxHeight: maxHeight,
      ),
      child: new IntrinsicWidth(
          stepWidth: _kWindowWidthStep,
          child: new SingleChildScrollView(
            padding:
            const EdgeInsets.symmetric(vertical: _kWindowVerticalPadding),
            child: route.child,
          )),
    );

    return new AnimatedBuilder(
      animation: route.animation!,
      builder: (BuildContext context, Widget? child) {
        return new Opacity(
          opacity: opacity.evaluate(route.animation!),
          child: new Material(
            type: MaterialType.card,
            elevation: route.elevation,
            child: new Align(
              alignment: AlignmentDirectional.topEnd,
              widthFactor: width.evaluate(route.animation!),
              heightFactor: height.evaluate(route.animation!),
              child: new Semantics(
                scopesRoute: true,
                namesRoute: true,
                explicitChildNodes: true,
                label: semanticLabel,
                child: child,
              ),
            ),
          ),
        );
      },
      child: child,
    );
  }
}

///自定义委托内容：子控件大小及其位置计算
class _PopupWindowLayoutDelegate extends SingleChildLayoutDelegate {
  _PopupWindowLayoutDelegate(
      this.position, this.selectedItemOffset, this.textDirection);

  final RelativeRect position;
  final double? selectedItemOffset;
  final TextDirection textDirection;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    // The menu can be at most the size of the overlay minus 8.0 pixels in each
    // direction.
    return new BoxConstraints.loose((constraints.biggest -
        const Offset(_kWindowScreenPadding * 2.0, _kWindowScreenPadding * 2.0)) as Size);
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    // size: The size of the overlay.
    // childSize: The size of the menu, when fully open, as determined by
    // getConstraintsForChild.

    // Find the ideal vertical position.
    double y;
    if (selectedItemOffset == null) {
      y = position.top;
    } else {
      y = position.top +
          (size.height - position.top - position.bottom) / 2.0 -
          (selectedItemOffset ?? 0);
    }

    // Find the ideal horizontal position.
    double x;
    if (position.left > position.right) {
      // Menu button is closer to the right edge, so grow to the left, aligned to the right edge.
      x = size.width - position.right - childSize.width;
    } else if (position.left < position.right) {
      // Menu button is closer to the left edge, so grow to the right, aligned to the left edge.
      x = position.left;
    } else {
      // Menu button is equidistant from both edges, so grow in reading direction.
      switch (textDirection) {
        case TextDirection.rtl:
          x = size.width - position.right - childSize.width;
          break;
        case TextDirection.ltr:
          x = position.left;
          break;
      }
    }

    // Avoid going outside an area defined as the rectangle 8.0 pixels from the
    // edge of the screen in every direction.
    if (x < _kWindowScreenPadding)
      x = _kWindowScreenPadding;
    else if (x + childSize.width > size.width - _kWindowScreenPadding)
      x = size.width - childSize.width - _kWindowScreenPadding;
    if (y < _kWindowScreenPadding)
      y = _kWindowScreenPadding;
    else if (y + childSize.height > size.height - _kWindowScreenPadding)
      y = size.height - childSize.height - _kWindowScreenPadding;
    return new Offset(x, y);
  }

  @override
  bool shouldRelayout(_PopupWindowLayoutDelegate oldDelegate) {
    return position != oldDelegate.position;
  }
}