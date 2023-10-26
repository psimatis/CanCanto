# CanCanto
A mobile app to teach myself Flutter and Cantonese.

## Target Specs
The app is essentially a flash card with english-cantonese translations. 
It consists of four screens: 
1) Quiz: Quizzes the user to translate random phrases and shows performance stats.
2) Vocabulary: Lists all phrases and allows CRUD operations.
3) Add/edit: The user can add a new phrase or edit an existing one.
4) Detail: Shows the details of a specific phrase.

## Done
- Implemented screens (i.e., quiz, vocabulary, add/edit phrase).
- Set up the database and CRUD operations (including random phrase retrieval).
- Added score keeping.
- Edit the user input (i.e., lowercase, remove trailing spaces).
- Make quiz work both ways (i.e., english to cantonese and vice versa).
- If the DB is empty start with the vocabulary screen.
- Moved DB to main.
- Fix deletion bug. Used ID instead of value.
- Fix back/go to quiz button.
- Hid success rate if the user hasn't started the quiz.
- Added floating action button to navigate from quiz to vocabulary.
- Add statistics in detail page (e.g., attempts, success rate).
- Add correct (previous) phrase to facilitate learning.
- Add statistics plot in detail page.
- Beautify go for all red theme

## ToDo
- Add comment for each phrase.
- Add search in vocabulary.
- Add message in vocabulary screen asking the user to add a phrase if the DB is empty.
- Add statistics depending on the translation order.
- Redesign vocabulary screen to a scrollable list of words (instead of a grid).
- Move database file to an easy to find location.
- Code cleanup.