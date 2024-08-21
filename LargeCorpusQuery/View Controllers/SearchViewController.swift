//
//  ViewController.swift
//  LargeCorpusQuery
//
//  Created by Space Wizard on 8/20/24.
//

import UIKit

class SearchViewController: UIViewController {
    
    private let treeService: TrieTreeProtocol
    private let decodingService: DecodingProtocol
    
    let articleNames: [String] = [
        "Top 15 Array Strings for Your Next Project",
        "15 Essential String Arrays for Efficient Coding",
        "Array of Strings: 15 Must-Have Examples",
        "15 Creative Ways to Use String Arrays in Programming",
        "Optimizing Your Code: 15 Array String Patterns",
        "Exploring 15 Versatile String Arrays for Developers",
        "15 Innovative Uses for Array of Strings",
        "Mastering String Arrays: 15 Key Examples",
        "15 String Arrays Every Programmer Should Know",
        "Array of Strings in Action: 15 Practical Examples",
        "15 Powerful String Arrays for Better Code Management",
        "Dynamic Coding: 15 Array Strings to Enhance Your Workflow",
        "15 Array String Patterns to Streamline Your Code",
        "String Arrays Simplified: 15 Essential Patterns",
        "15 Advanced Techniques with Array of Strings"
    ]
    
    init(treeService: TrieTreeProtocol, decodingService: DecodingProtocol) {
        self.treeService = treeService
        self.decodingService = decodingService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        articleNames.forEach { treeService.insert(phrase: $0) }
        
        defer { treeService.search(phrase: "15") }
    }
}

