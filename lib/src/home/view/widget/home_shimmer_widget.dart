// lib/src/home/view/widget/home_shimmer_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thuga/utils/common_widgets/common_shimmer_box.dart';

class HomeShimmerWidget extends StatelessWidget {
  const HomeShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonShimmerBox(width: 40.r, height: 40.r, borderRadius: 20),
              CommonShimmerBox(width: 100.w, height: 24.h, borderRadius: 6),
              CommonShimmerBox(width: 40.r, height: 40.r, borderRadius: 20),
            ],
          ),
          24.verticalSpace,

          // Greeting Row
          CommonShimmerBox(width: 180.w, height: 28.h, borderRadius: 6),
          20.verticalSpace,

          // Today's Sales Card
          CommonShimmerBox(width: double.infinity, height: 180.h, borderRadius: 24),
          20.verticalSpace,

          // Stats Row
          Row(
            children: [
              Expanded(child: CommonShimmerBox(height: 112.h, borderRadius: 16)),
              12.horizontalSpace,
              Expanded(child: CommonShimmerBox(height: 112.h, borderRadius: 16)),
              12.horizontalSpace,
              Expanded(child: CommonShimmerBox(height: 112.h, borderRadius: 16)),
            ],
          ),
          28.verticalSpace,

          // Top Products Section Title
          CommonShimmerBox(width: 150.w, height: 20.h, borderRadius: 6),
          12.verticalSpace,

          // Top Products list
          for (int i = 0; i < 3; i++) ...[
            CommonShimmerBox(width: double.infinity, height: 76.h, borderRadius: 16),
            10.verticalSpace,
          ],
          20.verticalSpace,

          // Recent Bills Section Title
          CommonShimmerBox(width: 120.w, height: 20.h, borderRadius: 6),
          12.verticalSpace,

          // Recent Bills list
          for (int i = 0; i < 3; i++) ...[
            CommonShimmerBox(width: double.infinity, height: 76.h, borderRadius: 16),
            10.verticalSpace,
          ],
        ],
      ),
    );
  }
}
