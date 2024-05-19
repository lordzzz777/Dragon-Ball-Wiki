//
//  MenuItems.swift
//  DrgonBollWiki
//
//  Created by Esteban Perez Castillejo on 1/4/24.
//

import Foundation
import SwiftUI
import Observation

struct MenuItems {
    
    let id: Int
    let color: Color
    let icon: String
    let menuView: AnyView
    var selected: Bool

}

@Observable
class MenuModel {
   
    var menu: [MenuItems] = [
        MenuItems(id: 1, color: .blue, icon: "figure.walk", menuView: AnyView(Text("Vista 1")), selected: true),
        MenuItems(id: 2, color: .blue, icon: "figure.walk", menuView: AnyView(Text("Vista 2")), selected: false),
        MenuItems(id: 3, color: .blue, icon: "figure.walk", menuView: AnyView(Text("Vista 3")), selected: false),
    ]
    
    var selectedMenu: MenuItems {
        guard let selected = menu.filter({ $0.selected }).first else {
            fatalError("Error")
        }
        
        return selected
    }
    
}

