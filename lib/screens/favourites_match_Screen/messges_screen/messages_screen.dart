import 'package:datingapp/screens/favourites_match_Screen/messges_screen/messages_chat_screen.dart';
import 'package:datingapp/theme/app_colors.dart';
import 'package:datingapp/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> activities = const [
    {"name": "You", "img": "assets/images/p1.jpg"},
    {"name": "Emeka", "img": "assets/images/p2.jpg"},
    {"name": "Dodeye", "img": "assets/images/p3.jpg"},
    {"name": "Christiantus", "img": "assets/images/p4.jpg"},
    {"name": "Nene", "img": "assets/images/p5.jpg"},
    {"name": "Testimony", "img": "assets/images/p6.jpg"},
    {"name": "Uduak", "img": "assets/images/p7.jpg"},
    {"name": "Rejoice", "img": "assets/images/p8.jpg"},
    {"name": "Sophia", "img": "assets/images/p9.jpg"},
    {"name": "Berachah", "img": "assets/images/p10.jpg"},
  ];

  final List<Map<String, dynamic>> messageList = const [
    {
      "name": "Testimony",
      "img": "assets/images/p6.jpg",
      "msg": "Sticker 😍",
      "time": "23 min",
      "unread": 1,
    },
    {
      "name": "Uduak",
      "img": "assets/images/p7.jpg",
      "msg": "Typing..",
      "time": "27 min",
      "unread": 2,
    },
    {
      "name": "Rejoice",
      "img": "assets/images/p8.jpg",
      "msg": "Ok, see you then.",
      "time": "33 min",
      "unread": 0,
    },
    {
      "name": "Sophia",
      "img": "assets/images/p9.jpg",
      "msg": "You: Hey! What’s up, long time..",
      "time": "50 min",
      "unread": 0,
    },
    {
      "name": "Berachah",
      "img": "assets/images/p10.jpg",
      "msg": "You: Hello how are you?",
      "time": "55 min",
      "unread": 0,
    },
    {
      "name": "Emeka",
      "img": "assets/images/p2.jpg",
      "msg": "You: Great I will write later",
      "time": "1 hour",
      "unread": 0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Messages", style: AppTextStyles.title(35)),
                    _buildFilterBtn(),
                  ],
                ),

                const SizedBox(height: 15),
                _buildSearchBar(),
                const SizedBox(height: 20),

                Text("Activities", style: AppTextStyles.heading(20)),
                const SizedBox(height: 15),
                _buildActivities(),

                const SizedBox(height: 25),
                Text("Messages", style: AppTextStyles.heading(20)),
                const SizedBox(height: 10),

                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: messageList.length,
                  itemBuilder: (context, i) =>
                      _buildMessageTile(context, messageList[i]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterBtn() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Icon(
        Icons.filter_alt_outlined,
        color: AppColors.primary,
        size: 28,
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Icon(Icons.search, color: AppColors.textMuted),
          const SizedBox(width: 10),
          Text("Search", style: AppTextStyles.subtitle),
        ],
      ),
    );
  }

  Widget _buildActivities() {
    return SizedBox(
      height: 105,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: activities.length,
        separatorBuilder: (_, __) => const SizedBox(width: 18),
        itemBuilder: (context, i) {
          return Column(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(activities[i]["img"]),
              ),
              const SizedBox(height: 7),
              Text(activities[i]["name"], style: AppTextStyles.description(13)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildMessageTile(BuildContext context, Map msg) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ChatScreen(name: msg["name"], img: msg["img"]),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(radius: 30, backgroundImage: AssetImage(msg["img"])),
              const SizedBox(width: 15),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(msg["name"], style: AppTextStyles.heading(17)),
                    const SizedBox(height: 3),
                    Text(msg["msg"], style: AppTextStyles.subtitle),
                  ],
                ),
              ),

              Column(
                children: [
                  Text(msg["time"], style: AppTextStyles.subtitle),
                  if (msg["unread"] > 0)
                    Container(
                      margin: const EdgeInsets.only(top: 6),
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        "${msg["unread"]}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Divider(color: AppColors.border, thickness: 1),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
