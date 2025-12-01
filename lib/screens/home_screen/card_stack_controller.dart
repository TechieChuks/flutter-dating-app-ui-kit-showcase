import 'package:datingapp/screens/home_screen/details/view_card_detail_screen.dart';
import 'package:datingapp/screens/home_screen/model/user_card_model.dart';
import 'package:datingapp/widgets/swipe_card.dart';
import 'package:flutter/material.dart';

class CardStackController extends ChangeNotifier {
  final BuildContext context;
  List<UserCardModel> cards;

  CardStackController({required this.context, required this.cards});

  // get top 3 for layering visuals (top = index 0)
  List<UserCardModel> get stack => cards;

  // Called when the top card is swiped (left or right)
  // Left swipe means move to bottom
  void onSwiped(String id, SwipeDirection dir) async {
    final idx = cards.indexWhere((c) => c.id == id);
    if (idx == -1) return;

    final card = cards.removeAt(idx);
    if (dir == SwipeDirection.left) {
      // move to bottom
      cards.add(card);
      notifyListeners();
    } else if (dir == SwipeDirection.right) {
      // for right swipe: open details screen
      // We will push the details screen and when user returns,
      // move that card to bottom.
      notifyListeners();
      await Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => ViewCardDetailScreen(card: card)),
      );
      // When popped (back pressed) move to bottom
      // ensure card is not already in list (it usually isn't)
      final stillHere = cards.indexWhere((c) => c.id == card.id);
      if (stillHere == -1) {
        cards.add(card);
      } else {
        // If it's still in the list for some reason, move it to end
        final existing = cards.removeAt(stillHere);
        cards.add(existing);
      }
      notifyListeners();
    }
  }

  // Cancel tapped while dragging left: delete card permanently
  void onCancelTapped(String id) {
    final idx = cards.indexWhere((c) => c.id == id);
    if (idx == -1) return;
    cards.removeAt(idx);
    notifyListeners();
  }
}
