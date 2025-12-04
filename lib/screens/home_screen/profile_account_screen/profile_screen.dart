import 'package:datingapp/screens/home_screen/profile_account_screen/photoviewer_screen.dart';
import 'package:datingapp/theme/app_colors.dart';
import 'package:datingapp/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final List<String> galleryImages = [
    'assets/images/gallery1.jpg',
    'assets/images/gallery2.jpg',
    'assets/images/gallery3.jpg',
    'assets/images/gallery4.jpg',
    'assets/images/gallery5.jpg',
    'assets/images/gallery6.jpg',
    'assets/images/gallery7.jpg',
    'assets/images/gallery8.jpg',
    'assets/images/gallery9.jpg',
    'assets/images/gallery10.jpg',
    'assets/images/gallery11.jpg',
    'assets/images/gallery12.jpg',
  ];

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ================= HEADER IMAGE WITH BUTTONS =================
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 420,
                  child: Image.asset(
                    'assets/images/profile_header.jpg',
                    fit: BoxFit.cover,
                  ),
                ),

                Positioned(
                  top: 60,
                  left: 20,
                  child: _circleButton(
                    Icons.arrow_back_rounded,
                    () => Navigator.pop(context),
                  ),
                ),

                Positioned(
                  bottom: 20,
                  left: 40,
                  child: _circleButton(Icons.close, () {}),
                ),
                Positioned(
                  bottom: 20,
                  right: 40,
                  child: _circleButton(
                    Icons.favorite,
                    () {},
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // ================= NAME + OCCUPATION =================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Jessica Parker, 23",
                          style: AppTextStyles.heading(26),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "Professional model",
                          style: AppTextStyles.subtitle,
                        ),
                      ],
                    ),
                  ),
                  _circleButton(Icons.send, () {}, size: 52),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ================= ABOUT =================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("About", style: AppTextStyles.heading(20)),
                  const SizedBox(height: 10),
                  Text(
                    "My name is Jessica Parker and I enjoy meeting new people and finding ways to help them have an uplifting experience. I enjoy reading...",
                    style: AppTextStyles.description(15),
                  ),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      "Read more",
                      style: AppTextStyles.footerLink(14),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ================= INTERESTS =================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text("Interests", style: AppTextStyles.heading(20)),
            ),
            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _chip("Travelling"),
                  _chip("Books"),
                  _chip("Music"),
                  _chip("Dancing"),
                  _chip("Modeling"),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // ================= GALLERY =================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Gallery", style: AppTextStyles.heading(20)),
                  Text("See all", style: AppTextStyles.footerLink(14)),
                ],
              ),
            ),

            const SizedBox(height: 15),

            GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: galleryImages.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PhotoViewerScreen(
                          images: galleryImages,
                          initialIndex: index,
                        ),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.asset(galleryImages[index], fit: BoxFit.cover),
                  ),
                );
              },
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _chip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _circleButton(
    IconData icon,
    VoidCallback onTap, {
    Color color = Colors.white,
    double size = 60,
  }) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(color: Colors.black12, spreadRadius: 1, blurRadius: 6),
        ],
      ),
      child: IconButton(
        icon: Icon(
          icon,
          color: color == Colors.white ? Colors.black87 : Colors.white,
        ),
        onPressed: onTap,
      ),
    );
  }
}
