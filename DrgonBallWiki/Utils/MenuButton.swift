//
//  MenuButton.swift
//  DrgonBollWiki
//
//  Created by Esteban Perez Castillejo on 1/4/24.
//

import SwiftUI

struct MenuButton: View {
    @Binding var isActivated: Bool
    @State var menuModel: MenuModel
    
    var currentItem: Int
    
    var body: some View {
        // esto le da foma he imagen al boton
        let menuItem = menuModel.menu[currentItem]
        return Circle()
            .fill(menuItem.color)
            .frame(width: isActivated ? 50 : 65, height: isActivated ? 50 :65)
            .overlay(Image("bol1")
                .shadow(radius: 5)
            )
        
    }
    
//     // funcion que actuliza la posicion del boton
//    func updateSelectad(){
//        let menuItem = menuModel.menu[currentItem]
//        for i in 0..<menuModel.menu.count{
//            menuModel.menu[i].selected = menuItem.id == menuModel.menu[i].id
//        }
//    }

//    //funcion que posiciona los botones en la vista
//    func calcOffset() -> (x: CGFloat, y: CGFloat){
//        switch menuModel.menu.count{
//        case 2:
//            switch currentItem{
//            case 0:
//                return (-70, -70)
//            default:
//                return (70, -70)
//            }
//        case 3:
//            switch currentItem{
//            case 0:
//                return (-70, -70)
//            case 1:
//                return (0, -70)
//            default:
//                return (70, -70)
//            }
//        case 4:
//            switch currentItem{
//            case 0:
//                return (-90, -40)
//            case 1:
//                return (-45, -110)
//            case 2:
//                return (45, -110)
//            default:
//                return (90, -40)
//            }
//        default: // casa 5
//            switch currentItem{
//            case 0:
//                return (-100, -20)
//            case 1:
//                return (-70, -80)
//            case 2:
//                return (0, -110)
//            case 3:
//                return (70, -80)
//            default:
//                return ( 100, -20)
//            }
//        }
//    }
//    
}

