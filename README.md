# Anagram Solver
Dynamically lists solutions for the Game Pigeon Anagrams game

## Features

- Enter 6 randomized letters to find all possible anagrams.
- Words are scored based on length: 
  - 3-letter words: 100 points
  - 4-letter words: 400 points
  - 5-letter words: 1200 points
  - 6-letter words: 2000 points
- Words are grouped in order of length and displayed alphabetically within each length group.
- Clean and user-friendly interface.


## Getting Started

### Prerequisites

- Flutter SDK: [Install Flutter](https://flutter.dev/docs/get-started/install)
- Git: [Install Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)

### Installation

1. Clone the repository:

```bash
git clone https://github.com/your-username/anagram-solver.git
cd anagram-solver
```

2. Install dependencies:

```bash
flutter pub get
```

3. Run the app:

```bash
flutter run
```

### Usage

1. Enter the letters in the text field at the top.
2. The app will display all possible anagrams, along with their scores in parentheses.


### Dictionary Source

- The word list used for finding anagrams is sourced from the dwyl/english-words repository on GitHub.
- https://github.com/dwyl/english-words/blob/master/words.txt



