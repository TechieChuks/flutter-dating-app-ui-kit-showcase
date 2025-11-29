import 'package:datingapp/widgets/gender_tile_widget.dart';
import 'package:flutter/material.dart';

class GenderScreen extends StatefulWidget {
  const GenderScreen({super.key});

  @override
  State<GenderScreen> createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  String selectedGender = "Man"; // default selected

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              // Back + skip row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black12),
                    ),
                    child: const Icon(Icons.arrow_back, color: Colors.red),
                  ),
                  const Text(
                    "Skip",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 48),

              const Text(
                "I am a",
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.w700),
              ),

              const SizedBox(height: 48),

              GenderTile(
                label: "Woman",
                isSelected: selectedGender == "Woman",
                onTap: () => setState(() => selectedGender = "Woman"),
              ),

              const SizedBox(height: 18),

              GenderTile(
                label: "Man",
                isSelected: selectedGender == "Man",
                onTap: () => setState(() => selectedGender = "Man"),
              ),

              const SizedBox(height: 18),

              GestureDetector(
                onTap: () {
                  // Go to Custom Gender Screen
                },
                child: Container(
                  height: 75,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("Choose another", style: TextStyle(fontSize: 18)),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const Spacer(),

              GestureDetector(
                onTap: () {
                  print("Selected: $selectedGender");

                  // Navigate to next screen
                  // Example: Interests screen / Orientation / etc.
                },
                child: Container(
                  height: 64,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE83F5F),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Text(
                      "Continue",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
