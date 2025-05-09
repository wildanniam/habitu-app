import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';

import '../controllers/statistics_controller.dart';

class StatisticsView extends GetView<StatisticsController> {
  const StatisticsView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Get.isDarkMode;
    final backgroundColor = isDark ? Colors.grey[900]! : Colors.white;
    final cardColor = isDark ? Colors.grey[800]! : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;
    final secondaryTextColor = isDark ? Colors.white70 : Colors.black54;
    final gridColor = isDark ? Colors.grey[700]! : Colors.grey[300]!;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          'Statistik',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
        backgroundColor: backgroundColor,
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.totalHabits.value == 0) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.bar_chart,
                  size: 64,
                  color: secondaryTextColor,
                ),
                const SizedBox(height: 16),
                Text(
                  'Belum ada habit yang ditambahkan',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: secondaryTextColor,
                  ),
                ),
              ],
            ),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Info Cards
              Row(
                children: [
                  Expanded(
                    child: _buildInfoCard(
                      'Total Habit',
                      controller.totalHabits.value.toString(),
                      Icons.list_alt,
                      Colors.blue,
                      cardColor,
                      textColor,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildInfoCard(
                      'Selesai Hari Ini',
                      controller.completedToday.value.toString(),
                      Icons.check_circle,
                      Colors.green,
                      cardColor,
                      textColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: _buildInfoCard(
                      'Streak Terpanjang',
                      controller.longestStreak.value.toString(),
                      Icons.local_fire_department,
                      Colors.orange,
                      cardColor,
                      textColor,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildInfoCard(
                      'Tingkat Penyelesaian',
                      '${controller.completionRate.value.toStringAsFixed(1)}%',
                      Icons.percent,
                      Colors.purple,
                      cardColor,
                      textColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Period Selector
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Grafik Aktivitas',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                  DropdownButton<String>(
                    value: controller.selectedPeriod.value,
                    items: controller.periodOptions.map((period) {
                      return DropdownMenuItem(
                        value: period,
                        child: Text(
                          period,
                          style: GoogleFonts.poppins(
                            color: textColor,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        controller.changePeriod(value);
                      }
                    },
                    style: GoogleFonts.poppins(
                      color: textColor,
                    ),
                    dropdownColor: cardColor,
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Bar Chart
              Container(
                height: 300,
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Obx(() {
                  if (controller.barGroups.isEmpty) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Get.theme.colorScheme.primary,
                      ),
                    );
                  }

                  return BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: 100,
                      minY: 0,
                      barTouchData: BarTouchData(
                        enabled: true,
                        touchTooltipData: BarTouchTooltipData(
                          tooltipBgColor: cardColor,
                          tooltipPadding: const EdgeInsets.all(8),
                          tooltipMargin: 8,
                          getTooltipItem: (group, groupIndex, rod, rodIndex) {
                            return BarTooltipItem(
                              '${controller.getFormattedPercentage(rod.toY)}\n${controller.getFormattedDate(groupIndex)}',
                              GoogleFonts.poppins(
                                color: textColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            );
                          },
                        ),
                      ),
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              if (value.toInt() >=
                                  controller.barGroups.length) {
                                return const SizedBox();
                              }
                              return Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  controller.getFormattedDate(value.toInt()),
                                  style: GoogleFonts.poppins(
                                    color: secondaryTextColor,
                                    fontSize: 12,
                                  ),
                                ),
                              );
                            },
                            reservedSize: 30,
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              if (value == 0) return const SizedBox();
                              return Text(
                                '${value.toInt()}%',
                                style: GoogleFonts.poppins(
                                  color: secondaryTextColor,
                                  fontSize: 12,
                                ),
                              );
                            },
                            reservedSize: 40,
                            interval: 20,
                          ),
                        ),
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      borderData: FlBorderData(
                        show: true,
                        border: Border(
                          bottom: BorderSide(color: gridColor),
                          left: BorderSide(color: gridColor),
                        ),
                      ),
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        horizontalInterval: 20,
                        getDrawingHorizontalLine: (value) {
                          return FlLine(
                            color: gridColor,
                            strokeWidth: 1,
                            dashArray: [5, 5],
                          );
                        },
                      ),
                      barGroups: controller.barGroups,
                    ),
                  );
                }),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildInfoCard(
    String title,
    String value,
    IconData icon,
    Color iconColor,
    Color cardColor,
    Color textColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: iconColor,
                size: 16,
              ),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: textColor.withOpacity(0.7),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
