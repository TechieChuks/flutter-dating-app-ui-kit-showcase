import 'package:datingapp/theme/app_colors.dart';
import 'package:flutter/material.dart';

class PhotoViewerScreen extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  const PhotoViewerScreen({
    super.key,
    required this.images,
    this.initialIndex = 0,
  });

  @override
  State<PhotoViewerScreen> createState() => _PhotoViewerScreenState();
}

class _PhotoViewerScreenState extends State<PhotoViewerScreen> {
  late PageController controller;
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: widget.initialIndex);
    currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          const SizedBox(height: 60),

          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),

          Expanded(
            child: PageView.builder(
              controller: controller,
              itemCount: widget.images.length,
              onPageChanged: (i) => setState(() => currentIndex = i),
              itemBuilder: (context, index) {
                return Image.asset(widget.images[index], fit: BoxFit.contain);
              },
            ),
          ),

          const SizedBox(height: 20),

          // ========== Thumbnails ==========
          SizedBox(
            height: 90,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.images.length,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemBuilder: (context, index) {
                bool active = index == currentIndex;

                return GestureDetector(
                  onTap: () => controller.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: active ? AppColors.primary : Colors.white24,
                        width: active ? 2 : 1,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        widget.images[index],
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
