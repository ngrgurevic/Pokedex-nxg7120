//
//  PokedexListView.swift
//  nxg7120-FinalProject
//
//  Created by Anita Jularic on 12/8/21.
//

import SwiftUI

struct PokedexListView: View {
    @ObservedObject var viewModel:PokedexViewModel
    @State var showFavorites:Bool
    var layout = Array(repeating: GridItem(.flexible()), count: 2)
    
    var body: some View {
        NavigationView{
            ScrollView{
                if showFavorites
                {
                    LazyVGrid(columns: layout, spacing: 20){
                        ForEach(viewModel.bookmarks){ pokedex in
                            NavigationLink(destination: PokedexDetailView(viewModel: viewModel,pokedex: pokedex))
                            {
                                PokedexListItem(pokedex: pokedex, viewModel: viewModel)
                            }
                        }
                    }.navigationTitle("Favorite Pokemon")
                    .background(Color("lightPurple"))
                }
                else{
                    LazyVGrid(columns: layout, spacing: 20){
                        ForEach(viewModel.displayedData){ pokedex in
                            NavigationLink(destination: PokedexDetailView(viewModel: viewModel,pokedex: pokedex))
                            {
                                PokedexListItem(pokedex: pokedex, viewModel: viewModel)
                            }
                        }
                    }.navigationTitle("Pokedex")
                    .background(Color("lightPurple"))
                }
            }
            .searchable(text: $viewModel.searchText)
            .background(Color("darkPurple"))
            .navigationBarTitleDisplayMode(.inline)
            
        }
    }
}
