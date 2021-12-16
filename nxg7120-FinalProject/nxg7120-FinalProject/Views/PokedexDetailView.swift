import Foundation
import SwiftUI
import Kingfisher

struct PokedexDetailView: View {
    @ObservedObject var viewModel:PokedexViewModel
    var pokedex:Pokedex
    @State var attackValue = 0.0
    @State var defenseValue = 0.0
    @State var heightValue = 0.0
    @State var weightValue = 0.0
    var layout = Array(repeating: GridItem(.flexible()), count: 2)
    let rectangleBackground: some View = Rectangle()
        .cornerRadius(5)
        .shadow(color: Color.black , radius: 3, x: -5, y: -5)
        .opacity(0.2)
        .foregroundColor(Color.white)
    
    
    fileprivate func convertProgressValue(attack: Double,defense: Double,height: Double,weight: Double) {
        attackValue = attack
        defenseValue = defense
        heightValue = height
        weightValue = weight
        
    }
    private var bookmarksToggleButton: some View {
        Button(action: {
            self.viewModel.toggleBookmark(pokedex: self.pokedex)
        }) {
            if viewModel.isFavorite(pokedex: pokedex) {
                Image(systemName: "heat.fill")
            } else {
                Image(systemName: "heart")
            }
        }
    }
    
    private func imageURL(for pokedexID: Pokedex.ID) -> URL? {
        viewModel.data.first { $0.id == pokedexID }?.imageURL
    }
    
    var evolution: some View {
        VStack{
            Text("Evolution").font(.system(.headline,design: .monospaced))
        HStack
        {
            ForEach((pokedex.evolutionChain ?? []).filter { $0.id != pokedex.id}) { item in
                VStack{
                    KFImage(imageURL(for: item.id))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        . clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 6).frame(width: 60, height: 60))
                    Text("#\(item.id)").font(.system(.body,design: .monospaced))
                    Text(item.name.capitalizingFirstLetter()).font(.system(.body,design: .monospaced))
                }
            }
        }.padding(1)
        }
    }
    
    var stats:some View {
        
        VStack(alignment:.leading){
            Spacer().frame(height:30)
            
            LazyVGrid(columns: layout,alignment: .center)
            {
                Group{
                        ProgressView("Attack: \(pokedex.attack)pt", value: attackValue, total: 200).onAppear(perform: {
                            convertProgressValue(attack: Double(pokedex.attack),
                                                 defense: Double(pokedex.defense),
                                                 height: Double(pokedex.height)*10,
                                                 weight: Double(pokedex.weight))
                        })
                        ProgressView("Defense: \(pokedex.defense) pt", value: defenseValue, total: 200)
                        ProgressView("Height: \(pokedex.height)0 cm", value: heightValue, total: 1000)
                        ProgressView("Weight: \(pokedex.weight) kg", value: weightValue, total: 5000)
                }.font(.system(.body,design: .monospaced))
                    .padding()
            }
        }
    }
    
    var body: some View {
        
        ScrollView{
            Group{
                VStack{
                    Text("# \(pokedex.id)").padding(2).font(.system(.headline, design:.monospaced))
                    HStack{
                        Text(pokedex.name.capitalizingFirstLetter())
                            .font(.headline)
                        Text(pokedex.type.capitalizingFirstLetter())
                            .font(.body).foregroundColor(pokedex.typeColor)
                        Ellipse().foregroundColor(pokedex.typeColor).frame(width: 10, height: 10)
                    }
                }
                
            }.font(.system(.body,design: .monospaced))
            
            Spacer().frame(height:20)
            KFImage(pokedex.imageURL)
                .resizable()
                .scaledToFit()
                .frame(width:240,height:240)
                .clipShape(Circle())
                .overlay(Circle().stroke(pokedex.typeColor, lineWidth: 6).frame(width: 240, height: 240))
                .background(pokedex.typeBackground.clipShape(Circle()))
                .padding()
            
            VStack{
                Group{
                    evolution.background(rectangleBackground.frame(width: 220, height: 145))
                    PokedexDescriptionView(pokedex: pokedex)
                    VStack{
                        Text("Stats").font(.system(.headline,design: .monospaced))
                        stats
                    }.background(rectangleBackground).padding()
                    
                }
            }.background(pokedex.typeColor)
            
            
        }.background(Color.white)
        .navigationBarItems(trailing: Button(action: {
            viewModel.toggleBookmark(pokedex: pokedex)
            viewModel.isFavorite.toggle()}) {
                Image(systemName: viewModel.isFavorite(pokedex: pokedex) ? "heart.fill" : "heart").foregroundColor(pokedex.typeColor)
            })
        
    }
}

//struct PokedexDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        PokedexDetailView(viewModel: PokedexViewModel())
//    }
//}
