//
//  ContentView.swift
//  JpApex Peditors
//
//  Created by Aggelos Nimfopoulos on 5/4/26.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    let predators = Predators()
    
    @State var searchtext: String = ""
    @State var alphabetical = false
    @State var currentSelection: APType = APType.all
    
    var filteredPreditors: [ApexPredator] {

        var result = predators.apexPredators

        // Filter
        if currentSelection != .all {
            result = result.filter { predator in
                predator.type == currentSelection
            }
        }

        // Sort
        if alphabetical {
            result = result.sorted { first, second in
                first.name < second.name
            }
        }

        // Search
        if !searchtext.isEmpty {
            result = result.filter { predator in
                predator.name.localizedCaseInsensitiveContains(searchtext)
            }
        }

        return result
    }
    
    
//    OR
//    var filteredPreditors: [ApexPredator] {
//        predators.filter(by: currentSelection)
//        
//        
//        predators.sort(by: alphabetical)// right now the alphabetical is equal to false, so sort does not work
//        
//        return predators.search(for: searchtext)
//    }
    
    var body: some View {
        NavigationStack{
            List(filteredPreditors) { predator in
                NavigationLink{
                    
                    PreditorDetail(predator: predator, position: .camera(
                        MapCamera(
                            centerCoordinate:
                                predator.location,
                            distance: 30000
                        )))
                    
                } label: {
                    HStack{
                        //Dinosaur Image
                        Image(predator.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .shadow(color: .white, radius: 1)
                        
                        VStack(alignment: .leading){
                            //Dinosaur Name
                            Text(predator.name)
                                .fontWeight(.bold)
                            
                            Spacer()
                            //Dinosaur Type
                            Text(predator.type.rawValue.capitalized)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 5)
                                .background(predator.type.background)
                                .clipShape(.capsule)
   
                        }
                    }
                }
                
            }
            .navigationTitle(Text("Angry KFC Survivors"))
            .searchable(text: $searchtext, placement: .navigationBarDrawer(displayMode: .always)) //searchbar
            .autocorrectionDisabled()
            .animation(.default, value: searchtext)
            .toolbar{
                ToolbarItem(placement: .topBarLeading){
                    Button{
                        withAnimation{
                            alphabetical.toggle()
                        }
                    } label:{
                        Image(systemName: alphabetical ? "film" : "textformat")
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing){
                    Menu{
                        Picker("Filter by", selection: $currentSelection.animation()){
                            ForEach(APType.allCases){type in
                                Label(type.rawValue.capitalized, systemImage: type.icon)
                                    .tag(type)
                            }
                        }
                    } label:{
                        Image(systemName: "slider.horizontal.3")
                    }
                }
            }
        }
        .preferredColorScheme(.dark)
        
    }
}

#Preview {
    ContentView()
}
