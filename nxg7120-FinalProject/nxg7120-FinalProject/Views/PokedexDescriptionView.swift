//
//  PokedexDescription.swift
//  nxg7120-FinalProject
//
//  Created by Anita Jularic on 12/11/21.
//

import SwiftUI
import Combine

struct PokedexDescriptionView: View {
    var pokedex: Pokedex
    
    var body: some View {
            VStack{
                Text("About").font(.system(.headline,design: .monospaced)).ignoresSafeArea()
                Text(pokedex.welcomeDescription).padding()
            }
            .background(Rectangle()
                                .cornerRadius(5)
                                .shadow(color: Color.black , radius: 3, x: -5, y: -5)
                                .opacity(0.3)
                                .foregroundColor(Color.white)).padding()
    }
}

//struct PokedexDescriptionView_Previews: PreviewProvider {
//    static var previews: some View {
//        PokedexDescriptionView()
//    }
//}
