// lib/src/home/view/widget/home_shimmer_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vyapapp/utils/common_widgets/common_shimmer_box.dart';

class HomeShimmerWidget extends StatelessWidget {
  const HomeShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Column(
        children: [
          CommonShimmerBox(width: double.infinity, height: 48.h),
          16.verticalSpace,
          CommonShimmerBox(width: double.infinity, height: 80.h),
          16.verticalSpace,
          CommonShimmerBox(width: double.infinity, height: 140.h),
          16.verticalSpace,
          Row(
            children: [
              Expanded(child: CommonShimmerBox(height: 100.h)),
              10.horizontalSpace,
              Expanded(child: CommonShimmerBox(height: 100.h)),
              10.horizontalSpace,
              Expanded(child: CommonShimmerBox(height: 100.h)),
            ],
          ),
          24.verticalSpace,
          CommonShimmerBox(width: double.infinity, height: 120.h),
        ],
      ),
    );
  }
}
