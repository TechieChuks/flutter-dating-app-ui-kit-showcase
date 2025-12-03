import 'package:datingapp/screens/home_screen/model/user_card_model.dart';
import 'package:datingapp/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class ViewCardDetailScreen extends StatelessWidget {
  final UserCardModel card;
  const ViewCardDetailScreen({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar with back button
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          '${card.name}, ${card.age}',
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              card.imageUrl,
              height: 320,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${card.name}, ${card.age}',
                    style: AppTextStyles.heading(26),
                  ),
                  const SizedBox(height: 6),
                  Text(card.job, style: AppTextStyles.description(16)),
                  const SizedBox(height: 14),
                  Text('About', style: AppTextStyles.heading(18)),
                  const SizedBox(height: 8),
                  Text(
                    'This is a demo profile for ${card.name}. You can place more details here: bio, interests, education, work, etc.',
                    style: AppTextStyles.description(15),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
