import 'package:flutter/material.dart';
import '../main.dart';
import '../models/movie.dart';

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({super.key});

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      const _HomeTab(),
      const _SearchTab(),
      const _PlaceholderTab(icon: Icons.upcoming, label: 'Coming Soon'),
      const _PlaceholderTab(icon: Icons.download, label: 'Downloads'),
      const _ProfileTab(),
    ];

    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: tabs),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: NovaFlixApp.panel,
        selectedItemColor: Colors.white,
        unselectedItemColor: NovaFlixApp.muted,
        onTap: (index) {
          // Tab switching is local state, not Navigator routing.
          setState(() => _currentIndex = index);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.upcoming), label: 'Soon'),
          BottomNavigationBarItem(
            icon: Icon(Icons.download),
            label: 'Downloads',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class _HomeTab extends StatelessWidget {
  const _HomeTab();

  void _openDetail(BuildContext context, Movie movie) {
    Navigator.pushNamed(context, '/detail', arguments: movie);
  }

  void _signOut(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 330,
          backgroundColor: NovaFlixApp.novaBlack,
          title: const Text(
            'NOVAFLIX',
            style: TextStyle(
              color: NovaFlixApp.novaRed,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.2,
            ),
          ),
          actions: [
            IconButton(
              tooltip: 'Sign out',
              icon: const Icon(Icons.logout),
              onPressed: () => _signOut(context),
            ),
          ],
          flexibleSpace: FlexibleSpaceBar(
            background: _HeroBanner(
              movie: featuredMovie,
              onTap: () => _openDetail(context, featuredMovie),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final category in movieCategories)
                  _MovieRail(
                    category: category,
                    onTapMovie: (movie) => _openDetail(context, movie),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _HeroBanner extends StatelessWidget {
  final Movie movie;
  final VoidCallback onTap;

  const _HeroBanner({required this.movie, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [movie.color, NovaFlixApp.novaBlack],
          ),
        ),
        child: Container(
          alignment: Alignment.bottomLeft,
          padding: const EdgeInsets.fromLTRB(18, 100, 18, 28),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                NovaFlixApp.novaBlack.withValues(alpha: 0.92),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                movie.title,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${movie.genre} • ${movie.year} • ${movie.duration}',
                style: const TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: onTap,
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('Play'),
                  ),
                  const SizedBox(width: 12),
                  OutlinedButton.icon(
                    onPressed: onTap,
                    icon: const Icon(Icons.info_outline),
                    label: const Text('Details'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MovieRail extends StatelessWidget {
  final Category category;
  final ValueChanged<Movie> onTapMovie;

  const _MovieRail({required this.category, required this.onTapMovie});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              category.name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 170,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: category.movies.length,
              itemBuilder: (context, index) {
                final movie = category.movies[index];
                return _PosterCard(
                  movie: movie,
                  onTap: () => onTapMovie(movie),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _PosterCard extends StatelessWidget {
  final Movie movie;
  final VoidCallback onTap;

  const _PosterCard({required this.movie, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 112,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: movie.color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            movie.title.toUpperCase(),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
    );
  }
}

class _SearchTab extends StatefulWidget {
  const _SearchTab();

  @override
  State<_SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<_SearchTab> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final results = allMovies()
        .where(
          (movie) => movie.title.toLowerCase().contains(_query.toLowerCase()),
        )
        .toList();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Search',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 14),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Search titles',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) => setState(() => _query = value),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: results.length,
                itemBuilder: (context, index) {
                  final movie = results[index];
                  return ListTile(
                    leading: Container(
                      width: 44,
                      height: 58,
                      decoration: BoxDecoration(
                        color: movie.color,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    title: Text(movie.title),
                    subtitle: Text('${movie.genre} • ${movie.year}'),
                    onTap: () => Navigator.pushNamed(
                      context,
                      '/detail',
                      arguments: movie,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlaceholderTab extends StatelessWidget {
  final IconData icon;
  final String label;

  const _PlaceholderTab({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 64, color: NovaFlixApp.novaRed),
          const SizedBox(height: 14),
          Text(
            label,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 6),
          const Text(
            'This tab uses IndexedStack, not routing.',
            style: TextStyle(color: NovaFlixApp.muted),
          ),
        ],
      ),
    );
  }
}

class _ProfileTab extends StatelessWidget {
  const _ProfileTab();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 42,
            backgroundColor: NovaFlixApp.novaRed,
            child: Icon(Icons.person, color: Colors.white, size: 44),
          ),
          SizedBox(height: 16),
          Text(
            'Student Viewer',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
          ),
          SizedBox(height: 6),
          Text(
            'ENCE 216 streaming lab',
            style: TextStyle(color: NovaFlixApp.muted),
          ),
        ],
      ),
    );
  }
}
