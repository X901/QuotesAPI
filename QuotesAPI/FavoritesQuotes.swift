////
//FavoriteModel.swift
//QuotesAPI
//
//Created by Basel Baragabah on 26/06/2020.
//Copyright © 2020 Basel Baragabah. All rights reserved.
//

import Foundation
import Unrealm

struct FavoritesQuotes: Realmable {
    var id: String? = ""
    var en: String? = ""
    var author: String? = ""
    
    static func primaryKey() -> String? {
        return "id"
    }
}

extension FavoritesQuotes {
    static func all(in realm: Realm = try! Realm()) -> Unrealm.Results<FavoritesQuotes> {
        return realm.objects(FavoritesQuotes.self)
    }
    
    @discardableResult
    static func add(id: String,en: String,author: String, in realm: Realm = try! Realm())
        -> FavoritesQuotes {
            let item = FavoritesQuotes(id: id, en: en, author: author)
            try! realm.write {
                realm.add(item)
            }
            return item
    }
    
    
    func delete() {
        guard let realm = try? Realm() else { return }
        try! realm.write {
            realm.delete(self)
        }
    }
}
