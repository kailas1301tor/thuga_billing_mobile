// lib/src/settings/view/web/settings_web_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thuga/res/constants/string_constants.dart';
import 'package:thuga/utils/common_widgets/common_switch_state.dart';
import 'package:thuga/utils/common_widgets/web/web_page_layout.dart';

import '../../notifier/settings_notifier.dart';
import '../widget/settings_content_widget.dart';

class SettingsWebScreen extends ConsumerWidget {
  const SettingsWebScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loaderState = ref.watch(
      settingsProvider.select((s) => s.loaderState),
    );
    final settings = ref.watch(settingsProvider.select((s) => s.settings));

    return CommonSwitchState(
      loaderState: loaderState,
      reload: () => ref.read(settingsProvider.notifier).fetchSettings(),
      child: WebPageLayout(
        title: Strings.settingsTitle,
        onRefresh: () => ref.read(settingsProvider.notifier).fetchSettings(),
        child: SettingsContentWidget(
          settings: settings,
          embeddedInParentScroll: true,
        ),
      ),
    );
  }
}
