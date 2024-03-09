//
//  CardWiew.swift
//  DrgonBollWiki
//
//  Created by Esteban Perez Castillejo on 8/3/24.
//

import SwiftUI

struct CardWiew: View {
    
    @State private var homeViewModel: HomeViewModel
    @State private var planetsViewModel: PlanetsViewModel
    @State private var selectedCharacter: Character?
    @State private var selectedCharacterId: Int?
    
    /// View Properties
    @State private var isRotationEnabled: Bool = true
    @State private var showIndicator: Bool = false
    
    
    init(allCaractersDataService: AllCharactersProtocol, planetsDataSevice: PlanetsProtocol) {
        _homeViewModel = State(wrappedValue: HomeViewModel(allCaractersDataService: allCaractersDataService))
        _planetsViewModel = State(wrappedValue: PlanetsViewModel(planetsDataSevice: planetsDataSevice))
       
    }
    
    var body: some View {
        NavigationStack{
            VStack{
                GeometryReader{
                    let size = $0.size
                    if homeViewModel.isLoading{
                        ProgressView()
                    }else if let characters = homeViewModel.allCharacters {
                        ScrollView(.horizontal){
                            HStack(spacing: 0){
                                ForEach(characters.items, id:\.id){ character in
                                    ZStack{
                                       
                                        
                                    }
                                    .padding(.horizontal, 65)
                                    .frame(width: size.width)
                                    .visualEffect { content, geometryProxy in
                                        content
                                            .scaleEffect(scale(geometryProxy,scale: 0.1), anchor: .trailing)
                                            .rotationEffect(rotation(geometryProxy, rotation: isRotationEnabled ? 5 : 0))
                                            .offset(x: minX(geometryProxy))
                                            .offset(x: excessMinX(geometryProxy, offset: isRotationEnabled ? 8 : 10))
                                        
                                    }
                                   //.zIndex(items.zIndex(item))
                                }
                            }
                            .padding(.vertical, 15)
                            
                            
                        }
                    }
                    .scrollTargetBehavior(.paging)
                    .scrollIndicators(showIndicator ? .visible : .hidden)
                    .scrollIndicatorsFlash(trigger: showIndicator)
                }
                .frame(height: 410)
                .animation(.snappy, value: isRotationEnabled)
                VStack(spacing: 10){
                    Toggle("Rotation Enable", isOn: $isRotationEnabled)
                    Toggle("Shows Scrol Indiquetor", isOn: $showIndicator)
                }
                .padding(15)
                .background(.bar, in: .rect(cornerRadius: 10))
                .padding(15)
            }
            .navigationTitle("Stacked Cards")
        }
    }
    
    /// Card View
    @ViewBuilder
    func CardView(_ item: Item) -> some View {
        RoundedRectangle(cornerRadius: 15)
            .fill(item.color.gradient)
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
    CardWiew(allCaractersDataService: MockAllCharactersDataService(testData: nil), planetsDataSevice: MockPlanetsDataServcice(testData: nil))
}
