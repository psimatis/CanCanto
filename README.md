# CanCanto
A mobile app to teach myself Flutter and Cantonese.

## Target Specs
The app is essentially a flash card with english-cantonese translations. 
It consists of four screens: 
1) Quiz: Quizzes the user to translate random phrases and shows performance stats.
2) Vocabulary: The user can CRUD phrases and their translations. Also shows stats per phrase.
3) Add/edit: The user can add a new phrase or edit an existing one.
4) Detail: Shows the details of a specific phrase.

## Done
- Made the skeleton of all the screens required (i.e., quiz, vocabulary, add/edit phrase).
- Set up the database and CRUD operations (including random phrase retrieval).
- Added score keeping.
- Edit the user input (i.e., lowercase, remove trailing spaces).

## ToDo
- Make quiz work both ways (i.e., english to cantonese and vice versa).
- Add statistics in detail page (e.g., attempts, success rate).
- Redesign vocabulary screen to be a scrollable list of words (instead of a grid).
- Start app with a random phrase (currently it crashes if the DB is empty).
- Add phrase statistics (i.e., how often do I get the translation right?).
- Beautify. Go for an all red theme.
- Code cleanup.