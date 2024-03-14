//
//  StyleColor.swift
//  DrgonBollWiki
//
//  Created by Esteban Perez Castillejo on 13/3/24.
//

import SwiftUI

struct StyleColorDegrader: ViewModifier {
    var isColor: Color
    var isColor2: Color
    
    func body(content: Content) -> some View {
        content
            .containerRelativeFrame([.horizontal, .vertical]).background(Gradient(colors: [ isColor, isColor2]))
    }
}

struct CustomFond: ViewModifier {
   
    var size: CGFloat
    var shadow: CGFloat
    var colorShadow: Color
    var colorFont: Color
    
    func body(content: Content) -> some View {
        content
            .font(.custom("SaiyanSans", size: size))
            .foregroundStyle(colorFont)
            .shadow(color: colorShadow ,radius: shadow)
    }
}
