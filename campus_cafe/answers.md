# Practical A Answers

Checkpoint 1: `initState()` runs once when the page state is created, while `build()` runs whenever Flutter redraws the widget tree, including hot reloads and state updates.

Section 4: Without `setState()`, the data in memory can change, but Flutter is not told to rebuild the screen, so the visible quantity and total stay the same.
