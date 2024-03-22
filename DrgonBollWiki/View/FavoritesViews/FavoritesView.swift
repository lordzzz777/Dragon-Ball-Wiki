//
//  FavoritesView.swift
//  DrgonBollWiki
//
//  Created by Jacob Aguilar on 21-03-24.
//

import SwiftUI

struct FavoritesView: View {
    
    @Environment(SingleCharacterViewModel.self) var singleCharacterViewModel: SingleCharacterViewModel
    @State var favoriteDataBaseViewModel = DbSwiftDataViewModel.shared
    let grid = [GridItem(), GridItem()]
    var animation: Namespace.ID
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                Text("Favoritos")
                    .font(.custom("SaiyanSans", size: 60))
                    .foregroundStyle(Color.red)
                    .shadow(color: .black, radius: 0, x: 1, y: 1)
                    .shadow(color: .black, radius: 0, x: -1, y: -1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 10)
                
                Spacer()
            }
            
            ScrollView {
                LazyVGrid(columns: grid) {
                    ForEach(favoriteDataBaseViewModel.favoriteCharactersInfo, id: \.id) { favoriteCharacter in
                        FavoriteCardView(singleCharacter: favoriteCharacter, animation: animation)
                            .environment(singleCharacterViewModel)
                            .containerRelativeFrame(.vertical, count: 2, spacing: 0)
                            .scrollTransition { content, phase in
                                content
                                    .scaleEffect(phase.isIdentity ? 1 : 0.8)
                            }
                    }
                }
                .scrollTargetLayout()
            }
            .contentMargins(10, for: .scrollContent)
            .scrollTargetBehavior(.viewAligned)
        }
        .task {
            await favoriteDataBaseViewModel.getFavoriteCharactersInfo()
        }
    }
}

#Preview {
    @Namespace var animation
    @State var singleCharacterViewModel = SingleCharacterViewModel()
    
    return FavoritesView(animation: animation)
        .environment(singleCharacterViewModel)
}
