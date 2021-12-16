//
//  SearchBar.swift
//  nxg7120-FinalProject
//
//  Created by Anita Jularic on 12/15/21.
//

import SwiftUI

struct PokedexSearchBar: View {
    @State var searchText:String
    @ObservedObject var viewModel:PokedexViewModel
    var pokedex:Pokedex
    
//    func filterName()
//    {
//        viewModel.data.filter({ $0.name == pokedex.name })
//    }
    
    var body: some View {
        TextField("Enter text", text: $searchText).onChange(of: searchText, perform: { newValue in
            
//            if newValue.contains(pokedex.name) {
//                filterName
//            }
//            else if newValue.contains(pokedex.type)
//            {
//                viewModel.data.filter({ $0.type == pokedex.type })
//            }
        })
    }
}

//struct SearchBar_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchBar()
//    }
//}
