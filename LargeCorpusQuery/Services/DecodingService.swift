//
//  DecodingService.swift
//  LargeCorpusQuery
//
//  Created by Space Wizard on 8/21/24.
//

import Foundation

protocol DecodingProtocol: AnyObject {
    func decodeFromResource<T>(resourceName: String) -> T? where T: Decodable
}

class DecodingImplementation: DecodingProtocol {
    
    func decodeFromResource<T>(resourceName: String) -> T? where T : Decodable {
        guard let url = Bundle.main.url(forResource: resourceName, withExtension: "json") else { return nil }
        
        do {
            let data = try Data(contentsOf: url)
            let results = try JSONDecoder().decode(T.self, from: data)
            return results
        }
        catch {
            print("Error decoding results")
            return nil
        }
    }
}
