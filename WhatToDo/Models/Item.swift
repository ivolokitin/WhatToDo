//
//  Item.swift
//  WhatToDo
//
//  Created by Ivan Volokitin on 30.04.2020.
//  Copyright © 2020 Ivan Volokitin. All rights reserved.
//

import Foundation

class Item {
    
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

extension Item {
    
    static func itemList() -> [Item] {
        return [
            Item(name: "Play with your pet"),
            Item(name: "1 min. plank"),
            Item(name: "Charge your device"),
            Item(name: "Start reading new book"),
            Item(name: "List your favourite comics"),
            Item(name: "Meditate for 2 minutes"),
            Item(name: "Clarify your goals for next quarter"),
            Item(name: "Figure out what's new in AppStore"),
            Item(name: "Immerse yourself in most hateful activity for 10 min."),
            Item(name: "Add new habit for next week")
        ]
    }
}
