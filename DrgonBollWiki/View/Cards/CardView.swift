//
//  CardView.swift
//  DrgonBollWiki
//
//  Created by Esteban Perez Castillejo on 8/3/24.
//

import SwiftUI


struct CardView: View {
    
    // MARK: - Se intacia SwiftData
    @State var dbSwiftDataModel: [DbSwiftDataModel]
    @Environment (DbSwiftDataViewModel.self) var viewModelisFavorites
    
    // MARK: - Se intacias modelos y el ViewModel de Personajes
    @State private var homeViewModel: HomeViewModel
    @State private var selectedCharacter: Character?
    @State private var selectedCharacterId: Int?
    
    // MARK: - View Properties
    @State private var modeViewCard = false
    @State private var isRotationEnabled: Bool = true
    @State private var showIndicator: Bool = false
    @State private var isShowDetails = false
    @State private var favoritesStar = false
    
    let color: [Color] = [.red, .blue, .cyan, .yellow, .gray, .green, .indigo]
    let timer = Timer.publish(every: 0.02, on: .main, in: .common).autoconnect()
    
    init(allCaractersDataService: AllCharactersProtocol, dbSwiftDataModel: [DbSwiftDataModel]) {
        _homeViewModel = State(wrappedValue: HomeViewModel(allCaractersDataService: allCaractersDataService))
        _dbSwiftDataModel = State(initialValue: dbSwiftDataModel)
       
    }
    
    var body: some View {
        NavigationStack{
            VStack{
                if homeViewModel.isLoading{
                    ProgressView()
                }else if let characters = homeViewModel.allCharacters {
                    GeometryReader{ let size = $0.size
                        ScrollView(.horizontal){
                            HStack(spacing: 0){
                                ForEach(characters.items, id:\.id){ character in
                                    ZStack{
                                        ColorView(color: color[character.id % color.count]).padding(.bottom, 90)
                                        
                                        Card(character: character, playSound: {
                                            homeViewModel.playCardSound() }).shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                                    }.contextMenu(ContextMenu(menuItems: {
                                        Button(action: {
                                            favoritesStar = true
                                            viewModelisFavorites.saveFavorites(character.id, favoritesStar)
                                        }, label: {
                                            Text("Guardar en favoritos")
                                            Image(systemName: "star.fill")
                                        })
                                        
                                        Button(action: {
                                            withAnimation{
                                                modeViewCard = true
                                            }
                                        }, label: {
                                            Text("Personalizar")
                                            Image(systemName: "gearshape.fill" )
                                            
                                        })
                                        
                                        Button(action: {
                                            selectedCharacterId = character.id
                                            isShowDetails = true
                                        }, label: {
                                            Text("Saber Mas")
                                            Image(systemName: "book")
                                        })
                                        
                                        Button(action: {
                                            // logica
                                        }, label: {
                                            Text("Copiar")
                                            Image(systemName: "doc.on.doc")
                                        })
                                        
                                    }))
                                    .sheet(isPresented: $isShowDetails, content: {
                                        DetailsView(selectedCharacter: character)
                                    })
                                    .padding(.horizontal, 65)
                                    .frame(width: size.width)
                                    .visualEffect { content, geometryProxy in
                                        content
                                            .scaleEffect(scale(geometryProxy,scale: 0.1), anchor: .trailing)
                                            .rotationEffect(rotation(geometryProxy, rotation: isRotationEnabled ? 5 : 0))
                                            .offset(x: minX(geometryProxy))
                                            .offset(x: excessMinX(geometryProxy, offset: isRotationEnabled ? 8 : 10))
                                        
                                    }
                                    .zIndex(characters.items.zIndex(character))
                                    
                                }
                            }
                            .padding(.vertical, 15)
                            
                            
                        }
                        .scrollTargetBehavior(.paging)
                        .scrollIndicators(showIndicator ? .visible : .hidden)
                        .scrollIndicatorsFlash(trigger: showIndicator)
                    }
                    .frame(height: 410)
                    .animation(.snappy, value: isRotationEnabled)
                    if modeViewCard {
                        VStack(spacing: 10){
                            HStack{
                                Text("Pesonalizar").bold()
                                Spacer()
                                Button(action: {
                                    withAnimation{
                                        modeViewCard = false
                                    }
                                }, label: {
                                    Image(systemName: "x.square.fill").foregroundStyle(Color.red)
                                })
                            }
                            Divider()
                            Toggle("Rotation Enable", isOn: $isRotationEnabled)
                            Toggle("Shows Scrol Indiquetor", isOn: $showIndicator)
                        }
                        .padding(15)
                        .background(.bar, in: .rect(cornerRadius: 10))
                        .padding( 15)
                        
                    }
                }
            }
            
        }
    }
    
    /// Stacked Card Animation
    func minX(_ proxy: GeometryProxy) -> CGFloat {
        let minX = proxy.frame(in: .scrollView(axis: .horizontal)).minX
        return minX < 0 ? 0: -minX
    }
    
    func progress(_ proxy: GeometryProxy, limit: CGFloat = 2) -> CGFloat {
        let maxX = proxy.frame(in: .scrollView(axis: .horizontal)).maxX
        let width = proxy.bounds(of: .scrollView(axis: .horizontal))?.width ?? 0
        
        /// Converting into Progress
        let progress = (maxX / width) - 1.0
        let cappedProgress = min(progress, limit)
        
        return cappedProgress
    }
    
    func scale(_ proxy: GeometryProxy, scale: CGFloat = 0.1) -> CGFloat {
        let progress = progress(proxy, limit: 3)
        
        return 1 - (progress * scale)
    }
    
    func excessMinX(_ proxy: GeometryProxy, offset: CGFloat = 10) -> CGFloat {
        let process = progress(proxy)
        
        return process * offset
    }
    
    func rotation(_ proxy: GeometryProxy, rotation: CGFloat = 5) -> Angle {
        let process = progress(proxy)
        
        return .init(degrees: process * rotation)
    }
    
}

#Preview {
    CardView(allCaractersDataService: AllCharactersDataService(), dbSwiftDataModel: [])
}


