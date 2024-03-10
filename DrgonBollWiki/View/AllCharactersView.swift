//
//  Home.swift
//  DrgonBollWiki
//
//  Created by Grupo de Estudio on 1/3/24.
//

import SwiftUI

struct AllCharactersView: View {
    @State var dbSwiftDataModel: [DbSwiftDataModel]
    @State var dbSwiftDataViewModel: DbSwiftDataViewModel
    @State private var homeViewModel: HomeViewModel
    @State private var planetsViewModel: PlanetsViewModel
    @State private var selectedCharacter: Character?
    @State private var selectedCharacterId: Int?
    
    @State private var isFlipped = false
    @State private var isShowDetails = false
    @State private var favoritesStar = false
    @State private var modeViewCard = false
    @State private var isProgress = 0.6
    
    @State var isShow: Int = 2
    @State var isShow2: Int = 1
    
    @State private var offset: CGFloat = 0
    @State private var scrollSpeed: CGFloat = 0
    
    
    /// View Properties
    @State private var isRotationEnabled: Bool = true
    @State private var showIndicator: Bool = false
    
    //@Environment (dbSwiftDataViewModel.self) var viewModelisFavorites
    
    let color: [Color] = [.red, .blue, .cyan, .yellow]
    let timer = Timer.publish(every: 0.02, on: .main, in: .common).autoconnect()
    
    
    init(allCaractersDataService: AllCharactersProtocol, planetsDataSevice: PlanetsProtocol, dbSwiftDataModel: [DbSwiftDataModel], dbSwiftDataViewModel: DbSwiftDataViewModel) {
        _homeViewModel = State(wrappedValue: HomeViewModel(allCaractersDataService: allCaractersDataService))
        _planetsViewModel = State(wrappedValue: PlanetsViewModel(planetsDataSevice: planetsDataSevice))
        _dbSwiftDataModel = State(initialValue: dbSwiftDataModel)
        _dbSwiftDataViewModel = State(initialValue: DbSwiftDataViewModel())
    }
    
    
    let defaultBackgroundImage = "Dragon"
    
    var body: some View {
        NavigationStack{
            ZStack{
                LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
                Image("Dragon").resizable()
                    .scaledToFit()
                
                    .frame(width: 600, height: 800)
                    .opacity(0.6)
                if liveScrol(isShow2) {
                    
                    if homeViewModel.isLoading{
                        ProgressView()
                    }else if let characters = homeViewModel.allCharacters {
                        NavigationStack{
                            VStack{
                                GeometryReader{ let size = $0.size
                                    ScrollView(.horizontal){
                                        HStack(spacing: 0){
                                            ForEach(characters.items, id:\.id){ character in
                                                ZStack{
                                                    ColorView(color: color[character.id % color.count]).padding(.bottom, 90)
                                                    // CardView( item, character)
                                                    Card(character: character, playSound: {
                                                        homeViewModel.playCardSound() }).shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                                                }                                        .contextMenu(ContextMenu(menuItems: {
                                                    Button(action: {
                                                        selectedCharacterId = character.id
                                                        isShowDetails = true
                                                    }, label: {
                                                        Text("Saber Mas")
                                                        Image(systemName: "book")
                                                    })
                                                    Button(action: {
                                                        //                                                favoritesStar = true
                                                        //                                                viewModelisFavorites.saveFavorites(character.id, favoritesStar)
                                                    }, label: {
                                                        Text("Guardar en favoritos")
                                                        Image(systemName: "star.fill")
                                                    })
                                                    
                                                    Button(action: {
                                                        // logica
                                                    }, label: {
                                                        Text("Compartir")
                                                        Image(systemName: "square.and.arrow.up")
                                                    })
                                                    
                                                    Button(action: {
                                                        // logica
                                                    }, label: {
                                                        Text("Copiar")
                                                        Image(systemName: "doc.on.doc")
                                                    })
                                                    
                                                }))
                                                .sheet(isPresented: $isShowDetails, content: {
                                                    DetailsView(singleCharactersDataService: SingleCharacterDataService(), characterId: selectedCharacterId ?? 1)
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
                                        Toggle("Rotation Enable", isOn: $isRotationEnabled)
                                        Toggle("Shows Scrol Indiquetor", isOn: $showIndicator)
                                    }
                                    .padding(15)
                                    .background(.bar, in: .rect(cornerRadius: 10))
                                    .padding(15)
                                    
                                }
                            }.padding(100)
                        }
                    }
                }else if liveScrol(isShow) {
                    if homeViewModel.isLoading{
                        ProgressView()
                    }else if let characters = homeViewModel.allCharacters {
                        ScrollView(.horizontal){
                            HStack{
                                ForEach(characters.items, id:\.id){ character in
                                    ZStack{
                                        ColorView(color: color[character.id % color.count]).padding(.bottom, 90).opacity(0.2)
                                        Card(character: character, playSound: {
                                            homeViewModel.playCardSound() })
                                        .padding()
                                        .onTapGesture {
                                            withAnimation {
                                                isFlipped.toggle()
                                            }
                                        }
                                    }
                                    .contextMenu(ContextMenu(menuItems: {
                                        Button(action: {
                                            selectedCharacterId = character.id
                                            isShowDetails = true
                                        }, label: {
                                            Text("Saber Mas")
                                            Image(systemName: "book")
                                        })
                                        Button(action: {
                                            //                                                favoritesStar = true
                                            //                                                viewModelisFavorites.saveFavorites(character.id, favoritesStar)
                                        }, label: {
                                            Text("Guardar en favoritos")
                                            Image(systemName: "star.fill")
                                        })
                                        
                                        Button(action: {
                                            // logica
                                        }, label: {
                                            Text("Compartir")
                                            Image(systemName: "square.and.arrow.up")
                                        })
                                        
                                        Button(action: {
                                            // logica
                                        }, label: {
                                            Text("Copiar")
                                            Image(systemName: "doc.on.doc")
                                        })
                                        
                                    }))
                                    .sheet(isPresented: $isShowDetails, content: {
                                        DetailsView(singleCharactersDataService: SingleCharacterDataService(), characterId: selectedCharacterId ?? 1)
                                    })
                                }
                            }.scrollTargetLayout()
                                .padding(.horizontal)
                        } .scrollTargetBehavior(.viewAligned)
                            .padding(.horizontal, 100)
                    }else {
                        VStack{
                            ProgressView(value: isProgress).progressViewStyle(.circular)
                            Text("Please wait ...")
                                .font(.title).bold()
                                .foregroundStyle(Color.white).shadow(radius: 10)
                        }
                        
                    }
                    
                    
                }
                
                VStack{
                    Spacer()
                    HStack(alignment: .top){
                        Image("Boll7")
                            .resizable()
                            .frame(width: 500, height: 500)
                            .padding(.leading, -130)
                            .padding(.bottom, -300)
                            .shadow(radius: 8)
                        Spacer()
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Menu{
                        Button(action: {
                            isShow = 2
                            isShow2 = 1
                        }) {
                            Text("Vista de Cartas")
                            Image( "Boll7")
                                .resizable()
                                .frame(width: 10, height: 10)
                        }
                        
                        Button(action: {
                            isShow = 1
                            isShow2 = 2
                        }) {
                            Text("Vista de carrusel")
                            
                            Image( "Dragon")
                                .resizable()
                                .frame(width: 10, height: 10)
                        }
                        
                        Button(action: {
                            // Acción del botón de la barra de herramientas
                            modeViewCard.toggle()
                        }) {
                            
                            //  Image(systemName: "person")
                            Text("Comfigurar vista de cartas")
                            Image( "Mutenroy")
                                .resizable()
                                .frame(width: 10, height: 10)
                        }
                        
                        Button(action: {
                            // Acción del botón de la barra de herramientas
                            
                        }) {
                            Text("Imet 3")
                            Image( "GokuPeque")
                                .resizable()
                                .frame(width: 10, height: 10)
                        }
                        
                    } label: {
                        Image("logoGoku").resizable()
                            .frame(width: 40, height: 50)
                    }
                    
                    
                    
                }
            }
            
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
    //para mostrar la data en el simulador, llamar a los Mocks. De esta forma no se está llamando todo el dato a la API y la carga de datos es más rápida.
    //nil nos muestra los datos que ya se encuentran hardcodeados en el Mock, pero si no queremos que sea nil, y queremos pasar nuestros propios valores para probar, podemos hacerlo
    AllCharactersView(allCaractersDataService: MockAllCharactersDataService(testData: nil), planetsDataSevice: MockPlanetsDataServcice(testData: nil), dbSwiftDataModel: [], dbSwiftDataViewModel: DbSwiftDataViewModel())
}
