# Practical B Answers

`_refresh()` must call `setState()` because SQLite updates the stored data, but Flutter only redraws the visible list after the widget state is updated and a rebuild is requested.

The app uses database search with `LIKE`, a statistics dialog with `GROUP BY`, and a version 2 migration that adds an email column without deleting old records.
