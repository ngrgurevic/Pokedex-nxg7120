//
//  ContentView.swift
//  nxg7120-FinalProject
//
//  Created by Anita Jularic on 12/8/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = PokedexViewModel()
    
    var body: some View {
        
        TabView {
            PokedexListView(viewModel: viewModel, showFavorites: false)
                .tabItem({
                    VStack{
                        Image("pokeball").frame(width:20,height:20)
                        Text("Pokedex").foregroundColor(Color.black)
                    }.foregroundColor(Color.black)
                    
                })
            PokedexListView(viewModel: viewModel,showFavorites: true)
                .tabItem({
                    VStack{
                        Image("favorite").frame(width:20,height:20)
                        Text("Favorite Pokemon").foregroundColor(Color.black)
                    }.foregroundColor(Color.black)
                    
                }).navigationTitle("Favorite Pokemon")
                
        }.onAppear(perform: viewModel.onAppear)
        
        
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: PokedexViewModel())
    }
}
