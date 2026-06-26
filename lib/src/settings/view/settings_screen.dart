// lib/src/settings/view/settings_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vyapapp/res/constants/string_constants.dart';
import 'package:vyapapp/res/styles/color_palette.dart';
import 'package:vyapapp/utils/common_widgets/common_app_bar.dart';
import 'package:vyapapp/utils/common_widgets/common_scaffold.dart';
import 'package:vyapapp/utils/common_widgets/common_switch_state.dart';
import '../notifier/settings_notifier.dart';
import 'widget/settings_content_widget.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.appColors;
    final loaderState = ref.watch(settingsNotifierProvider.select((s) => s.loaderState));
    final settings = ref.watch(settingsNotifierProvider.select((s) => s.settings));

    return CommonScaffold(
      backgroundColor: colors.background,
      appBar: CommonAppBar(
        title: Strings.settingsTitle,
        showBackButton: false,
      ),
      body: CommonSwitchState(
        loaderState: loaderState,
        reload: () => ref.read(settingsNotifierProvider.notifier).fetchSettings(),
        child: SettingsContentWidget(settings: settings),
      ),
    );
  }
}
