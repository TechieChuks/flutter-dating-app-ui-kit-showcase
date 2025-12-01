import 'package:datingapp/screens/home_screen/model/user_card_model.dart';
import 'package:flutter/material.dart';

import '../theme/app_text_styles.dart';

typedef OnSwiped = void Function(String id, SwipeDirection dir);
typedef OnCancelTapped = void Function(String id);

enum SwipeDirection { left, right, none }

class SwipeCard extends StatefulWidget {
  final UserCardModel card;
  final bool isTop;
  final OnSwiped onSwiped;
  final OnCancelTapped onCancelTapped;
  final double maxRotation; // degrees

  const SwipeCard({
    Key? key,
    required this.card,
    required this.isTop,
    required this.onSwiped,
    required this.onCancelTapped,
    this.maxRotation = 12,
  }) : super(key: key);

  @override
  State<SwipeCard> createState() => _SwipeCardState();
}

class _SwipeCardState extends State<SwipeCard>
    with SingleTickerProviderStateMixin {
  Offset position = Offset.zero;
  double rotation = 0; // radians
  late AnimationController _animateController;
  late Animation<Offset> _animation;
  bool showCancel = false;

  @override
  void initState() {
    super.initState();
    _animateController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation =
        Tween<Offset>(begin: Offset.zero, end: Offset.zero).animate(
          CurvedAnimation(parent: _animateController, curve: Curves.easeOut),
        )..addListener(() {
          setState(() {
            position = _animation.value;
          });
        });
    _animateController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // nothing here; parent will decide next steps by callbacks
        _animateController.reset();
      }
    });
  }

  @override
  void dispose() {
    _animateController.dispose();
    super.dispose();
  }

  void animateTo(Offset target, {VoidCallback? then}) {
    _animation = Tween<Offset>(begin: position, end: target).animate(
      CurvedAnimation(parent: _animateController, curve: Curves.easeInOut),
    );
    _animateController.forward().then((_) {
      if (then != null) then();
    });
  }

  void handlePanUpdate(DragUpdateDetails details) {
    if (!widget.isTop) return;
    setState(() {
      position += details.delta;
      rotation =
          (position.dx / MediaQuery.of(context).size.width) *
          (widget.maxRotation * (3.14159 / 180));
      showCancel = position.dx < -35; // show cancel when dragging left a bit
    });
  }

  void handlePanEnd(DragEndDetails details) {
    if (!widget.isTop) return;
    final screenWidth = MediaQuery.of(context).size.width;

    const fullSwipeThreshold = 0.28;
    final dx = position.dx;

    // FULL LEFT SWIPE
    if (dx <= -screenWidth * fullSwipeThreshold) {
      animateTo(
        Offset(-screenWidth * 1.5, position.dy),
        then: () {
          widget.onSwiped(widget.card.id, SwipeDirection.left);
          setState(() {
            position = Offset.zero;
            rotation = 0;
            showCancel = false;
          });
        },
      );
      return;
    }

    // FULL RIGHT SWIPE
    if (dx >= screenWidth * fullSwipeThreshold) {
      animateTo(
        Offset(screenWidth * 1.5, position.dy),
        then: () {
          widget.onSwiped(widget.card.id, SwipeDirection.right);
          setState(() {
            position = Offset.zero;
            rotation = 0;
            showCancel = false;
          });
        },
      );
      return;
    }

    // ⭐ NEW: Park card when partially swiped left so cancel button stays visible
    if (dx < -35) {
      setState(() {
        position = Offset(-70, position.dy); // parked position
        showCancel = true;
      });
      return;
    }

    // NORMAL SNAP BACK
    animateTo(
      Offset.zero,
      then: () {
        setState(() {
          position = Offset.zero;
          rotation = 0;
          showCancel = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final card = widget.card;
    // If not top, show with a slight scale/offset to create stacked look
    //final baseScale = widget.isTop ? 1.0 : 0.96;
    final yOffset = widget.isTop ? position.dy : 10.0;

    return Transform.translate(
      offset: widget.isTop ? position : Offset(0, yOffset),
      child: Transform.rotate(
        angle: widget.isTop ? rotation : 0,
        child: GestureDetector(
          onPanUpdate: handlePanUpdate,
          onPanEnd: handlePanEnd,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Card container
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(
                  horizontal: 26,
                  vertical: 12,
                ),
                height: 520,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 16,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                clipBehavior: Clip.hardEdge,
                child: Stack(
                  children: [
                    // network image
                    Positioned.fill(
                      child: Image.network(
                        card.imageUrl,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, progress) {
                          if (progress == null) return child;
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                        errorBuilder: (c, e, s) => Container(
                          color: Colors.grey[300],
                          child: const Center(child: Icon(Icons.broken_image)),
                        ),
                      ),
                    ),
                    // gradient overlay bottom
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      height: 140,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withOpacity(0.7),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),
                    // distance pill
                    Positioned(
                      left: 18,
                      top: 18,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: Colors.white,
                              size: 14,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              card.distance,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // bottom text (name, job)
                    Positioned(
                      left: 18,
                      bottom: 18,
                      right: 18,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${card.name}, ${card.age}',
                            style: AppTextStyles.heading(
                              28,
                            ).copyWith(color: Colors.white),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            card.job,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Cancel button overlay appears when dragging left
              if (widget.isTop && showCancel)
                Positioned(
                  child: GestureDetector(
                    onTap: () {
                      // animate a little pop and call cancel callback
                      // here parent will remove the card
                      widget.onCancelTapped(widget.card.id);
                    },
                    child: Container(
                      width: 96,
                      height: 96,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(color: Colors.black26, blurRadius: 16),
                        ],
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.close,
                          color: Colors.deepOrange,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
