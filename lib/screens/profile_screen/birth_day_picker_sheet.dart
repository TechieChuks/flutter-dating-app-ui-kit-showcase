import 'package:datingapp/theme/app_colors.dart';
import 'package:datingapp/theme/app_text_styles.dart';
import 'package:datingapp/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class BirthdayPickerSheet extends StatefulWidget {
  final String? initialValue;

  const BirthdayPickerSheet({super.key, this.initialValue});

  @override
  State<BirthdayPickerSheet> createState() => _BirthdayPickerSheetState();
}

class _BirthdayPickerSheetState extends State<BirthdayPickerSheet> {
  int selectedYear = DateTime.now().year - 20;
  int selectedDay = 1;
  int selectedMonth = 0;

  final List<String> months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];

  int daysInMonth(int year, int monthIndex) {
    if (monthIndex == 1) {
      bool leap = (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
      return leap ? 29 : 28;
    }

    const days = [31, -1, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

    return days[monthIndex];
  }

  void changeMonth(bool forward) {
    setState(() {
      if (forward) {
        selectedMonth = (selectedMonth + 1) % 12;
      } else {
        selectedMonth = (selectedMonth - 1 + 12) % 12;
      }
    });
  }

  void changeYear(bool forward) {
    setState(() {
      if (forward) {
        selectedYear++;
      } else {
        selectedYear--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    int totalDays = daysInMonth(selectedYear, selectedMonth);

    if (selectedDay > totalDays) {
      selectedDay = totalDays;
    }

    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        padding: const EdgeInsets.all(22),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Birthday", style: AppTextStyles.title(22)),
            const SizedBox(height: 16),

            // YEAR SELECTOR
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _arrowButton(() => changeYear(false)),
                const SizedBox(width: 18),
                Text(
                  "$selectedYear",
                  style: AppTextStyles.title(
                    40,
                  ).copyWith(color: AppColors.primary),
                ),
                const SizedBox(width: 18),
                _arrowButton(() => changeYear(true)),
              ],
            ),

            // MONTH SELECTOR
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _arrowButton(() => changeMonth(false)),
                const SizedBox(width: 18),
                Text(months[selectedMonth], style: AppTextStyles.heading(20)),
                const SizedBox(width: 18),
                _arrowButton(() => changeMonth(true)),
              ],
            ),

            const SizedBox(height: 16),

            // DAYS GRID
            SizedBox(
              height: 300,
              child: GridView.count(
                crossAxisCount: 7,
                children: List.generate(totalDays, (index) {
                  int day = index + 1;
                  bool isSelected = selectedDay == day;

                  return GestureDetector(
                    onTap: () {
                      setState(() => selectedDay = day);
                    },
                    child: Container(
                      margin: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primary
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Center(
                        child: Text(
                          "$day",
                          style: AppTextStyles.heading(17).copyWith(
                            color: isSelected
                                ? Colors.white
                                : AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),

            const SizedBox(height: 20),

            PrimaryButton(
              label: "Save",
              onPressed: () {
                String formattedDate =
                    "$selectedDay ${months[selectedMonth]} $selectedYear";
                Navigator.pop(context, formattedDate);
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _arrowButton(VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: AppColors.background,
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.chevron_left, color: AppColors.textPrimary),
      ),
    );
  }
}
