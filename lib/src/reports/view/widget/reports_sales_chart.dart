// lib/src/reports/view/widget/reports_sales_chart.dart
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vyapapp/res/styles/color_palette.dart';
import 'package:vyapapp/res/styles/font_palette.dart';
import 'package:vyapapp/utils/common_widgets/common_container.dart';
import 'package:vyapapp/utils/helpers/date_formatter.dart';
import '../../model/reports_model.dart';

class ReportsSalesChart extends StatelessWidget {
  const ReportsSalesChart({super.key, this.chartData});

  final List<ChartDataPoint>? chartData;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final data = chartData ?? [];

    if (data.isEmpty) {
      return const SizedBox.shrink();
    }

    final double maxVal = data.map((d) => d.value).reduce(max);
    final double limitMax = maxVal == 0 ? 100.0 : maxVal * 1.15;

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
                final double leftMargin = 38.w;
                final double availableWidth = constraints.maxWidth - leftMargin;
                final double barSpacing = 48.w;
                final double scrollWidth = max(availableWidth, data.length * barSpacing);

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Fixed Y-Axis Labels
                    CustomPaint(
                      size: Size(leftMargin, constraints.maxHeight),
                      painter: _YAxisPainter(
                        limitMax: limitMax,
                        labelStyle: FontPalette.base500(9, color: colors.secondaryText),
                      ),
                    ),
                    // Scrollable Chart Area
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: CustomPaint(
                          size: Size(scrollWidth, constraints.maxHeight),
                          painter: _ScrollableChartPainter(
                            data: data,
                            limitMax: limitMax,
                            primaryColor: colors.primary,
                            gridColor: colors.inputBorder,
                            labelStyle: FontPalette.base500(9, color: colors.secondaryText),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _YAxisPainter extends CustomPainter {
  final double limitMax;
  final TextStyle labelStyle;

  _YAxisPainter({
    required this.limitMax,
    required this.labelStyle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double bottomMargin = 20.h;
    final double chartHeight = size.height - bottomMargin;
    final int gridLinesCount = 3;

    for (int i = 0; i <= gridLinesCount; i++) {
      final double y = chartHeight - (i * (chartHeight / gridLinesCount));
      final double gridValue = (i * (limitMax / gridLinesCount));
      final labelText = '₹${gridValue.toStringAsFixed(0)}';

      final textPainter = TextPainter(
        text: TextSpan(text: labelText, style: labelStyle),
        textDirection: TextDirection.ltr,
      )..layout();

      textPainter.paint(
        canvas,
        Offset(
          size.width - textPainter.width - 6.w,
          y - (textPainter.height / 2),
        ),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _YAxisPainter oldDelegate) {
    return oldDelegate.limitMax != limitMax || oldDelegate.labelStyle != labelStyle;
  }
}

class _ScrollableChartPainter extends CustomPainter {
  final List<ChartDataPoint> data;
  final double limitMax;
  final Color primaryColor;
  final Color gridColor;
  final TextStyle labelStyle;

  _ScrollableChartPainter({
    required this.data,
    required this.limitMax,
    required this.primaryColor,
    required this.gridColor,
    required this.labelStyle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final double bottomMargin = 20.h;
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

    // 1. Draw horizontal grid lines
    final int gridLinesCount = 3;
    for (int i = 0; i <= gridLinesCount; i++) {
      final double y = chartHeight - (i * (chartHeight / gridLinesCount));
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // 2. Draw X-axis line
    canvas.drawLine(
      Offset(0, chartHeight),
      Offset(size.width, chartHeight),
      axisPaint,
    );

    // 3. Draw Bars & X-axis labels
    final double xAxisSpacing = size.width / data.length;
    final double barWidth = min(xAxisSpacing * 0.4, 24.w);

    for (int i = 0; i < data.length; i++) {
      final item = data[i];

      final double barCenterX = (i * xAxisSpacing) + (xAxisSpacing / 2);
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
          colors: [primaryColor, primaryColor.withValues(alpha: 0.25)],
        ).createShader(barRect.outerRect)
        ..style = PaintingStyle.fill;

      canvas.drawRRect(barRect, barPaint);

      // Draw X-axis label for every single date
      String labelText = item.label;
      final parsedDate = DateTime.tryParse(item.label);
      if (parsedDate != null) {
        labelText = formatDate(parsedDate, pattern: 'dd MMM');
      }

      final textPainter = TextPainter(
        text: TextSpan(text: labelText, style: labelStyle),
        textDirection: TextDirection.ltr,
      )..layout();

      textPainter.paint(
        canvas,
        Offset(barCenterX - (textPainter.width / 2), chartHeight + 6.h),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _ScrollableChartPainter oldDelegate) {
    return oldDelegate.data != data ||
        oldDelegate.limitMax != limitMax ||
        oldDelegate.primaryColor != primaryColor ||
        oldDelegate.gridColor != gridColor ||
        oldDelegate.labelStyle != labelStyle;
  }
}
