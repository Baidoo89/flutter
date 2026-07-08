import 'package:flutter/material.dart';
import '../main.dart';
import '../models/movie.dart';

class DetailScreen extends StatelessWidget {
  final Movie movie;

  const DetailScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 320,
            pinned: true,
            backgroundColor: NovaFlixApp.novaBlack,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                movie.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              background: Container(
                color: movie.color,
                child: Center(
                  child: Icon(
                    Icons.movie_creation_outlined,
                    size: 92,
                    color: Colors.white.withValues(alpha: 0.88),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${movie.matchPercent}% Match • ${movie.year} • ${movie.maturity} • ${movie.duration}',
                    style: const TextStyle(
                      color: Colors.greenAccent,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () => Navigator.pushNamed(
                      context,
                      '/player',
                      arguments: movie,
                    ),
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('Play'),
                  ),
                  const SizedBox(height: 10),
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.download),
                    label: const Text('Download'),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      foregroundColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    movie.description,
                    style: const TextStyle(fontSize: 16, height: 1.45),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'Genre: ${movie.genre}',
                    style: const TextStyle(color: NovaFlixApp.muted),
                  ),
                  const SizedBox(height: 28),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _DetailAction(icon: Icons.add, label: 'My List'),
                      _DetailAction(
                        icon: Icons.thumb_up_alt_outlined,
                        label: 'Rate',
                      ),
                      _DetailAction(icon: Icons.share, label: 'Share'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailAction extends StatelessWidget {
  final IconData icon;
  final String label;

  const _DetailAction({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.white),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(color: NovaFlixApp.muted)),
      ],
    );
  }
}
