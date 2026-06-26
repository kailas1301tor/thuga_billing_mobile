// lib/src/reports/view/reports_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vyapapp/res/constants/string_constants.dart';
import 'package:vyapapp/res/styles/color_palette.dart';
import 'package:vyapapp/utils/common_widgets/common_app_bar.dart';
import 'package:vyapapp/utils/common_widgets/common_scaffold.dart';
import 'package:vyapapp/utils/common_widgets/common_switch_state.dart';
import '../notifier/reports_notifier.dart';
import 'widget/reports_content_widget.dart';

class ReportsScreen extends ConsumerWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.appColors;
    final loaderState = ref.watch(reportsNotifierProvider.select((s) => s.loaderState));
    final data = ref.watch(reportsNotifierProvider.select((s) => s.data));

    return CommonScaffold(
      backgroundColor: colors.background,
      appBar: CommonAppBar(
        title: Strings.reportsTitle,
        showBackButton: false,
      ),
      body: CommonSwitchState(
        loaderState: loaderState,
        reload: () => ref.read(reportsNotifierProvider.notifier).fetchReportsData(),
        child: data == null
            ? const SizedBox.shrink()
            : ReportsContentWidget(data: data),
      ),
    );
  }
}
