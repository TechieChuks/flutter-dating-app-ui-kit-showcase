import 'package:datingapp/theme/app_colors.dart';
import 'package:datingapp/theme/app_text_styles.dart';
import 'package:datingapp/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  String interest = "Girls";
  double distance = 40;
  RangeValues age = const RangeValues(20, 28);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.82,
      minChildSize: 0.45,
      maxChildSize: 0.95,
      builder: (_, controller) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
        child: ListView(
          controller: controller,
          children: [
            // top grabber
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: AppColors.thinBar,
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Filters", style: AppTextStyles.heading(24)),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      interest = "Girls";
                      distance = 40;
                      age = const RangeValues(20, 28);
                    });
                  },
                  child: Text("Clear", style: AppTextStyles.footerLink(18)),
                ),
              ],
            ),

            const SizedBox(height: 20),
            Text("Interested in", style: AppTextStyles.heading(16)),
            const SizedBox(height: 12),

            _buildInterestSelector(),

            const SizedBox(height: 24),
            _buildLocation(),

            const SizedBox(height: 24),
            _buildDistance(),

            const SizedBox(height: 24),
            _buildAge(),

            const SizedBox(height: 32),
            PrimaryButton(
              label: "Continue",
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  // ******************** UI COMPONENTS *****************************

  Widget _buildInterestSelector() {
    List<String> options = ["Girls", "Boys", "Both"];

    return Container(
      height: 58,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: List.generate(options.length, (i) {
          bool active = interest == options[i];
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => interest = options[i]),
              child: Container(
                decoration: BoxDecoration(
                  color: active ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(i == 0 ? 18 : 0),
                    bottomLeft: Radius.circular(i == 0 ? 18 : 0),
                    topRight: Radius.circular(i == options.length - 1 ? 18 : 0),
                    bottomRight: Radius.circular(
                      i == options.length - 1 ? 18 : 0,
                    ),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  options[i],
                  style: TextStyle(
                    color: active ? Colors.white : AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildLocation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Location", style: AppTextStyles.heading(18)),
        const SizedBox(height: 10),
        Container(
          height: 64,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              const SizedBox(width: 18),
              const Text("Chicago, USA", style: TextStyle(fontSize: 17)),
              const Spacer(),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 18,
                color: AppColors.textMuted,
              ),
              const SizedBox(width: 18),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDistance() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text("Distance", style: AppTextStyles.heading(18)),
            const Spacer(),
            Text(
              "${distance.toInt()}km",
              style: TextStyle(color: AppColors.textMuted, fontSize: 16),
            ),
          ],
        ),
        Slider(
          activeColor: AppColors.primary,
          inactiveColor: AppColors.border,
          value: distance,
          min: 1,
          max: 100,
          onChanged: (v) => setState(() => distance = v),
        ),
      ],
    );
  }

  Widget _buildAge() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text("Age", style: AppTextStyles.heading(18)),
            const Spacer(),
            Text(
              "${age.start.toInt()}–${age.end.toInt()}",
              style: TextStyle(color: AppColors.textMuted, fontSize: 16),
            ),
          ],
        ),
        RangeSlider(
          activeColor: AppColors.primary,
          inactiveColor: AppColors.border,
          min: 18,
          max: 60,
          values: age,
          onChanged: (value) => setState(() => age = value),
        ),
      ],
    );
  }
}
