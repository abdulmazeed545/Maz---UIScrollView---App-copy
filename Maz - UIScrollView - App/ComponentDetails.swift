//
//  ComponentDetails.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on December 28, 2020

import Foundation

struct ComponentDetails : Codable {

        let axis : String?
        let changeQuantity : Bool?
        let component : String?
        let displayNumbers : Bool?
        let maxPerColumn : Int?
        let maxPerRow : Int?
        let quantity : Int?

        enum CodingKeys: String, CodingKey {
                case axis = "axis"
                case changeQuantity = "changeQuantity"
                case component = "component"
                case displayNumbers = "displayNumbers"
                case maxPerColumn = "maxPerColumn"
                case maxPerRow = "maxPerRow"
                case quantity = "quantity"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                axis = try values.decodeIfPresent(String.self, forKey: .axis)
                changeQuantity = try values.decodeIfPresent(Bool.self, forKey: .changeQuantity)
                component = try values.decodeIfPresent(String.self, forKey: .component)
                displayNumbers = try values.decodeIfPresent(Bool.self, forKey: .displayNumbers)
                maxPerColumn = try values.decodeIfPresent(Int.self, forKey: .maxPerColumn)
                maxPerRow = try values.decodeIfPresent(Int.self, forKey: .maxPerRow)
                quantity = try values.decodeIfPresent(Int.self, forKey: .quantity)
        }

}
