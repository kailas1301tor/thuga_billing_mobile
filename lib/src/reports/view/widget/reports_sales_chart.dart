// lib/src/reports/view/widget/reports_sales_chart.dart
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vyapapp/res/styles/color_palette.dart';
import 'package:vyapapp/res/styles/font_palette.dart';
import 'package:vyapapp/utils/common_widgets/common_container.dart';
import '../../model/reports_model.dart';

class ReportsSalesChart extends StatelessWidget {
  const ReportsSalesChart({
    super.key,
    required this.chartData,
  });

  final List<ChartDataPoint> chartData;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return CommonContainer(
      padding: EdgeInsets.all(16.r),
      borderRadius: 20.r,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sales Analytics',
            style: FontPalette.base700(14, color: colors.primaryText),
          ),
          20.verticalSpace,
          SizedBox(
            height: 180.h,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return CustomPaint(
                  size: Size(constraints.maxWidth, constraints.maxHeight),
                  painter: _BarChartPainter(
                    data: chartData,
                    primaryColor: colors.primary,
                    gridColor: colors.inputBorder,
                    labelStyle: FontPalette.base500(9, color: colors.secondaryText),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _BarChartPainter extends CustomPainter {
  final List<ChartDataPoint> data;
  final Color primaryColor;
  final Color gridColor;
  final TextStyle labelStyle;

  _BarChartPainter({
    required this.data,
    required this.primaryColor,
    required this.gridColor,
    required this.labelStyle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final double maxVal = data.map((d) => d.value).reduce(max);
    final double limitMax = maxVal == 0 ? 100.0 : maxVal * 1.15;

    // Chart margins
    final double leftMargin = 38.w;
    final double bottomMargin = 20.h;

    final double chartWidth = size.width - leftMargin;
    final double chartHeight = size.height - bottomMargin;

    // Paints
    final gridPaint = Paint()
      ..color = gridColor
      ..strokeWidth = 1.w
      ..style = PaintingStyle.stroke;

    final axisPaint = Paint()
      ..color = gridColor
      ..strokeWidth = 1.5.w
      ..style = PaintingStyle.stroke;

    // 1. Draw 3 Horizontal Grid lines and Y-axis labels
    final int gridLinesCount = 3;
    for (int i = 0; i <= gridLinesCount; i++) {
      final double y = chartHeight - (i * (chartHeight / gridLinesCount));
      // Grid line
      canvas.drawLine(
        Offset(leftMargin, y),
        Offset(size.width, y),
        gridPaint,
      );

      // Label text
      final double gridValue = (i * (limitMax / gridLinesCount));
      final labelText = '₹${gridValue.toStringAsFixed(0)}';
      final textPainter = TextPainter(
        text: TextSpan(text: labelText, style: labelStyle),
        textDirection: TextDirection.ltr,
      )..layout();

      textPainter.paint(
        canvas,
        Offset(leftMargin - textPainter.width - 6.w, y - (textPainter.height / 2)),
      );
    }

    // 2. Draw X-axis line
    canvas.drawLine(
      Offset(leftMargin, chartHeight),
      Offset(size.width, chartHeight),
      axisPaint,
    );

    // 3. Draw Bars & X-axis labels
    final double xAxisSpacing = chartWidth / data.length;
    final double barWidth = xAxisSpacing * 0.4;

    for (int i = 0; i < data.length; i++) {
      final item = data[i];

      // Calculate coordinates
      final double barCenterX = leftMargin + (i * xAxisSpacing) + (xAxisSpacing / 2);
      final double barHeight = (item.value / limitMax) * chartHeight;
      final double top = chartHeight - barHeight;

      // Draw Bar with Gradient
      final barRect = RRect.fromRectAndCorners(
        Rect.fromLTRB(
          barCenterX - (barWidth / 2),
          top,
          barCenterX + (barWidth / 2),
          chartHeight,
        ),
        topLeft: Radius.circular(4.r),
        topRight: Radius.circular(4.r),
      );

      final barPaint = Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            primaryColor,
            primaryColor.withValues(alpha: 0.25),
          ],
        ).createShader(barRect.outerRect)
        ..style = PaintingStyle.fill;

      canvas.drawRRect(barRect, barPaint);

      // Draw X-axis label
      final textPainter = TextPainter(
        text: TextSpan(text: item.label, style: labelStyle),
        textDirection: TextDirection.ltr,
      )..layout();

      textPainter.paint(
        canvas,
        Offset(barCenterX - (textPainter.width / 2), chartHeight + 6.h),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _BarChartPainter oldDelegate) {
    return oldDelegate.data != data ||
        oldDelegate.primaryColor != primaryColor ||
        oldDelegate.gridColor != gridColor;
  }
}
