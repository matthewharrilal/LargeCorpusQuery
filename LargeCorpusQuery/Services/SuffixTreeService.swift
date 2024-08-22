//
//  SuffixTreeService.swift
//  LargeCorpusQuery
//
//  Created by Space Wizard on 8/21/24.
//

import Foundation

class SuffixTreeImplementation: TrieTreeProtocol {
    private let root: Node
    
    init() {
        self.root = Node()
    }
    
    func insert(phrase: String) {
        // Goal create list of suffixes
        
        var current = root
        let substrings = createListOfSuffixes(phrase)
        
        for substring in substrings {
            current = root

            for letter in substring {
                if !current.children.keys.contains(letter) {
                    current.children[letter] = Node()
                }
                
                if let next = current.children[letter] {
                    current = next
                }
            }
            
            current.isEndOfWord = true
        }
    }
    
    func search(phrase: String) -> Bool {
        true
    }
    
    func prettyPrint() {
        prettyPrintHelper(node: root, prefix: "")
    }
}

private extension SuffixTreeImplementation {
    
    func createListOfSuffixes(_ phrase: String) -> [Substring] {
        var count = phrase.count - 1
        var output: [Substring] = []
        
        while count >= 0 {
            let startIndex = phrase.index(phrase.startIndex, offsetBy: count)
            let substring = phrase[startIndex..<phrase.endIndex]
            output.append(substring)
            count -= 1
        }
        
        return output
    }
    
    private func prettyPrintHelper(node: Node, prefix: String) {
        for (letter, childNode) in node.children {
            let newPrefix = prefix + "  " // Indent each level for clarity
            print("\(prefix)└─ \(letter)")
            prettyPrintHelper(node: childNode, prefix: newPrefix)
        }
        
        if node.isEndOfWord {
            print("\(prefix)(end of word)")
        }
    }
}
