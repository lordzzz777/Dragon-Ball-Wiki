//
//  Card.swift
//  DrgonBollWiki
//
//  Created by Esteban Perez Castillejo on 3/3/24.
//

import SwiftUI

struct Card: View {
    let character: Character
    @State private var isFlipped = false
    
    var body: some View {
        VStack {
            if !isFlipped {
                AsyncImage(url: URL(string: character.image)) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 200, height: 200)
                .cornerRadius(10)
                .padding(.bottom, 10)
                
                Text(character.name)
                    .font(.title)
            } else {
                Text(character.description)
                    .font(.body)
                    .padding()
                    .fixedSize(horizontal: false, vertical: true) // Para adaptar el texto al tamaño de la tarjeta
            }
        }
        .padding()
        .background(Color.white.opacity(0.8)) // Opacidad para simular efecto de cristal
        .cornerRadius(10)
        .shadow(radius: 5)
        .rotation3DEffect(
            .degrees(isFlipped ? 180 : 0),
            axis: (x: 0.0, y: 1.0, z: 0.0)
        )
        .onTapGesture {
            withAnimation {
                isFlipped.toggle()
            }
        }
    }
}

// Vista auxiliar para aplicar el efecto de desenfoque
struct BlurView: UIViewRepresentable {
    let style: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}
//#Preview {
//    Card(character: <#Character#>)
//}
