//
//  DrgonBollWikiApp.swift
//  DrgonBollWiki
//
//  Created by Grupo de Estudio on 1/3/24.
//

import SwiftUI
import SwiftData

@main
struct DrgonBollWikiApp: App {
   
    var body: some Scene {
        WindowGroup {
     //       CardListAudioView()
           ContentView()
               .environment(DbSwiftDataViewModel())
           
        }
    }
}
