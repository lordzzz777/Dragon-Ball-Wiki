//
//  CartButtoCustom.swift
//  DrgonBallWiki
//
//  Created by Esteban Perez Castillejo on 19/5/24.
//

import SwiftUI

struct CartButtonCustom: View {
    var body: some View {
        NavigationStack{
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }        
        .overlay(alignment: .bottomLeading) {
            FloatingButton{
                FloatingAction(symbol: "square.and.arrow.up.fill") {
                    print("Shere ")
                }
                
                FloatingAction(symbol: "tray.full.fill") {
                    print("tray")
                }
                
                FloatingAction(symbol: "lasso.badge.sparkles") {
                    print("Spark")
                }
                
                
                
            } label: { isExpande in
                Image(systemName: "plus")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .rotationEffect(.init(degrees: isExpande ?  45 : 0 ))
                    .scaleEffect(1.02)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.black, in: .circle)
                    /// Scaling effect When Expanded
                    .scaleEffect(isExpande ? 0.9 : 1)
            }
            .padding()
        }
    }
}

#Preview {
    CartButtonCustom()
}
