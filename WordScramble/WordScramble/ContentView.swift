//
//  ContentView.swift
//  WordScramble
//
//  Created by Alex Andrei on 09.04.2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var body: some View  {
        NavigationView {
            VStack {
                TextField("Enter your word", text: $newWord, onCommit: addNewWord)
                    .autocapitalization(.none)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                List(usedWords, id: \.self) {
                    Image(systemName: "\($0.count).circle")
                    Text($0)
                }
                Text("Score: \(usedWords.count)")
                        .fontWeight(.bold)
            }
            .navigationBarTitle(rootWord)
            .navigationBarItems(trailing: Button(action: startGame) {
                Text("Restart")
            })
            .onAppear(perform: startGame)
            .alert(isPresented: $showingError) {
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("Dismiss")))
            }
        }
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0  else {
            return
        }
        
        guard isOverThreeLetters(word: answer) else {
            if answer.count == 1 {
                wordError(title: "\(answer.count) letter detected", message: "Only words which are 3 letters or more are accepted")
            } else {
                wordError(title: "\(answer.count) letters detected", message: "Only words which are 3 letters or more are accepted")
            }
            return
        }
        
        guard isRootWord(word: answer) else {
            wordError(title: "Root word detected", message: "That would be one easy point")
            return
        }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not possible", message: "That isn't a real word")
            return
        }
        
        usedWords.insert(answer, at: 0)
        newWord = ""
    }
    
    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                usedWords = []
                return
            }
        }
        fatalError("Could not load start.txt from bundle.")
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord.lowercased()
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool {
     
    /*
    Commeted lines represent additional code needed for isReal() function to be
    compliant with challenge 1 solution requirements
    */
        
    //  if word.count < 3 || word.lowercased() == rootWord.lowercased() {
    //      return false
    //  } else {
            let checker = UITextChecker()
            let range = NSRange(location: 0, length: word.utf16.count)
            let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
            return misspelledRange.location == NSNotFound
    //  }
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
    func isOverThreeLetters (word: String) -> Bool {
        if word.count < 3 {
            return false
        } else {
            return true
        }
    }
    
    func isRootWord (word: String) -> Bool {
        if word.lowercased() == rootWord.lowercased() {
            return false
        } else {
            return true
        }
    }
    
    
  }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
