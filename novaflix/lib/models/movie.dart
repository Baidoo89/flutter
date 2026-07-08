import 'package:flutter/material.dart';

class Movie {
  final String title;
  final String genre;
  final int year;
  final String maturity;
  final String duration;
  final int matchPercent;
  final String description;
  final Color color;

  const Movie({
    required this.title,
    required this.genre,
    required this.year,
    required this.maturity,
    required this.duration,
    required this.matchPercent,
    required this.description,
    required this.color,
  });
}

class Category {
  final String name;
  final List<Movie> movies;

  const Category({required this.name, required this.movies});
}

const Movie featuredMovie = Movie(
  title: 'Accra After Dark',
  genre: 'Urban Thriller',
  year: 2026,
  maturity: '16+',
  duration: '1h 52m',
  matchPercent: 98,
  description:
      'A young software student follows a hidden signal across Accra and uncovers a secret network of digital money thieves.',
  color: Color(0xFFE11D48),
);

const List<Category> movieCategories = [
  Category(
    name: 'Trending Now',
    movies: [
      featuredMovie,
      Movie(
        title: 'Neon Harbour',
        genre: 'Sci-Fi Drama',
        year: 2025,
        maturity: '13+',
        duration: '2h 04m',
        matchPercent: 96,
        description:
            'In a floating city powered by AI, two friends race to stop a blackout before midnight.',
        color: Color(0xFF06B6D4),
      ),
      Movie(
        title: 'The Last Lecture',
        genre: 'Mystery',
        year: 2024,
        maturity: 'PG',
        duration: '1h 41m',
        matchPercent: 93,
        description:
            'A missing professor leaves clues inside one final mobile computing lecture.',
        color: Color(0xFF7C3AED),
      ),
      Movie(
        title: 'Market Queens',
        genre: 'Comedy Drama',
        year: 2026,
        maturity: 'PG',
        duration: '1h 35m',
        matchPercent: 91,
        description:
            'Three traders launch an online shop and accidentally become internet celebrities.',
        color: Color(0xFFF59E0B),
      ),
    ],
  ),
  Category(
    name: 'Popular on NovaFlix',
    movies: [
      Movie(
        title: 'Campus Code',
        genre: 'Drama',
        year: 2025,
        maturity: 'PG',
        duration: '1h 48m',
        matchPercent: 95,
        description:
            'A group of students build an app that changes how their campus shares news.',
        color: Color(0xFF10B981),
      ),
      Movie(
        title: 'Signal Lost',
        genre: 'Action',
        year: 2023,
        maturity: '16+',
        duration: '2h 10m',
        matchPercent: 89,
        description:
            'A rescue team follows one weak phone signal into a storm-covered mountain town.',
        color: Color(0xFFDC2626),
      ),
      Movie(
        title: 'Rain on Ring Road',
        genre: 'Romance',
        year: 2024,
        maturity: 'PG',
        duration: '1h 44m',
        matchPercent: 88,
        description:
            'Two strangers keep meeting at the same bus stop during a week of heavy rain.',
        color: Color(0xFF2563EB),
      ),
      Movie(
        title: 'Vault 216',
        genre: 'Heist',
        year: 2026,
        maturity: '16+',
        duration: '1h 58m',
        matchPercent: 94,
        description:
            'A careful team plans one last digital heist, but their route keeps changing.',
        color: Color(0xFF9333EA),
      ),
    ],
  ),
  Category(
    name: 'Ghanaian Cinema',
    movies: [
      Movie(
        title: 'Cape Coast Moon',
        genre: 'Historical Drama',
        year: 2022,
        maturity: 'PG',
        duration: '1h 50m',
        matchPercent: 90,
        description:
            'A family story travels between the old coast and a new generation searching for meaning.',
        color: Color(0xFF0F766E),
      ),
      Movie(
        title: 'Kumasi Lights',
        genre: 'Music',
        year: 2025,
        maturity: 'PG',
        duration: '1h 39m',
        matchPercent: 92,
        description:
            'A young producer builds a sound that brings a city together for one unforgettable night.',
        color: Color(0xFFEA580C),
      ),
      Movie(
        title: 'Trotro Diaries',
        genre: 'Comedy',
        year: 2024,
        maturity: 'PG',
        duration: '1h 32m',
        matchPercent: 87,
        description:
            'Every passenger has a story, and one chaotic ride connects them all.',
        color: Color(0xFF84CC16),
      ),
    ],
  ),
];

List<Movie> allMovies() {
  return movieCategories.expand((category) => category.movies).toSet().toList();
}
