//
//  TrieTreeService.swift
//  LargeCorpusQuery
//
//  Created by Space Wizard on 8/20/24.
//

import Foundation
import UIKit

protocol TrieTreeProtocol: AnyObject {
    func insert(phrase: String)
    func search(phrase: String) -> Bool
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
    
    func insert(phrase: String) {
        // Make a copy of root so we have an original reference
        
        var current = root
        
        for letter in phrase {
            let isContainingLetter = current.children.keys.contains(letter)
            
            if !isContainingLetter {
                current.children[letter] = Node()
            }
            
            if let next = current.children[letter] {
                current = next
            }
        }
        
        current.isEndOfWord = true
    }
    
    func search(phrase: String) -> Bool {
        
        var current = root
        
        for letter in phrase {
            if current.children.keys.contains(letter), let next = current.children[letter] {
                current = next
            } else {
                return false
            }
        }
        
        dfsForSuggestions(phrase, startingNode: current)
        return current.isEndOfWord
    }
}

private extension TrieTreeImplementation {
    
    func dfsForSuggestions(_ phrase: String, startingNode: Node) {
        var currentNode = startingNode
        
        var stack: [(Node, String)] = [(currentNode, phrase)]
        
        while !stack.isEmpty {
            
            let (removedNode, currentPhrase) = stack.removeLast()
            
            if removedNode.isEndOfWord {
                print("Suggestion: \(currentPhrase)")
            }
            
            for (char, node) in removedNode.children {
                stack.append((node, currentPhrase + String(char)))
            }
        }
    }
}
