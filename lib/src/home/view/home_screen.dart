// lib/src/home/view/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vyapapp/res/styles/color_palette.dart';
import 'package:vyapapp/utils/common_widgets/common_refresh_indicator.dart';
import 'package:vyapapp/utils/common_widgets/common_scaffold.dart';
import 'package:vyapapp/utils/common_widgets/common_switch_state.dart';

import '../notifier/home_notifier.dart';
import 'widget/home_content_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(homeNotifierProvider.notifier).fetchDashboard();
    });
  }

  @override
  Widget build(BuildContext context) {
    final loaderState = ref.watch(
      homeNotifierProvider.select((s) => s.loaderState),
    );
    final data = ref.watch(homeNotifierProvider.select((s) => s.data));
    final greetingPrefix = ref.watch(
      homeNotifierProvider.select((s) => s.greetingPrefix ?? ''),
    );

    return CommonScaffold(
      backgroundColor: context.appColors.background,
      enableFadeIn: false,
      body: CommonSwitchState(
        loaderState: loaderState,
        reload: () => ref.read(homeNotifierProvider.notifier).fetchDashboard(),
        // loader: const HomeShimmerWidget(),
        child: CommonRefreshIndicator(
          onRefresh: () =>
              ref.read(homeNotifierProvider.notifier).fetchDashboard(),
          child: HomeContentWidget(data: data, greetingPrefix: greetingPrefix),
        ),
      ),
    );
  }
}
