//
//  Menu.swift
//  Jason Decodable
//
//  Created by Daniel Tvorun on 18.07.2022.
//

struct Menu {
    private let items: [MenuItem] = [
        MenuItem(imageName: "numbers_icon", label: "Facts about numbers", id: Constants.Menu.numbersIdentifier),
        MenuItem(imageName: "nation_icon", label: "Nation by name", id: Constants.Menu.nationIdentifier),
        MenuItem(imageName: "memes_icon", label: "Random meme", id: Constants.Menu.memesIdentifier),
        MenuItem(imageName: "services_icon", label: "Facts about sites", id: Constants.Menu.serviceInfoIdentifier)
    ]
    
    public func getItemsCount() -> Int {
        return items.count
    }
    
    public func getItemImageName(by index: Int) -> String {
        return items[index].imageName
    }
    
    public func getItemLabel(by index: Int) -> String {
        return items[index].label
    }
    
    public func getItemId(by index: Int) -> String {
        return items[index].id
    }
}
