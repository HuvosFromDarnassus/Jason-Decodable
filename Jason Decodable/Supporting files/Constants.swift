//
//  Constants.swift
//  Jason Decodable
//
//  Created by Daniel Tvorun on 17.07.2022.
//

struct Constants {
    static let tableCellNibName = "NationTableViewCell"
    static let nationTableCellId = "tableCellReusableIdentifier"
    
    struct API {
        static let numbersAPI = "http://numbersapi.com/"
        static let nationAPI = "https://api.nationalize.io/?name="
        static let memesAPI = "https://api.imgflip.com/get_memes"
        static let serviceInfoAPI = "https://list.ly/api/v4/meta?url="
    }
    
    struct Menu {
        struct Title {
            static let menu = "📱 Menu"
            static let numbers = "🎱 Facts about numbers"
            static let nation = "🌎 Nation by name"
            static let memes = "😅 Random meme"
            static let services = "🌐 Facts about sites"
        }
        
        static let numbersIdentifier = "numbersIdentifier"
        static let nationIdentifier = "nationIdentifier"
        static let memesIdentifier = "memesIdentifier"
        static let serviceInfoIdentifier = "serviceInfoIdentifier"
        
        struct Image {
            static let numbers = "menu_numbers_image"
        }
    }
}
