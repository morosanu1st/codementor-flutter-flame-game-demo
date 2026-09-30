import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'bounce_game.dart';

void main() {
  runApp(const BounceDemoApp());
}

class BounceDemoApp extends StatelessWidget {
  const BounceDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flame Bounce Demo',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter + Flame — Bounce Demo'),
          backgroundColor: Colors.indigo,
        ),
        body: GameWidget(
          game: BounceGame(),
          overlayBuilderMap: {
            'hud': (context, game) {
              final g = game as BounceGame;
              return Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: ValueListenableBuilder<int>(
                    valueListenable: g.score,
                    builder: (_, value, __) => Text(
                      'Bounces: $value  (tap to reset)',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        shadows: [Shadow(blurRadius: 4, color: Colors.black)],
                      ),
                    ),
                  ),
                ),
              );
            },
          },
          initialActiveOverlays: const ['hud'],
        ),
      ),
    );
  }
}
