import Foundation
import Combine
import SwiftUI

struct Pokedex: Codable,Identifiable {
    typealias ID = Int
    let id: Int
    let name, type: String
    let attack, height, weight, defense: Int
    let imageURL: URL?
    let welcomeDescription: String
    let evolutionChain: [EvolutionChain]?
    let welcomeDefense: Int?

    enum CodingKeys: String, CodingKey {
        case id, name, type, attack, height, weight, defense
        case imageURL = "imageUrl"
        case welcomeDescription = "description"
        case evolutionChain
        case welcomeDefense = "defense:"
    }
    
    var typeBackground: Image {
            switch type {
            case "fire":
                return Image("volcano")
            case "poison":
                return Image("forest")
            case "water":
                return Image("ocean")
            case "electric":
                return Image("electric")
            case "psychic":
                return Image("psychic")
            case "normal":
                return Image("normal")
            case "ground":
                return Image("ground")
            case "flying":
                return Image("sky")
            case "dragon":
                return Image("sky")
            case "fairy":
                return Image("fairy")
            case "steel":
                return Image("steel")
            case "ice":
                return Image("ice")
            case "fighting":
                return Image("fighting")
            case "rock":
                return Image("rock")
            case "bug":
                return Image("grass")
            default:
                return Image("pokeball")
            }
        }
    
    var typeColor: Color {
            switch type {
            case "fire":
                return Color(.systemRed)
            case "poison":
                return Color(.systemGreen)
            case "water":
                return Color(.systemTeal)
            case "electric":
                return Color(.systemYellow)
            case "rock":
                return Color(.systemGray2)
            case "psychic":
                return Color(.systemPurple)
            case "normal":
                return Color(.systemOrange)
            case "ground":
                return Color(.systemBrown)
            case "flying":
                return Color(.systemBlue)
            case "ice":
                return Color(.systemMint)
            case "steel":
                return Color(.systemGray)
            case "fairy":
                return Color(.systemPink)
            default:
                return Color(.systemIndigo)
            }
        }
}

// MARK: - EvolutionChain
struct EvolutionChain: Codable, Identifiable {
    let id: Pokedex.ID
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    
}
/**
 Because JSON was showing in evolutionChain id as String, I wrote decoder for EvolutionChain as extension
 */
extension EvolutionChain {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.init(
            id: try Int(container.decode(String.self, forKey: .id)) ?? { throw DecodingError.dataCorrupted(.init(codingPath: container.codingPath, debugDescription: "EvolutionChain ID is a String that cannot be converted to Int", underlyingError: nil)) }(),
            name: try container.decode(String.self, forKey: .name)
        )
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(String(describing: id), forKey: .id)
        try container.encode(name, forKey: .name)
    }
}

