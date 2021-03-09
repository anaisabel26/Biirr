//
//  Beer.swift
//  Biirr
//
//  Created by Ana Márquez on 05/03/2021.
//

import Foundation

struct Beer: Equatable {
    static func == (lhs: Beer, rhs: Beer) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id: String
    var name: String
    var displayName: String
    var abv: Double?
    var ibu: Double?
    var isOrganic: Bool
    var labels: Labels?
    var style: Style?
    
    static var empty: Beer {
        return Beer(data: ["id": "empty"])
    }
    
    var bitter: String? {
        guard let ibu = self.ibu else { return nil }
        return ibu <= 20.0 ? "Smooth" : ibu <= 50 ? "Bitter" : "Hipster Plus"
    }
    
    init(data: [String: Any]? = nil) {
        self.id = data?["id"] as? String ?? ""
        self.name = data?["name"] as? String ?? ""
        self.displayName = data?["nameDisplay"] as? String ?? ""
        self.abv = Double(data?["abv"] as? String ?? "")
        self.ibu = Double(data?["ibu"] as? String ?? "")
        self.isOrganic = ((data?["isOrganic"] as? String ?? "N") == "Y")
        self.labels = Labels(data: data?["labels"] as? [String: Any])
        
        self.style = Style(data: (data?["style"] as? [String: Any] ?? [:]))
    }
}

struct Labels {
    var iconImage: String?
    var largeIconImage: String?
    
    init?(data: [String: Any]? = nil) {
        if data == nil { return nil }
        self.iconImage = data?["icon"] as? String
        self.largeIconImage = data?["large"] as? String
    }
}

struct Style {
    var id: String
    var category: Category?
    var name: String
    var description: String
    var ibuMin: String
    var ibuMax: String
    var abvMin: String
    var abvMax: String
    
    init?(data: [String: Any]? = nil) {
        if data == nil { return nil }
        
        self.id = data?["id"] as? String ?? ""
        self.name = data?["name"] as? String ?? ""
        self.description = data?["description"] as? String ?? ""
        self.ibuMin = data?["ibuMin"] as? String ?? ""
        self.ibuMax = data?["ibuMin"] as? String ?? ""
        self.abvMin = data?["abvMin"] as? String ?? ""
        self.abvMax = data?["abvMax"] as? String ?? ""
        
        self.category = Category(data: (data?["category"] as? [String: Any] ?? [:]))
    }
}

struct Category {
    var id: String
    var name: String
    
    init?(data: [String: Any]? = nil) {
        if data == nil { return nil }
        
        self.id = data?["id"] as? String ?? ""
        self.name = data?["name"] as? String ?? ""
    }
}
