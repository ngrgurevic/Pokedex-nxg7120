import Foundation
import Combine
import SwiftUI

final class PokedexViewModel: ObservableObject {
    @Published private(set) var data: [Pokedex] = [] {
        didSet {
            updateSearchResults()
        }
    }
    var displayedData: [Pokedex] = []
    @Published private(set) var bookmarks: [Pokedex] = []
    @Published var isFavorite = false
    @Published var searchText = "" {
        didSet {
            updateSearchResults()
        }
    }
    
    private func updateSearchResults() {
        displayedData = {
            guard !searchText.isEmpty else { return data }
            return data.filter { pokedex in
                pokedex.name.localizedCaseInsensitiveContains(searchText) ||
                pokedex.type.localizedCaseInsensitiveContains(searchText)
            }
        }()
    }
    
    let userDefaults = UserDefaults.standard//UserDefaults(suiteName: "group.nxg7120")!
    
    private var cancellable: Set<AnyCancellable> = []
    
    init() {
        getData()
    }
    
    func getData() {
        guard let url = URL(string: "https://api.npoint.io/c5eda157e117ae5446a4") else {
            fatalError("Url cannot be created.")
        }
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        
        URLSession.shared
            .dataTaskPublisher(for: url)
            .tryMap({ $0.data })
            .decode(type: [Pokedex].self, decoder: jsonDecoder)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { print($0) },
                  receiveValue: {
                self.data = $0
            })
            .store(in: &cancellable)
    }
    
    var hasAppeared: Bool = false
    func onAppear() {
        defer { hasAppeared = true }
        guard !hasAppeared else { return }
        
        
        
        if let dataLoad = userDefaults.data(forKey: "bookmarks") {
            
            bookmarks = try! PropertyListDecoder().decode(Array<Pokedex>.self, from: dataLoad)
            
        }
        
    }
    func syncToUserDefaults() {
        print("synchronizing")
        userDefaults.set(try! PropertyListEncoder().encode(bookmarks/*TODO: .map(\.id)*/), forKey:"bookmarks")
    }
    
    func toggleBookmark(pokedex: Pokedex) {
        if let index = bookmarks.firstIndex(where: { $0.id == pokedex.id }) {
            bookmarks.remove(at: index)
        } else {
            bookmarks.append(pokedex)
        }
        syncToUserDefaults()
    }
    func isFavorite(pokedex: Pokedex) -> Bool {
        return bookmarks.contains(where: { $0.id == pokedex.id })
    }
    
    var filterPokemon: [Pokedex] {
        if searchText == "" {
            return data
        }
        else{
            return data
        }
    }
}
