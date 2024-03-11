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
    @State var dbSwiftDataViewModel: DbSwiftDataViewModel
    
    @State private var homeViewModel: HomeViewModel
    @State private var planetsViewModel: PlanetsViewModel
    @State private var selectedCharacter: Character?
    @State private var selectedCharacterId: Int?
    
    
    @State private var favoritesStar = false
    @State private var isTribute = false
    
    // MARK: - Numero de incice para el cambio de vistas
    @State var isShow: Int = 2
    @State var isShow2: Int = 1
    
    @State private var offset: CGFloat = 0
    @State private var scrollSpeed: CGFloat = 0
    
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
                
                if homeViewModel.liveScrol(isShow) {
                    
                    // MARK: - View the CardView
                    CardView(allCaractersDataService: AllCharactersDataService(),
                             dbSwiftDataModel: [],
                             dbSwiftDataViewModel: DbSwiftDataViewModel()).padding(.horizontal ,105)
                    
                    
                }else if homeViewModel.liveScrol(isShow2) {
                    
                    // MARK: - View the CardViewCarousel
                    CardViewCarousel(allCaractersDataService: AllCharactersDataService(),
                                     planetsDataSevice: PlanetsDataService(),
                                     dbSwiftDataModel: [],
                                     dbSwiftDataViewModel: DbSwiftDataViewModel())
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
                            isShow = 2
                            isShow2 = 1
                        }) {
                          //  Image(systemName: (isShow == 1) ? "" : "checkmark")
                            Text("Vista de carrusel")
                            Image( "Boll7")
                                .resizable()
                                .frame(width: 10, height: 10)
                        }.disabled((((isShow == 2) ? 2 : 1) == 2))
                        
                        Button(action: {
                            isShow = 1
                            isShow2 = 2
                        }) {
                           // Image(systemName: (isShow == 2) ? "" : "checkmark")
                            Text("Vista de cartas")
                            
                            Image( "Dragon")
                                .resizable()
                                .frame(width: 10, height: 10)
                        }.disabled((((isShow == 1) ? 1 : 2) == 1))
                        
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
    Home(allCaractersDataService: MockAllCharactersDataService(testData: nil), planetsDataSevice: MockPlanetsDataServcice(testData: nil), dbSwiftDataModel: [], dbSwiftDataViewModel: DbSwiftDataViewModel())
}
