import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

/// Minimal Flame game: a ball that bounces inside the screen.
class BounceGame extends FlameGame with TapCallbacks {
  final ValueNotifier<int> score = ValueNotifier(0);
  late final Ball ball;

  @override
  Color backgroundColor() => const Color(0xFF1A237E);

  @override
  Future<void> onLoad() async {
    ball = Ball();
    add(ball);
  }

  @override
  void onTapDown(TapDownEvent event) {
    score.value = 0;
    ball.reset(size);
  }
}

class Ball extends CircleComponent with HasGameRef<BounceGame> {
  Vector2 velocity = Vector2(180, 140);

  Ball()
      : super(
          radius: 24,
          paint: Paint()..color = const Color(0xFFFFCA28),
          anchor: Anchor.center,
        );

  void reset(Vector2 gameSize) {
    position = gameSize / 2;
    velocity = Vector2(180, 140);
  }

  @override
  Future<void> onLoad() async {
    position = gameRef.size / 2;
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;

    final w = gameRef.size.x;
    final h = gameRef.size.y;

    if (position.x - radius <= 0 || position.x + radius >= w) {
      velocity.x = -velocity.x;
      position.x = position.x.clamp(radius, w - radius);
      gameRef.score.value++;
    }
    if (position.y - radius <= 0 || position.y + radius >= h) {
      velocity.y = -velocity.y;
      position.y = position.y.clamp(radius, h - radius);
      gameRef.score.value++;
    }
  }
}
