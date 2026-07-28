// lib/src/reports/view/web/reports_web_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thuga/res/constants/string_constants.dart';
import 'package:thuga/utils/common_widgets/common_switch_state.dart';
import 'package:thuga/utils/common_widgets/web/web_page_layout.dart';

import '../../notifier/reports_notifier.dart';
import '../widget/reports_content_widget.dart';

class ReportsWebScreen extends ConsumerWidget {
  const ReportsWebScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loaderState = ref.watch(
      reportsProvider.select((s) => s.loaderState),
    );
    final data = ref.watch(reportsProvider.select((s) => s.data));

    return CommonSwitchState(
      loaderState: loaderState,
      reload: () => ref.read(reportsProvider.notifier).fetchReportsData(),
      child: WebPageLayout(
        title: Strings.reportsTitle,
        child: ReportsContentWidget(
          data: data,
          embeddedInParentScroll: true,
        ),
      ),
    );
  }
}
