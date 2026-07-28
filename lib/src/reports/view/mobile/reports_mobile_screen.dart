// lib/src/reports/view/reports_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thuga/res/constants/string_constants.dart';
import 'package:thuga/res/styles/color_palette.dart';
import 'package:thuga/utils/common_widgets/common_app_bar.dart';
import 'package:thuga/utils/common_widgets/common_refresh_indicator.dart';
import 'package:thuga/utils/common_widgets/common_scaffold.dart';
import 'package:thuga/utils/common_widgets/common_switch_state.dart';
import '../../notifier/reports_notifier.dart';
import '../widget/reports_content_widget.dart';

class ReportsMobileScreen extends ConsumerWidget {
  const ReportsMobileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.appColors;
    final loaderState = ref.watch(
      reportsProvider.select((s) => s.loaderState),
    );
    final data = ref.watch(reportsProvider.select((s) => s.data));

    return CommonScaffold(
      backgroundColor: colors.background,
      appBar: CommonAppBar(title: Strings.reportsTitle, showBackButton: false),
      body: CommonRefreshIndicator(
        onRefresh: () =>
            ref.read(reportsProvider.notifier).fetchReportsData(),
        child: CommonSwitchState(
          loaderState: loaderState,
          reload: () =>
              ref.read(reportsProvider.notifier).fetchReportsData(),
          child: ReportsContentWidget(data: data),
        ),
      ),
    );
  }
}
