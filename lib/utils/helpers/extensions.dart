import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../common_widgets/common_shimmer_box.dart';

// ════════════════════════════════════════════════════════════════
// STRING EXTENSIONS
// ════════════════════════════════════════════════════════════════
// 'hello'.capitalize                   → 'Hello'
// 'hello world'.titleCase             → 'Hello World'
// 'myVariableName'.camelToSentence    → 'My variable name'
// 'hello_world'.snakeToCamel          → 'helloWorld'
// 'John Doe'.initials                 → 'JD'
// 'Flutter Dev'.truncate(7)           → 'Flutter...'
// 'hello world'.removeWhitespace      → 'helloworld'
// ''.nullIfEmpty                      → null
// '  '.isBlank                        → true
// '123'.isNumeric                     → true
// 'john@gmail.com'.isValidEmail       → true
// '+919876543210'.isValidPhone        → true
// 'https://google.com'.isValidUrl     → true
// 'Pass@1234'.isValidPassword         → true
// 'copy me'.copyToClipboard()         → copies to clipboard
extension StringExtension on String {
  String get capitalize =>
      isEmpty ? '' : '${this[0].toUpperCase()}${substring(1)}';

  String get titleCase => split(' ')
      .map((w) => w.isEmpty ? '' : '${w[0].toUpperCase()}${w.substring(1)}')
      .join(' ');

  String get camelToSentence => replaceAllMapped(
        RegExp(r'[A-Z]'),
        (m) => ' ${m.group(0)}',
      ).trim().capitalize;

  bool get isValidEmail =>
      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this);

  bool get isValidPhone =>
      RegExp(r'^\+?[0-9]{7,15}$').hasMatch(replaceAll(' ', ''));

  bool get isValidUrl =>
      RegExp(r'^https?://[^\s/$.?#].[^\s]*$').hasMatch(this);

  bool get isValidPassword =>
      length >= 8 &&
      contains(RegExp(r'[A-Z]')) &&
      contains(RegExp(r'[0-9]')) &&
      contains(RegExp(r'[!@#\$%^&*]'));

  bool get isNumeric => RegExp(r'^\d+$').hasMatch(this);

  bool get isBlank => trim().isEmpty;

  String? get nullIfEmpty => isEmpty ? null : this;

  String get removeWhitespace => replaceAll(RegExp(r'\s+'), '');

  String truncate(int maxLength, {String ellipsis = '...'}) =>
      length <= maxLength ? this : '${substring(0, maxLength)}$ellipsis';

  String get initials {
    final words = trim().split(RegExp(r'\s+'));
    if (words.isEmpty) return '';
    if (words.length == 1) return words[0][0].toUpperCase();
    return '${words[0][0]}${words[words.length - 1][0]}'.toUpperCase();
  }

  String get snakeToCamel {
    final parts = split('_');
    return parts[0] + parts.skip(1).map((p) => p.capitalize).join();
  }

  void copyToClipboard() => Clipboard.setData(ClipboardData(text: this));
}

// ════════════════════════════════════════════════════════════════
// NULLABLE STRING EXTENSIONS
// ════════════════════════════════════════════════════════════════
// String? name;
// name.isNullOrEmpty   → true
// name.isNullOrBlank   → true
// name.orEmpty         → ''
extension NullableStringExtension on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
  bool get isNullOrBlank => this == null || this!.trim().isEmpty;
  String get orEmpty => this ?? '';
}

// ════════════════════════════════════════════════════════════════
// NUM EXTENSIONS
// ════════════════════════════════════════════════════════════════
// 1500.toCurrency()            → '₹1,500.00'
// 1500.toCurrency(symbol: '$') → '$1,500.00'
// 1200000.compact              → '1.2M'
// 0.75.asProgress              → 0.75  (clamped 0.0–1.0)
// (-5).isNegative              → true
// 2.seconds                    → Duration(seconds: 2)
// await 2.seconds.delay        → pauses 2 seconds
extension NumExtension on num {
  String toCurrency({String symbol = '₹', int decimalDigits = 2}) =>
      NumberFormat.currency(symbol: symbol, decimalDigits: decimalDigits)
          .format(this);

  String get compact => NumberFormat.compact().format(this);

  double get asProgress => clamp(0.0, 1.0).toDouble();

  bool get isPositive => this > 0;
  bool get isNegative => this < 0;
  bool get isZero => this == 0;

  Duration get milliseconds => Duration(milliseconds: toInt());
  Duration get seconds => Duration(seconds: toInt());
  Duration get minutes => Duration(minutes: toInt());
}

// ════════════════════════════════════════════════════════════════
// INT EXTENSIONS
// ════════════════════════════════════════════════════════════════
// 1.ordinal              → '1st'
// 2.ordinal              → '2nd'
// 11.ordinal             → '11th'
// 1000.withCommas        → '1,000'
// 1048576.toFileSize     → '1.0 MB'
// 3.isEven               → false
// 3.times(() => print('hi'))  → prints 3 times
extension IntExtension on int {
  String get ordinal {
    if (this >= 11 && this <= 13) return '${this}th';
    switch (this % 10) {
      case 1:
        return '${this}st';
      case 2:
        return '${this}nd';
      case 3:
        return '${this}rd';
      default:
        return '${this}th';
    }
  }

  String get withCommas => NumberFormat('#,##0').format(this);

  String get toFileSize {
    if (this < 1024) return '$this B';
    if (this < 1048576) return '${(this / 1024).toStringAsFixed(1)} KB';
    if (this < 1073741824) return '${(this / 1048576).toStringAsFixed(1)} MB';
    return '${(this / 1073741824).toStringAsFixed(1)} GB';
  }

  bool get isEven => this % 2 == 0;
  bool get isOdd => this % 2 != 0;

  void times(VoidCallback action) {
    for (var i = 0; i < this; i++) {
      action();
    }
  }
}

// ════════════════════════════════════════════════════════════════
// DOUBLE EXTENSIONS
// ════════════════════════════════════════════════════════════════
// 3.14159.roundTo(2)   → 3.14
// 0.756.asPercent      → '75.6%'
// 100.0.toFahrenheit   → 212.0
// 212.0.toCelsius      → 100.0
extension DoubleExtension on double {
  double roundTo(int places) {
    final factor = pow(10, places);
    return (this * factor).round() / factor;
  }

  String get asPercent => '${(this * 100).toStringAsFixed(1)}%';

  double get toFahrenheit => this * 9 / 5 + 32;
  double get toCelsius => (this - 32) * 5 / 9;
}

// ════════════════════════════════════════════════════════════════
// DATETIME EXTENSIONS
// ════════════════════════════════════════════════════════════════
// post.createdAt.timeAgo            → 'Just now' / '3m ago' / '2h ago'
// date.format('dd/MM/yyyy')         → '01/04/2026'
// date.isToday                      → true/false
// date.isYesterday                  → true/false
// date.isTomorrow                   → true/false
// date.isPast                       → true/false
// date.isFuture                     → true/false
// message.sentAt.chatLabel          → 'Today' / 'Yesterday' / '01 Jan 2025'
// date.startOfDay                   → DateTime at 00:00:00
// date.endOfDay                     → DateTime at 23:59:59
extension DateTimeExtension on DateTime {
  String get timeAgo {
    final diff = DateTime.now().difference(this);
    if (diff.inSeconds < 60) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    if (diff.inDays < 30) return '${(diff.inDays / 7).floor()}w ago';
    if (diff.inDays < 365) return '${(diff.inDays / 30).floor()}mo ago';
    return '${(diff.inDays / 365).floor()}y ago';
  }

  String format([String pattern = 'dd MMM yyyy']) =>
      DateFormat(pattern).format(this);

  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }

  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return year == tomorrow.year &&
        month == tomorrow.month &&
        day == tomorrow.day;
  }

  bool get isPast => isBefore(DateTime.now());
  bool get isFuture => isAfter(DateTime.now());

  String get chatLabel {
    if (isToday) return 'Today';
    if (isYesterday) return 'Yesterday';
    return format('dd MMM yyyy');
  }

  DateTime get startOfDay => DateTime(year, month, day);
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59);
}

// ════════════════════════════════════════════════════════════════
// NULLABLE DATETIME EXTENSIONS
// ════════════════════════════════════════════════════════════════
// DateTime? expiry;
// expiry.isNullOrPast     → true
// expiry.orDefault()      → '—'
// expiry.orDefault('N/A') → 'N/A'
// expiry.orNow            → DateTime.now()
extension NullableDateTimeExtension on DateTime? {
  bool get isNullOrPast =>
      this == null || this!.isBefore(DateTime.now());

  String orDefault([String fallback = '—']) =>
      this == null ? fallback : this!.toLocal().toString().split(' ')[0];

  DateTime get orNow => this ?? DateTime.now();
}

// ════════════════════════════════════════════════════════════════
// COLOR EXTENSIONS
// ════════════════════════════════════════════════════════════════
// Colors.blue.darken(0.2)          → darker blue
// Colors.blue.lighten(0.2)         → lighter blue
// Colors.black.isDark              → true
// Colors.white.isLight             → true
// Colors.black.contrastColor       → Colors.white
// Colors.white.contrastColor       → Colors.black
// Colors.blue.toHex                → '#FF2196F3'
// Colors.blue.mimicOpacityColor(0.5) → semi-transparent blue
extension ColorExtension on Color {
  Color mimicOpacityColor(double opacity) => withValues(alpha: opacity);

  Color darken([double amount = 0.1]) {
    final hsl = HSLColor.fromColor(this);
    return hsl
        .withLightness((hsl.lightness - amount).clamp(0.0, 1.0))
        .toColor();
  }

  Color lighten([double amount = 0.1]) {
    final hsl = HSLColor.fromColor(this);
    return hsl
        .withLightness((hsl.lightness + amount).clamp(0.0, 1.0))
        .toColor();
  }

  bool get isDark => computeLuminance() < 0.179;
  bool get isLight => !isDark;

  Color get contrastColor => isDark ? Colors.white : Colors.black;

  String get toHex =>
      '#${toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase()}';
}

// ════════════════════════════════════════════════════════════════
// BUILDCONTEXT EXTENSIONS
// ════════════════════════════════════════════════════════════════
// context.theme                    → ThemeData
// context.textTheme                → TextTheme
// context.colorScheme              → ColorScheme
// context.isDarkMode               → true/false
// context.screenWidth              → double
// context.screenHeight             → double
// context.statusBarHeight          → double
// context.bottomBarHeight          → double
// context.isKeyboardOpen           → true/false
// context.isMobile                 → screenWidth < 600
// context.isTablet                 → 600 <= width < 1024
// context.isDesktop                → screenWidth >= 1024
// context.pop()                    → Navigator.pop
// context.push(HomeScreen())       → Navigator.push
// context.pushReplacement(Screen()) → Navigator.pushReplacement
// context.popUntilFirst()          → pops to root route
// context.hideKeyboard()           → unfocuses all
// context.showSnackBar('Done!')    → quick snackbar
extension ContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get screenSize => mediaQuery.size;
  double get screenWidth => mediaQuery.size.width;
  double get screenHeight => mediaQuery.size.height;
  EdgeInsets get padding => mediaQuery.padding;
  EdgeInsets get viewInsets => mediaQuery.viewInsets;
  double get bottomInset => mediaQuery.viewInsets.bottom;
  bool get isKeyboardOpen => mediaQuery.viewInsets.bottom > 0;
  double get statusBarHeight => mediaQuery.padding.top;
  double get bottomBarHeight => mediaQuery.padding.bottom;

  bool get isMobile => screenWidth < 600;
  bool get isTablet => screenWidth >= 600 && screenWidth < 1024;
  bool get isDesktop => screenWidth >= 1024;

  void pop<T>([T? result]) => Navigator.of(this).pop(result);
  Future<T?> push<T>(Widget page) =>
      Navigator.of(this).push<T>(MaterialPageRoute(builder: (_) => page));
  Future<T?> pushReplacement<T>(Widget page) =>
      Navigator.of(this).pushReplacement<T, dynamic>(
          MaterialPageRoute(builder: (_) => page));
  void popUntilFirst() =>
      Navigator.of(this).popUntil((route) => route.isFirst);

  void hideKeyboard() => FocusScope.of(this).unfocus();
  void requestFocus(FocusNode node) =>
      FocusScope.of(this).requestFocus(node);

  void showSnackBar(
    String message, {
    Duration duration = const Duration(seconds: 2),
    Color? backgroundColor,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
        backgroundColor: backgroundColor,
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// CONTEXT — DIALOG & BOTTOM SHEET EXTENSIONS
// ════════════════════════════════════════════════════════════════
// final confirmed = await context.showConfirmDialog(
//   title: 'Delete?',
//   message: 'This cannot be undone.',
// );
//
// await context.showBottomSheet(child: MySheet());
//
// context.showLoadingDialog(message: 'Saving...');
// await doWork();
// context.dismissDialog();
extension ContextDialogExtension on BuildContext {
  Future<bool> showConfirmDialog({
    required String title,
    required String message,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    Color? confirmColor,
  }) async {
    final result = await showDialog<bool>(
      context: this,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(this, false),
            child: Text(cancelText),
          ),
          TextButton(
            onPressed: () => Navigator.pop(this, true),
            style: TextButton.styleFrom(
              foregroundColor:
                  confirmColor ?? Theme.of(this).colorScheme.error,
            ),
            child: Text(confirmText),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  Future<T?> showBottomSheet<T>({
    required Widget child,
    bool isDismissible = true,
    bool isScrollControlled = true,
    Color? backgroundColor,
    double? maxHeight,
  }) =>
      showModalBottomSheet<T>(
        context: this,
        isDismissible: isDismissible,
        isScrollControlled: isScrollControlled,
        backgroundColor:
            backgroundColor ?? Theme.of(this).colorScheme.surface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        constraints:
            maxHeight != null ? BoxConstraints(maxHeight: maxHeight) : null,
        builder: (_) => child,
      );

  void showLoadingDialog({String? message}) {
    showDialog(
      context: this,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: Center(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(),
                  if (message != null) ...[
                    const SizedBox(height: 16),
                    Text(message),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void dismissDialog() =>
      Navigator.of(this, rootNavigator: true).pop();
}

// ════════════════════════════════════════════════════════════════
// LIST EXTENSIONS
// ════════════════════════════════════════════════════════════════
// [].firstOrNull                              → null (safe)
// [1,2,3].lastOrNull                          → 3
// users.firstWhereOrNull((u) => u.isAdmin)    → User? (no exception)
// [1,2,3,4,5].chunk(2)                        → [[1,2],[3,4],[5]]
// [1,2,3].shuffled                            → [2,1,3] (random)
// widgets.joinWith(Divider())                 → [w, Divider, w, Divider, w]
extension ListExtension<T> on List<T> {
  T? get firstOrNull => isEmpty ? null : first;
  T? get lastOrNull => isEmpty ? null : last;

  T? firstWhereOrNull(bool Function(T) test) {
    for (final e in this) {
      if (test(e)) return e;
    }
    return null;
  }

  List<List<T>> chunk(int size) {
    final chunks = <List<T>>[];
    for (var i = 0; i < length; i += size) {
      chunks.add(sublist(i, min(i + size, length)));
    }
    return chunks;
  }

  List<T> get shuffled => [...this]..shuffle();

  List<T> joinWith(T separator) {
    if (isEmpty) return this;
    return [
      for (var i = 0; i < length; i++) ...[
        this[i],
        if (i != length - 1) separator,
      ],
    ];
  }
}

// ════════════════════════════════════════════════════════════════
// ITERABLE EXTENSIONS
// ════════════════════════════════════════════════════════════════
// orders.groupBy((o) => o.status)           → Map<Status, List<Order>>
// cartItems.sumBy((item) => item.price)     → double total
// users.countWhere((u) => u.isActive)       → int count
// items.indexed → (0, item0), (1, item1)...
// list.randomItem                           → random element or null
extension IterableExtension<T> on Iterable<T> {
  Map<K, List<T>> groupBy<K>(K Function(T) key) {
    final map = <K, List<T>>{};
    for (final item in this) {
      (map[key(item)] ??= []).add(item);
    }
    return map;
  }

  double sumBy(double Function(T) value) =>
      fold(0.0, (sum, item) => sum + value(item));

  int countWhere(bool Function(T) test) => where(test).length;

  Iterable<(int, T)> get indexed sync* {
    var i = 0;
    for (final item in this) {
      yield (i++, item);
    }
  }

  T? get randomItem {
    if (isEmpty) return null;
    final list = toList();
    return list[Random().nextInt(list.length)];
  }
}

// ════════════════════════════════════════════════════════════════
// WIDGET EXTENSIONS
// ════════════════════════════════════════════════════════════════
// Text('Hi').paddingAll(16)
// Text('Hi').paddingSymmetric(h: 16, v: 8)
// Text('Hi').paddingOnly(left: 8, top: 4)
// Text('Hi').center
// Text('Hi').expanded
// Text('Hi').flexible
// Text('Hi').opacity(0.5)
// Text('Hi').onTap(() => doSomething())
// Text('Hi').visible(isLoggedIn)
// Text('Hi').sizedBox(width: 100, height: 50)
extension WidgetExtension on Widget {
  Widget paddingAll(double value) =>
      Padding(padding: EdgeInsets.all(value), child: this);

  Widget paddingSymmetric({double h = 0, double v = 0}) => Padding(
        padding: EdgeInsets.symmetric(horizontal: h, vertical: v),
        child: this,
      );

  Widget paddingOnly({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) =>
      Padding(
        padding: EdgeInsets.only(
            left: left, top: top, right: right, bottom: bottom),
        child: this,
      );

  Widget get center => Center(child: this);
  Widget get expanded => Expanded(child: this);
  Widget get flexible => Flexible(child: this);

  Widget opacity(double value) =>
      Opacity(opacity: value.clamp(0.0, 1.0), child: this);

  Widget onTap(VoidCallback onTap) => GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: this,
      );

  Widget visible(bool isVisible) =>
      Visibility(visible: isVisible, child: this);

  Widget sizedBox({double? width, double? height}) =>
      SizedBox(width: width, height: height, child: this);
}

// ════════════════════════════════════════════════════════════════
// ALIGNMENT EXTENSIONS
// ════════════════════════════════════════════════════════════════
// MyWidget().alignTopLeft
// MyWidget().alignBottomCenter
// MyWidget().alignCenterRight
// MyWidget().align(Alignment.center)
extension AlignExtension on Widget {
  Widget align(Alignment alignment) =>
      Align(alignment: alignment, child: this);

  Widget get alignTopLeft => align(Alignment.topLeft);
  Widget get alignTopRight => align(Alignment.topRight);
  Widget get alignTopCenter => align(Alignment.topCenter);
  Widget get alignBottomLeft => align(Alignment.bottomLeft);
  Widget get alignBottomRight => align(Alignment.bottomRight);
  Widget get alignBottomCenter => align(Alignment.bottomCenter);
  Widget get alignCenterLeft => align(Alignment.centerLeft);
  Widget get alignCenterRight => align(Alignment.centerRight);
}

// ════════════════════════════════════════════════════════════════
// CLIP & BORDER EXTENSIONS
// ════════════════════════════════════════════════════════════════
// Image(...).clipRRect(12)
// Avatar(...).clipOval()
// Widget().clipRect()
// Widget().withBorder(radius: 8, color: Colors.grey, width: 1)
extension ClipExtension on Widget {
  Widget clipRRect(double radius) => ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: this,
      );

  Widget clipOval() => ClipOval(child: this);

  Widget clipRect() => ClipRect(child: this);

  Widget withBorder({
    double radius = 8,
    Color color = Colors.grey,
    double width = 1,
  }) =>
      DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: color, width: width),
          borderRadius: BorderRadius.circular(radius),
        ),
        child: this,
      );
}

// ════════════════════════════════════════════════════════════════
// BORDERRADIUS EXTENSIONS (on double)
// ════════════════════════════════════════════════════════════════
// 16.0.allRounded      → BorderRadius.circular(16)
// 16.0.topRounded      → top corners only
// 16.0.bottomRounded   → bottom corners only
// 16.0.leftRounded     → left corners only
// 16.0.rightRounded    → right corners only
// 16.0.pill            → BorderRadius.circular(999) — fully rounded
extension BorderRadiusExtension on double {
  BorderRadius get allRounded => BorderRadius.circular(this);

  BorderRadius get topRounded =>
      BorderRadius.vertical(top: Radius.circular(this));

  BorderRadius get bottomRounded =>
      BorderRadius.vertical(bottom: Radius.circular(this));

  BorderRadius get leftRounded =>
      BorderRadius.horizontal(left: Radius.circular(this));

  BorderRadius get rightRounded =>
      BorderRadius.horizontal(right: Radius.circular(this));

  BorderRadius get pill => BorderRadius.circular(999);
}

// ════════════════════════════════════════════════════════════════
// GRADIENT EXTENSIONS (on List<Color>)
// ════════════════════════════════════════════════════════════════
// [Colors.blue, Colors.purple].toLinearGradient()
// [Colors.orange, Colors.red].toVerticalGradient()
// [Colors.pink, Colors.blue].toRadialGradient()
extension GradientExtension on List<Color> {
  LinearGradient toLinearGradient({
    AlignmentGeometry begin = Alignment.centerLeft,
    AlignmentGeometry end = Alignment.centerRight,
  }) =>
      LinearGradient(colors: this, begin: begin, end: end);

  LinearGradient toVerticalGradient() => LinearGradient(
        colors: this,
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );

  RadialGradient toRadialGradient({double radius = 0.5}) =>
      RadialGradient(colors: this, radius: radius);
}

// ════════════════════════════════════════════════════════════════
// DURATION EXTENSIONS
// ════════════════════════════════════════════════════════════════
// Duration(seconds: 93).timerFormat          → '01:33'
// Duration(hours: 1, seconds: 5).fullTimerFormat → '01:00:05'
// Duration(minutes: 3).readable              → '3 min'
// await Duration(seconds: 2).delay           → pauses execution
extension DurationExtension on Duration {
  String get timerFormat {
    final m = inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  String get fullTimerFormat {
    final h = inHours.toString().padLeft(2, '0');
    final m = inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = inSeconds.remainder(60).toString().padLeft(2, '0');
    return inHours > 0 ? '$h:$m:$s' : '$m:$s';
  }

  String get readable {
    if (inSeconds < 60) return '$inSeconds sec';
    if (inMinutes < 60) return '$inMinutes min';
    if (inHours < 24) return '$inHours hr';
    return '${inDays}d';
  }

  Future<void> get delay => Future.delayed(this);
}

// ════════════════════════════════════════════════════════════════
// MAP EXTENSIONS
// ════════════════════════════════════════════════════════════════
// map.getOrDefault('key', 'fallback')   → value or fallback
// {'a': 1, 'b': null}.withoutNulls      → {'a': 1}
// {'a': 1, 'b': 2}.inverted            → {1: 'a', 2: 'b'}
extension MapExtension<K, V> on Map<K, V> {
  V getOrDefault(K key, V defaultValue) =>
      containsKey(key) ? this[key]! : defaultValue;

  Map<K, V> get withoutNulls =>
      Map.fromEntries(entries.where((e) => e.value != null));

  Map<V, K> get inverted =>
      Map.fromEntries(entries.map((e) => MapEntry(e.value, e.key)));

  bool get isNullOrEmpty => isEmpty;
}

// ════════════════════════════════════════════════════════════════
// BOOL EXTENSIONS
// ════════════════════════════════════════════════════════════════
// true.toggled                                          → false
// isLoggedIn.widget(HomeScreen(), ifFalse: LoginScreen())
//
// bool? nullableBool;
// nullableBool.orFalse   → false
// nullableBool.orTrue    → true
extension BoolExtension on bool {
  bool get toggled => !this;

  Widget widget(Widget ifTrue,
          {Widget ifFalse = const SizedBox.shrink()}) =>
      this ? ifTrue : ifFalse;
}

extension NullableBoolExtension on bool? {
  bool get orFalse => this ?? false;
  bool get orTrue => this ?? true;
}

// ════════════════════════════════════════════════════════════════
// OBJECT EXTENSIONS
// ════════════════════════════════════════════════════════════════
// user.name?.let((n) => 'Hello, $n') ?? 'Hello!'
// container.also((c) => print(c))               → logs and returns container
// widget.applyIf(isSelected, (w) => w.withBorder(color: Colors.blue))
extension ObjectExtension<T> on T {
  R let<R>(R Function(T) block) => block(this);

  T also(void Function(T) block) {
    block(this);
    return this;
  }

  T applyIf(bool condition, T Function(T) block) =>
      condition ? block(this) : this;
}

// ════════════════════════════════════════════════════════════════
// STREAM EXTENSIONS
// ════════════════════════════════════════════════════════════════
// _searchController.stream
//   .debounce(Duration(milliseconds: 400))   → waits 400ms after last event
//   .throttle(Duration(seconds: 1))          → max 1 emit per second
//   .distinctUntilChanged()                  → skips duplicate consecutive values
//   .listen(onSearch);
extension StreamExtension<T> on Stream<T> {
  Stream<T> debounce(Duration duration) {
    Timer? timer;
    late StreamController<T> controller;
    controller = StreamController<T>(
      onListen: () {
        listen(
          (event) {
            timer?.cancel();
            timer = Timer(duration, () => controller.add(event));
          },
          onError: controller.addError,
          onDone: () {
            timer?.cancel();
            controller.close();
          },
        );
      },
    );
    return controller.stream;
  }

  Stream<T> throttle(Duration duration) {
    var lastEmit = DateTime.fromMillisecondsSinceEpoch(0);
    return where((_) {
      final now = DateTime.now();
      if (now.difference(lastEmit) >= duration) {
        lastEmit = now;
        return true;
      }
      return false;
    });
  }

  Stream<T> distinctUntilChanged() {
    T? previous;
    var hasPrevious = false;
    return where((event) {
      if (!hasPrevious || previous != event) {
        previous = event;
        hasPrevious = true;
        return true;
      }
      return false;
    });
  }
}

// ════════════════════════════════════════════════════════════════
// FUTURE EXTENSIONS
// ════════════════════════════════════════════════════════════════
// await fetchData().withMinDelay(Duration(milliseconds: 400))
//   → ensures at least 400ms passes (prevents loading flash)
//
// final user = await getUser().orNull
//   → returns null instead of throwing on error
extension FutureExtension<T> on Future<T> {
  Future<T> withMinDelay(Duration min) async {
    final results = await Future.wait([this, Future.delayed(min)]);
    return results[0] as T;
  }

  Future<T?> get orNull =>
      then<T?>((v) => v).catchError((_) => null);
}

// ════════════════════════════════════════════════════════════════
// SCROLLCONTROLLER EXTENSIONS
// ════════════════════════════════════════════════════════════════
// _scrollController.isAtTop         → true/false
// _scrollController.isAtBottom      → true/false
// _scrollController.scrollToTop()
// _scrollController.scrollToBottom()
extension ScrollControllerExtension on ScrollController {
  bool get isAtTop => offset <= 0;
  bool get isAtBottom => offset >= position.maxScrollExtent;

  void scrollToTop({
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeOut,
  }) =>
      animateTo(0, duration: duration, curve: curve);

  void scrollToBottom({
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeOut,
  }) =>
      animateTo(position.maxScrollExtent, duration: duration, curve: curve);
}

// ════════════════════════════════════════════════════════════════
// PAGECONTROLLER EXTENSIONS
// ════════════════════════════════════════════════════════════════
// _pageController.currentPageIndex   → 0-based int
// _pageController.isOnFirstPage      → true/false
// _pageController.nextPage()
// _pageController.previousPage()
// _pageController.jumpToFirst()
extension PageControllerExtension on PageController {
  int get currentPageIndex => page?.round() ?? 0;

  bool get isOnFirstPage => currentPageIndex == 0;

  void nextPage({
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) =>
      animateToPage(currentPageIndex + 1, duration: duration, curve: curve);

  void previousPage({
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) =>
      animateToPage(currentPageIndex - 1, duration: duration, curve: curve);

  void jumpToFirst() => jumpToPage(0);
}

// ════════════════════════════════════════════════════════════════
// TEXTEDITING CONTROLLER EXTENSIONS
// ════════════════════════════════════════════════════════════════
// _nameController.hasText             → true if non-empty/non-blank
// _nameController.trimmedText         → text without leading/trailing spaces
// _nameController.isEmpty             → true if empty
// _nameController.moveCursorToEnd()   → moves cursor to end of text
// _nameController.clearText()         → clears and notifies
extension TextEditingControllerExtension on TextEditingController {
  void moveCursorToEnd() {
    selection =
        TextSelection.fromPosition(TextPosition(offset: text.length));
  }

  String get trimmedText => text.trim();
  bool get hasText => text.trim().isNotEmpty;
  bool get isEmpty => text.isEmpty;

  void clearText() {
    clear();
  }
}

// ════════════════════════════════════════════════════════════════
// FORMSTATE EXTENSIONS
// ════════════════════════════════════════════════════════════════
// if (_formKey.validateAndSave()) submitForm();
// _formKey.resetForm();
extension FormStateExtension on GlobalKey<FormState> {
  bool validateAndSave() {
    final form = currentState;
    if (form == null) return false;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void resetForm() => currentState?.reset();
}

// ════════════════════════════════════════════════════════════════
// FOCUSNODE EXTENSIONS
// ════════════════════════════════════════════════════════════════
// _emailFocus.requestNextFocus(context, _passwordFocus)
// _emailFocus.unfocusAndHideKeyboard(context)
extension FocusNodeExtension on FocusNode {
  void requestNextFocus(BuildContext context, FocusNode next) {
    unfocus();
    FocusScope.of(context).requestFocus(next);
  }

  void unfocusAndHideKeyboard(BuildContext context) {
    unfocus();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }
}

// ════════════════════════════════════════════════════════════════
// ANIMATIONCONTROLLER EXTENSIONS
// ════════════════════════════════════════════════════════════════
// _controller.toggle()   → forward if idle, reverse if complete
// _controller.replay()   → reset then forward
extension AnimationControllerExtension on AnimationController {
  void toggle() => isCompleted ? reverse() : forward();

  void replay() {
    reset();
    forward();
  }
}

// ════════════════════════════════════════════════════════════════
// EDGEINSETS EXTENSIONS
// ════════════════════════════════════════════════════════════════
// padding.addBottom(context.bottomBarHeight)
// padding.addTop(context.statusBarHeight)
extension EdgeInsetsExtension on EdgeInsets {
  EdgeInsets addBottom(double value) => copyWith(bottom: bottom + value);
  EdgeInsets addTop(double value) => copyWith(top: top + value);
}

// ════════════════════════════════════════════════════════════════
// FILE EXTENSIONS
// ════════════════════════════════════════════════════════════════
// file.name                    → 'profile.jpg'
// file.extension               → 'jpg'
// file.nameWithoutExtension    → 'profile'
// file.isImage                 → true
// file.isVideo                 → false
// file.isPdf                   → false
// await file.sizeFormatted     → '1.2 MB'
extension FileExtension on File {
  String get name => path.split('/').last;
  String get extension =>
      name.contains('.') ? name.split('.').last : '';
  String get nameWithoutExtension =>
      name.contains('.') ? name.substring(0, name.lastIndexOf('.')) : name;

  bool get isImage => [
        'jpg', 'jpeg', 'png', 'gif', 'webp', 'bmp',
      ].contains(extension.toLowerCase());

  bool get isVideo =>
      ['mp4', 'mov', 'avi', 'mkv', 'webm']
          .contains(extension.toLowerCase());

  bool get isPdf => extension.toLowerCase() == 'pdf';

  Future<String> get sizeFormatted async {
    final bytes = await length();
    return bytes.toFileSize;
  }
}

// ════════════════════════════════════════════════════════════════
// ENUM EXTENSIONS
// ════════════════════════════════════════════════════════════════
// LoaderState.loading.label              → 'Loading'
// OrderStatus.orderPlaced.label          → 'Order placed'
// status.isAny([Status.pending, Status.processing])  → true/false
extension EnumExtension on Enum {
  String get label => name.camelToSentence.capitalize;

  bool isAny(List<Enum> values) => values.contains(this);
}

// ════════════════════════════════════════════════════════════════
// SIZE & OFFSET EXTENSIONS
// ════════════════════════════════════════════════════════════════
// size.isPortrait     → true if height > width
// size.isLandscape    → true if width > height
// size.aspectRatio    → width / height
// size.center         → Offset(width/2, height/2)
// offsetA.distanceTo(offsetB)  → squared distance
extension SizeExtension on Size {
  bool get isPortrait => height > width;
  bool get isLandscape => width > height;
  double get aspectRatio => width / height;
  Offset get center => Offset(width / 2, height / 2);
}

extension OffsetExtension on Offset {
  double distanceTo(Offset other) {
    final dx = this.dx - other.dx;
    final dy = this.dy - other.dy;
    return (dx * dx + dy * dy);
  }
}

// ════════════════════════════════════════════════════════════════
// PLATFORM EXTENSION
// ════════════════════════════════════════════════════════════════
// PlatformExtension.isApple      → true on iOS / macOS
// PlatformExtension.isGoogle     → true on Android
// PlatformExtension.isDesktopOS  → true on macOS / Windows / Linux
extension PlatformExtension on Platform {
  static bool get isApple => Platform.isIOS || Platform.isMacOS;
  static bool get isGoogle => Platform.isAndroid;
  static bool get isDesktopOS =>
      Platform.isMacOS || Platform.isWindows || Platform.isLinux;
}

extension ShimmerEffect on Widget {
  Widget showShimmer() {
    return CommonLatestShimmer(child: this);
  }
}