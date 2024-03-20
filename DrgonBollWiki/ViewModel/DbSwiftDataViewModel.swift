//
//  DbSwiftDataViewModel.swift
//  DrgonBollWiki
//
//  Created by Esteban Perez Castillejo on 7/3/24.
//

import SwiftUI
import SwiftData

@Observable
<<<<<<< HEAD
final class DbSwiftDataViewModel {
=======
final class DbSwiftDataViewModel{
>>>>>>> refs/remotes/origin/main
    static let shared = DbSwiftDataViewModel()
    let container = try! ModelContainer(for: DbSwiftDataModel.self)
    
    @MainActor
    var context: ModelContext{
        container.mainContext
    }
    
    var favorites: [DbSwiftDataModel] = []
    
    init() {}
    
    // MARK: - Se impemeta el metodo de predicado para el orden de lista
    @MainActor
    func getFavorites(){
        let fetchDescripttor = FetchDescriptor(predicate: nil, sortBy: [SortDescriptor <DbSwiftDataModel>(\DbSwiftDataModel.orden) ])
        do{
            favorites = try context.fetch(fetchDescripttor)
        }catch let error as NSError {
            print("Ups... Ocurrio un error -> ", error.localizedDescription)
        }
    }
    
    // MARK: - Se implementa el metodo que actualiza el orden dentro deuna lista...
    @MainActor
    func movieOdenList(from source: IndexSet, to destination: Int){
        var items = favorites
        items.move(fromOffsets: source, toOffset: destination)
        for i in 0..<items.count{
            items[i].orden = Int(i)
        }
        
        favorites = items
    }
    
    // MARK: - Guardar favorito
    @MainActor
    func saveFavorites(_ id: Int, _ isFavorites: Bool){
        let newFavorites = DbSwiftDataModel(id: id)
        context.insert(newFavorites)
        
        do{
            try context.save()
            favorites = []
            getFavorites()
            
            print("Guardado con exito id: \(id)")
        }catch let error as NSError{
            print("No se a guardado -> ", error.localizedDescription)
        }
    }
    
    @MainActor
    func deleteFavoriteWith(id: Int) {
        do {
            guard let favoriteToDelete = favorites.first(where: { $0.id == id }) else { return }
            context.delete(favoriteToDelete)
            try context.save()
            
            favorites = []
            getFavorites()
            
            print("Eliminado con éxito")
        } catch let error as NSError {
            // Si hay un error, lo imprimimos.
            print("No se ha borrado -> ", error.localizedDescription)
        }
    }
    
    // MARK: - Eliminar favorito
    @MainActor
    func deleteFavorites(){
        favorites.forEach{
            context.delete($0)
        }
        do{
            try context.save()
            favorites = []
            getFavorites()
            print("Eliminado con exito")
        }catch let error as NSError{
            print("No se ha borrado -> ", error.localizedDescription)
        }
    }
}
