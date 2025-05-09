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
    final backgroundColor = isDark ? Colors.grey[900] : Colors.white;
    final cardColor = isDark ? Colors.grey[800] : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;
    final secondaryTextColor = isDark ? Colors.grey[400] : Colors.grey[600];
    final gridColor = isDark ? Colors.grey[700] : Colors.grey[200];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Statistik',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              backgroundColor!,
              isDark ? Colors.grey[850]! : Colors.grey[50]!,
            ],
          ),
        ),
        child: SingleChildScrollView(
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
                      'assets/icons/total.png',
                      controller.totalHabits,
                      cardColor: cardColor,
                      textColor: textColor,
                      secondaryTextColor: secondaryTextColor,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildInfoCard(
                      'Selesai Hari Ini',
                      'assets/icons/check.png',
                      controller.completedToday,
                      cardColor: cardColor,
                      textColor: textColor,
                      secondaryTextColor: secondaryTextColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildInfoCard(
                'Streak Terpanjang',
                'assets/icons/fire.png',
                controller.longestStreak,
                isFullWidth: true,
                cardColor: cardColor,
                textColor: textColor,
                secondaryTextColor: secondaryTextColor,
              ),
              const SizedBox(height: 32),

              // Chart Title
              Text(
                'Statistik 7 Hari Terakhir',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 16),

              // Bar Chart
              SizedBox(
                height: 300,
                child: Obx(() => controller.barGroups.isEmpty
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Get.theme.colorScheme.primary,
                        ),
                      )
                    : BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceAround,
                          maxY: 20,
                          barTouchData: BarTouchData(
                            touchTooltipData: BarTouchTooltipData(
                              tooltipBgColor:
                                  isDark ? Colors.grey[800] : Colors.grey[700],
                              getTooltipItem:
                                  (group, groupIndex, rod, rodIndex) {
                                return BarTooltipItem(
                                  '${rod.toY.toInt()} Habits',
                                  const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              },
                            ),
                            touchCallback: (event, response) {
                              if (response?.spot != null) {
                                controller.showBarTooltip(
                                    response!.spot!.touchedBarGroupIndex);
                              } else {
                                controller.hideBarTooltip();
                              }
                            },
                          ),
                          titlesData: FlTitlesData(
                            show: true,
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  const days = [
                                    'Sen',
                                    'Sel',
                                    'Rab',
                                    'Kam',
                                    'Jum',
                                    'Sab',
                                    'Min'
                                  ];
                                  return Text(
                                    days[value.toInt()],
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: secondaryTextColor,
                                    ),
                                  );
                                },
                              ),
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 40,
                                getTitlesWidget: (value, meta) {
                                  return Text(
                                    value.toInt().toString(),
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: secondaryTextColor,
                                    ),
                                  );
                                },
                              ),
                            ),
                            topTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            rightTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                          ),
                          borderData: FlBorderData(show: false),
                          gridData: FlGridData(
                            show: true,
                            drawVerticalLine: false,
                            horizontalInterval: 5,
                            getDrawingHorizontalLine: (value) {
                              return FlLine(
                                color: gridColor,
                                strokeWidth: 1,
                              );
                            },
                          ),
                          barGroups: controller.barGroups,
                        ),
                      )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(
    String title,
    String iconPath,
    RxInt value, {
    bool isFullWidth = false,
    Color? cardColor,
    Color? textColor,
    Color? secondaryTextColor,
  }) {
    return Card(
      elevation: 2,
      color: cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: isFullWidth ? double.infinity : null,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  iconPath,
                  width: 24,
                  height: 24,
                  color: secondaryTextColor,
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: secondaryTextColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Obx(() => Text(
                  value.toString(),
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
