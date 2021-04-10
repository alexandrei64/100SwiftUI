# Project 5 - WordScramble

## 📝 What I learned

List, onAppear(), Bundle, fatalError(), @State, Alert, NavigationView, UITextChecker

## 🏆 Challenges

> * Disallow answers that are shorter than three letters or are just our start word. For the three-letter check, the easiest thing to do is put a check into isReal() that returns false if the word length is under three letters. For the second part, just compare the start word against their input word and return false if they are the same.
> * Add a left bar button item that calls startGame(), so users can restart with a new word whenever they want to.
> * Put a text view below the List so you can track and show the player’s score for a given root word. How you calculate score is down to you, but something involving number of words and their letter count would be reasonable.

For the first challenge I've chosen an implementation which displays an alert letting the user know about the rule that has been broken. The implementation as per challenge requirements has been left as a comment block in the project.

## 📸 Screenshots
<div align ="center">
<img src="/Assets/Mockup_WordScramble.png" width=800>
</div>