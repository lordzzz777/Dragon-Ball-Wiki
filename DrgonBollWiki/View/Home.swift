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
    
    @State private var homeViewModel: HomeViewModel
    @State private var planetsViewModel: PlanetsViewModel
    @State private var selectedCharacter: Character?
    
    @State private var favoritesStar = false
    @State private var isTribute = false
    
    // MARK: - Controla que vista se muestra
    @State private var selectedView = SelectedView.carousel
    
    @State private var offset: CGFloat = 0
    @State private var scrollSpeed: CGFloat = 0
    
    enum SelectedView {
        case carousel, cards, heroAnimation
    }
    
    
    init(allCaractersDataService: AllCharactersProtocol, planetsDataSevice: PlanetsProtocol, dbSwiftDataModel: [DbSwiftDataModel]) {
        _homeViewModel = State(wrappedValue: HomeViewModel(allCaractersDataService: allCaractersDataService))
        _planetsViewModel = State(wrappedValue: PlanetsViewModel(planetsDataSevice: planetsDataSevice))
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
                    CardViewCarousel(allCaractersDataService: AllCharactersDataService(),
                                     planetsDataSevice: PlanetsDataService(),
                                     dbSwiftDataModel: [])
                case .cards:
                    CardView(allCaractersDataService: AllCharactersDataService(),
                             dbSwiftDataModel: [])
                    .padding(.horizontal, 105)
                case .heroAnimation:
                    AllCharactersView(allCharacters: homeViewModel.allCharacters?.items ?? [])
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
                        Image("logoGoku").resizable()
                            .frame(width: 40, height: 50)
                            .foregroundStyle(Color.white)
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
    }
}

#Preview {
    //para mostrar la data en el simulador, llamar a los Mocks. De esta forma no se está llamando todo el dato a la API y la carga de datos es más rápida.
    //nil nos muestra los datos que ya se encuentran hardcodeados en el Mock, pero si no queremos que sea nil, y queremos pasar nuestros propios valores para probar, podemos hacerlo
    Home(allCaractersDataService: MockAllCharactersDataService(testData: nil), planetsDataSevice: MockPlanetsDataServcice(testData: nil), dbSwiftDataModel: [])
}
