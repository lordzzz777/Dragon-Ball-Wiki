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
    @State private var isOffsetableScrollViewDraggedUp = false
    let grid = [GridItem(.flexible()), GridItem(.flexible())]
    var animation: Namespace.ID
    
    var body: some View {
        ZStack {
            OffsettableScrollView(showsIndicator: false) { point in
                if point.y < -20 {
                    withAnimation(.easeOut(duration: 0.3)) {
                        isOffsetableScrollViewDraggedUp = true
                    }
                }
                
                if point.y >= 0 {
                    withAnimation(.easeOut(duration: 0.2)) {
                        isOffsetableScrollViewDraggedUp = false
                    }
                }
            } content: {
                VStack {
                    LazyVGrid(columns: grid) {
                        ForEach(favoriteDataBaseViewModel.favoriteCharactersInfo, id: \.id) { favoriteCharacter in
                            FavoriteCardView(singleCharacter: favoriteCharacter, animation: animation)
                                .environment(singleCharacterViewModel)
                                .padding(.bottom, 20)
                            
                        }
                    }
                }
                .padding(.top, isOffsetableScrollViewDraggedUp ? 200 : 200)
                
            }
//            .contentMargins(10, for: .scrollContent)
//            .scrollTargetBehavior(.viewAligned)
            
            VStack {
                ZStack {
                    if isOffsetableScrollViewDraggedUp {
                        Rectangle()
                            .fill(.ultraThinMaterial)
                            .frame(maxWidth: .infinity, maxHeight: 100)
                    }
                    
                    Text("Favoritos")
                        .font(.custom("SaiyanSans", size: isOffsetableScrollViewDraggedUp ? 20 : 60))
                        .foregroundStyle(Color.red)
                        .shadow(color: .black, radius: 0, x: 1, y: 1)
                        .shadow(color: .black, radius: 0, x: -1, y: -1)
                        .frame(maxWidth: .infinity, alignment: isOffsetableScrollViewDraggedUp ? .center : .leading)
                        .padding(.top, isOffsetableScrollViewDraggedUp ? 70 : 100)
                        .padding(.leading, 10)
                }
                
                Spacer()
            }
        }
        .task {
            await favoriteDataBaseViewModel.getFavoriteCharactersInfo()
        }
        .toolbarBackground(.hidden, for: .navigationBar)
        .ignoresSafeArea()
    }
}

#Preview {
    @Namespace var animation
    @State var singleCharacterViewModel = SingleCharacterViewModel()
    
    return FavoritesView(animation: animation)
        .environment(singleCharacterViewModel)
}
