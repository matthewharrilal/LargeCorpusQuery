//
//  TrieTreeService.swift
//  LargeCorpusQuery
//
//  Created by Space Wizard on 8/20/24.
//

import Foundation

protocol TrieTreeProtocol: AnyObject {
    func insert(phrase: String)
    func search(phrase: String) -> Bool
    func prettyPrint()
}

class Node {
    var children: [Character: Node] = [:]
    var isEndOfWord: Bool = false
}

class TrieTreeImplementation: TrieTreeProtocol {
    private let root: Node
    
    init() {
        self.root = Node()
    }
    
    func prettyPrint() {
        // No-Op
    }
    
    /// Inserts a given string (phrase) into the Trie.
    ///
    /// - Parameters:
    ///   - phrase: The string to be inserted into the Trie.
    ///
    /// - How it works:
    ///   - Starts from the root node.
    ///   - Iterates over each character in the phrase.
    ///   - If the current node doesn't have a child node corresponding to the character, it creates one.
    ///   - Moves to the next node and continues until all characters are processed.
    ///   - Marks the final node as the end of a word (`isEndOfWord = true`).
    ///
    /// - Objects used:
    ///   - `Node`: Represents each node in the Trie, containing a dictionary of child nodes (`children`) and a boolean flag (`isEndOfWord`).
    ///   - `root`: The starting node of the Trie, which is the entry point for all insertions.
    func insert(phrase: String) {
        var current = root
        
        for letter in phrase {
            if !current.children.keys.contains(letter) {
                current.children[letter] = Node()
            }
            
            if let next = current.children[letter] {
                current = next
            }
        }
        
        current.isEndOfWord = true
    }
    
    /// Searches for a given string (phrase) in the Trie and checks if it exists.
    ///
    /// - Parameters:
    ///   - phrase: The string to search for in the Trie.
    ///
    /// - Returns: A boolean indicating whether the phrase exists in the Trie.
    ///
    /// - How it works:
    ///   - Starts from the root node.
    ///   - Iterates over each character in the phrase.
    ///   - Moves to the child node corresponding to the character if it exists.
    ///   - If any character is missing in the Trie, the search fails and returns `false`.
    ///   - If all characters are found, calls `dfsForSuggestions` to explore possible suggestions.
    ///   - Finally, returns `true` if the exact phrase is present (`isEndOfWord = true`).
    ///
    /// - Objects used:
    ///   - `Node`: Represents each node in the Trie, containing a dictionary of child nodes (`children`) and a boolean flag (`isEndOfWord`).
    ///   - `root`: The starting node of the Trie, which is the entry point for all searches.
    func search(phrase: String) -> Bool {
        var current = root
        
        for letter in phrase {
            if current.children.keys.contains(letter), let next = current.children[letter] {
                current = next
            } else {
                return false
            }
        }
        
        dfsForSuggestions(startingNode: current, phrase: phrase)
        // If we make it through the length of the phrase still doesnt mean that the exact word is there
        return current.isEndOfWord
    }
    
    /// Performs a depth-first search (DFS) to generate suggestions based on the current node.
    ///
    /// - Parameters:
    ///   - startingNode: The node from which to start the DFS.
    ///   - phrase: The current string that has been found up to this node.
    ///
    /// - How it works:
    ///   - Initializes a stack with the starting node and the phrase.
    ///   - While the stack is not empty, it pops the last node and current phrase.
    ///   - If the node represents the end of a word, it prints the current phrase as a suggestion.
    ///   - Pushes all child nodes onto the stack, appending their characters to the current phrase.
    ///
    /// - Objects used:
    ///   - `Node`: Represents each node in the Trie, containing a dictionary of child nodes (`children`) and a boolean flag (`isEndOfWord`).
    private func dfsForSuggestions(startingNode: Node, phrase: String) {
        var stack: [(Node, String)] = [(startingNode, phrase)]
        
        while !stack.isEmpty {
            let (removedNode, currentPhrase) = stack.removeLast()
            
            if removedNode.isEndOfWord {
                print("Suggestions: \(currentPhrase)")
            }
            
            for (char, node) in removedNode.children {
                stack.append((node, currentPhrase + String(char)))
            }
        }
    }
}
