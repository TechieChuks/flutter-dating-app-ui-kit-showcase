import 'package:datingapp/theme/app_colors.dart';
import 'package:datingapp/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  final String name;
  final String img;

  const ChatScreen({super.key, required this.name, required this.img});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            const SizedBox(height: 15),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  Center(child: Text("Today", style: AppTextStyles.subtitle)),
                  const SizedBox(height: 20),
                  _buildIncoming("Hi Jake, how are you?... 😊", "2:55 PM"),
                  const SizedBox(height: 20),
                  _buildOutgoing("Haha truly!.. ☕", "3:02 PM"),
                  const SizedBox(height: 20),
                  _buildIncoming("Sure, let’s do it! 😊", "3:10 PM"),
                  const SizedBox(height: 20),
                  _buildOutgoing("Great I will write later...", "3:12 PM"),
                ],
              ),
            ),

            _buildInputBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          CircleAvatar(radius: 27, backgroundImage: AssetImage(img)),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: AppTextStyles.heading(19)),
              Row(
                children: [
                  const Icon(Icons.circle, size: 8, color: Colors.green),
                  const SizedBox(width: 5),
                  Text("Online", style: AppTextStyles.subtitle),
                ],
              ),
            ],
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.border),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Icon(Icons.more_vert, size: 22),
          ),
        ],
      ),
    );
  }

  Widget _buildIncoming(String msg, String time) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.pink.shade50,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Text(msg, style: AppTextStyles.description(16)),
        ),
        const SizedBox(height: 5),
        Text(time, style: AppTextStyles.subtitle),
      ],
    );
  }

  Widget _buildOutgoing(String msg, String time) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Text(msg, style: AppTextStyles.description(16)),
        ),
        const SizedBox(height: 5),
        Text(time, style: AppTextStyles.subtitle),
      ],
    );
  }

  Widget _buildInputBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 65,
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Your message",
                hintStyle: AppTextStyles.subtitle,
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(icon: const Icon(Icons.attach_file), onPressed: () {}),
          IconButton(
            icon: const Icon(Icons.mic, color: AppColors.primary),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
