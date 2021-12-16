//
//  PokedexListItem.swift
//  nxg7120-FinalProject
//
//  Created by Anita Jularic on 12/8/21.
//

import SwiftUI
import Kingfisher

struct PokedexListItem: View {
    var pokedex:Pokedex
    @ObservedObject var viewModel:PokedexViewModel
    // private let transaction:Transaction = .init(animation: .linear)
    
    var body: some View {
        VStack{
            ZStack{
                Ellipse().foregroundColor(pokedex.typeColor)
                    .frame(width: 150, height: 60)
                    .opacity(0.6)
                    .position(x: 80 , y: 100)
                VStack{
                    KFImage(pokedex.imageURL)
                        .resizable()
                        .scaledToFit()
                        .frame(width:120,height:120)
                    
                    Group{
                        HStack{
                            if viewModel.isFavorite(pokedex: pokedex){
                                Image(systemName: "heart.fill").foregroundColor(pokedex.typeColor)
                            }
                            Text("# \(pokedex.id)")
                        }
                        Text(pokedex.name.capitalizingFirstLetter())
                            .font(.headline)
                    }.foregroundColor(Color.black)
                }.padding(3)
            }
            
        }
    }
}

//struct PokedexListItem_Previews: PreviewProvider {
//    var pokedex:Pokedex
//    static var previews: some View {
//        PokedexListItem(pokedex: Pokedex(id: <#T##Int#>, name: "Lala")
//    }
//}
