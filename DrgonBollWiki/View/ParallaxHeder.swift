//
//  ParallaxHeder.swift
//  DrgonBollWiki
//
//  Created by Esteban Perez Castillejo on 1/3/24.
//

import SwiftUI

struct ParallaxHeder<Content:View>: View {
    
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        GeometryReader { geometry in
            let minX = geometry.frame(in: .global).minX
            
            content()
                .frame(
                    width: geometry.size.width,
                    height: geometry.size.height + max(minX, 10)
                )
                .offset(x:  +minX * 0.2)
              
        }
        
        
    }
    func liveScrol(_ index: Int) -> Bool {
        switch index {
        case 1:
           return true
        case 2:
            return false
        default:
            return false
        }
    }
}

