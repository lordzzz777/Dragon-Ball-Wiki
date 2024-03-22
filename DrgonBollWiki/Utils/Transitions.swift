//
//  Transitions.swift
//  DrgonBollWiki
//
//  Created by Jacob Aguilar on 22-03-24.
//

import SwiftUI

extension AnyTransition {
    static let hero = AnyTransition.modifier(active: HeroModifier(percentage: 1), identity: HeroModifier(percentage: 0))
    
    struct HeroModifier: AnimatableModifier {
        var percentage: Double
        
        var animatableData: Double {
            get {
                percentage
            }
            
            set {
                percentage = newValue
            }
        }
        
        func body(content: Content) -> some View {
            content
                .opacity(1)
        }
    }
}
