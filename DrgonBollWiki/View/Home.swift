//
//  Home.swift
//  DrgonBollWiki
//
//  Created by Grupo de Estudio on 1/3/24.
//

import SwiftUI

struct Home: View {
    
    // MARK: - Se intacia SwiftData
    @State var dbSwiftDataModel: [DbSwiftDataModel]
    @State var favoriteDataBaseViewModel = DbSwiftDataViewModel.shared
    
    @State var singleCharacterViewModel: SingleCharacterViewModel = SingleCharacterViewModel()
    @State private var homeViewModel: HomeViewModel = HomeViewModel()
    @State private var planetsViewModel: PlanetsViewModel = PlanetsViewModel()
    @State private var selectedCharacter: Character = Character(id: 0, name: "", ki: "", maxKi: "", race: "", gender: "", description: "", image: "", affiliation: "", deletedAt: nil)
    
    @State private var favoritesStar = false
    @State private var isTribute = false
    
    // MARK: - Controla que vista se muestra
    @State private var selectedView = SelectedView.carousel
    
    @State private var offset: CGFloat = 0
    @State private var scrollSpeed: CGFloat = 0
    
    @Namespace var animation
    @State var showCharacterDetails: Bool = false
    @State var characterKiColor: Color = .yellow
    
    enum SelectedView {
        case carousel, cards, heroAnimation
    }
    
    
    init(dbSwiftDataModel: [DbSwiftDataModel]) {
        _dbSwiftDataModel = State(initialValue: dbSwiftDataModel)
    }
    
    
    let defaultBackgroundImage = "Dragon"
    
    var body: some View {
        NavigationStack{
            ZStack{
                if selectedView != .heroAnimation {
                    LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        .edgesIgnoringSafeArea(.all)
                    Image("Dragon").resizable()
                        .scaledToFit()
                        .frame(width: 600, height: 800)
                        .opacity(0.6)
                }
                
                switch selectedView {
                case .carousel:
                    CardViewCarousel(dbSwiftDataModel: [])
                case .cards:
                    CardView(dbSwiftDataModel: [])
                    .padding(.horizontal, 105)
                case .heroAnimation:
                    AllCharactersView(allCharacters: homeViewModel.allCharacters?.items ?? [], animation: animation, showDetails: $showCharacterDetails, selectedCharacter: $selectedCharacter, selectedKiColor: $characterKiColor)
                        .environment(singleCharacterViewModel)
                }
                
                VStack{
                    Spacer()
                    HStack(alignment: .top){
                        Image("Boll7")
                            .resizable()
                            .frame(width: 495, height: 495)
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
                            selectedView = .carousel
                        }) {
                          //  Image(systemName: (isShow == 1) ? "" : "checkmark")
                            Text("Vista de carrusel")
                            Image( "Boll7")
                                .resizable()
                                .frame(width: 10, height: 10)
                        }
                        .disabled(selectedView == .carousel)
                        
                        Button {
                            selectedView = .heroAnimation
                        } label: {
                            Text("Hero animation")
                        }
                        .disabled(selectedView == .heroAnimation)
                        
                        Button(action: {
                            selectedView = .cards
                        }) {
                           // Image(systemName: (isShow == 2) ? "" : "checkmark")
                            Text("Vista de cartas")
                            
                            Image( "Dragon")
                                .resizable()
                                .frame(width: 10, height: 10)
                        }
                        .disabled(selectedView == .cards)
                        
                        Button(action: {
                            //Acer algo
                        }) {
                            
                            //  Image(systemName: "person")
                            Text("Items")
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
                        // Logica que cambia el color de boton, segun seleccion 
                        if selectedView == .heroAnimation {
                            Image("logoGoku").resizable()
                                .renderingMode(.template)
                                .foregroundColor(.white).shadow(color:.blue, radius: 10)
                                .frame(width: 40, height: 50)
                                
                        }else{
                            Image("logoGoku").resizable()
                                .frame(width: 40, height: 50)
                                .shadow(color: .yellow, radius: 10)
                        }
                    }
                }
                ToolbarItem(placement: .navigation) {
                    Menu{
                        
                        Button(action: {
                            // Acción del botón de la barra de herramientas
                            isTribute = true
                        }) {
                            Text("Tributo a Akira Toriyama")
                            Image( "akira")
                                .resizable()
                                .frame(width: 10, height: 10)
                        }
                        
                    } label: {
                        Image(systemName: "info.circle").foregroundStyle(Color.black).bold().font(.custom("", size: 20))
                    }
                }
            }
            .sheet(isPresented: $isTribute, content: {
                CardViewTribute()
            })
        }
        .overlay {
            if showCharacterDetails {
                CharacterDetailView(showDetails: $showCharacterDetails, animation: animation)
                    .environment(singleCharacterViewModel)
                    .onDisappear {
                        favoriteDataBaseViewModel.getFavorites()
                    }
            }
        }
        .task {
            favoriteDataBaseViewModel.getFavorites()
        }
    }
}

#Preview {
    //para mostrar la data en el simulador, llamar a los Mocks. De esta forma no se está llamando todo el dato a la API y la carga de datos es más rápida.
    //nil nos muestra los datos que ya se encuentran hardcodeados en el Mock, pero si no queremos que sea nil, y queremos pasar nuestros propios valores para probar, podemos hacerlo
    Home(dbSwiftDataModel: [])
}
