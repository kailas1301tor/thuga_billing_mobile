// lib/src/home/view/mobile/home_mobile_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thuga/res/styles/color_palette.dart';
import 'package:thuga/utils/common_widgets/common_refresh_indicator.dart';
import 'package:thuga/utils/common_widgets/common_scaffold.dart';
import 'package:thuga/utils/common_widgets/common_switch_state.dart';

import '../../notifier/home_notifier.dart';
import '../widget/home_content_widget.dart';

class HomeMobileScreen extends ConsumerStatefulWidget {
  const HomeMobileScreen({super.key});

  @override
  ConsumerState<HomeMobileScreen> createState() => _HomeMobileScreenState();
}

class _HomeMobileScreenState extends ConsumerState<HomeMobileScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(homeProvider.notifier).fetchDashboard();
    });
  }

  @override
  Widget build(BuildContext context) {
    final loaderState = ref.watch(
      homeProvider.select((s) => s.loaderState),
    );
    final data = ref.watch(homeProvider.select((s) => s.data));
    final greetingPrefix = ref.watch(
      homeProvider.select((s) => s.greetingPrefix ?? ''),
    );

    return CommonScaffold(
      backgroundColor: context.appColors.background,
      enableFadeIn: false,
      body: CommonSwitchState(
        loaderState: loaderState,
        reload: () => ref.read(homeProvider.notifier).fetchDashboard(),
        child: CommonRefreshIndicator(
          onRefresh: () =>
              ref.read(homeProvider.notifier).fetchDashboard(),
          child: HomeContentWidget(
            data: data,
            greetingPrefix: greetingPrefix,
          ),
        ),
      ),
    );
  }
}
