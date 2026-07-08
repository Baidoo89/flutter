import 'package:flutter/material.dart';
import '../main.dart';
import '../models/movie.dart';

class PlayerScreen extends StatelessWidget {
  final Movie movie;

  const PlayerScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.black, title: Text(movie.title)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                height: 220,
                decoration: BoxDecoration(
                  color: movie.color,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Icon(
                  Icons.play_circle_fill,
                  size: 92,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 22),
              Text(
                'Now Playing: ${movie.title}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Demo player screen built with the same typed Movie argument.',
                textAlign: TextAlign.center,
                style: TextStyle(color: NovaFlixApp.muted),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
