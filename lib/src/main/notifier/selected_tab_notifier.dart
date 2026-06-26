// lib/src/main/notifier/selected_tab_notifier.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_tab_notifier.g.dart';

@Riverpod(keepAlive: false)
class SelectedTabNotifier extends _$SelectedTabNotifier {
  @override
  int build() => 0;

  void setTab(int index) => state = index;
}
