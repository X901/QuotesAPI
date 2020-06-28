////
//UserDefults.swift
//AdministrativeContacts
//
//Created by Basel Baragabah on 10/03/2019.
//Copyright © 2019 Basel Baragabah. All rights reserved.
//

import Foundation

struct UserDefults {
   
    private static let lastQuoteKey = "lastQuote"
    private static let defaults = UserDefaults.standard

    struct LastQuote: Codable {
        let id: String?
        let en: String?
        let author: String?
    }
    
   static func saveLastQuote(_ list:LastQuote) {
    let encoder = JSONEncoder()
    if let encoded = try? encoder.encode(list) {
        defaults.set(encoded, forKey: lastQuoteKey)
    }

    }
    
    

   static func getLastQuote() -> LastQuote? {
    
    if let lastQuoteSaved = defaults.object(forKey: lastQuoteKey) as? Data {
        let decoder = JSONDecoder()
        if let loadedLastQuote = try? decoder.decode(LastQuote.self, from: lastQuoteSaved) {
            return loadedLastQuote
        }
    }
    return nil 
    }
          
    
    static func clearLastQuote(){
           UserDefaults.standard.removeObject(forKey: lastQuoteKey)
       }
    

    
}
