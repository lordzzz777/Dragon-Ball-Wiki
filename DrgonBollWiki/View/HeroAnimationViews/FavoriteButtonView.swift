//
//  FavoriteButtonView.swift
//  DrgonBollWiki
//
//  Created by Jacob Aguilar on 14-03-24.
//

import SwiftUI

struct FavoriteButtonView: View {
    
    @Binding var isFavorite: Bool
    private let favoriteAnimationDuration: Double = 0.12

    private var favoriteAnimationScale: CGFloat {
        isFavorite ? 0.7 : 1.5
    }
    
    @State private var animateFavorite: Bool = false
    
    var body: some View {
        Button {
            animateFavorite = true
            
            withAnimation(.easeIn(duration: favoriteAnimationDuration)) {
                DispatchQueue.main.asyncAfter(deadline: .now() + favoriteAnimationDuration) {
                    isFavorite.toggle()
                    animateFavorite = false
                }
            }
        } label: {
            Image(systemName: "star.fill")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundStyle(isFavorite ? .yellow : .gray)
        }
        .scaleEffect(animateFavorite ? favoriteAnimationScale : 1)
    }
}

#Preview {
    FavoriteButtonView(isFavorite: .constant(false))
}
