//
//  PreditorDetail.swift
//  JpApex Peditors
//
//  Created by Aggelos Nimfopoulos on 12/4/26.
//

import SwiftUI
import MapKit

struct PreditorDetail: View {
    
    let predator: ApexPredator
    
    @State var position: MapCameraPosition
//    @State var showingMap: Bool = false
    
    var body: some View {
        GeometryReader{geo in
            ScrollView{
                ZStack(alignment: .bottomTrailing){
                    //background image
                    Image(predator.type.rawValue)
                        .resizable()
                        .scaledToFit()
                        .overlay {
                            LinearGradient(stops: [
                                Gradient.Stop(color: .clear, location: 0.8),
                                Gradient.Stop(color: .black, location: 1),
                            ], startPoint: .top, endPoint: .bottom)
                        }
                    
                    
                    // dino image
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width/1.5, height: geo.size.height/3.5)
//                        .border(Color.white, width: 2) //remove this
                        .scaleEffect(x: -1)
                        .shadow(color: .black, radius: 4)
                        .offset(x: 0.5 , y: 25)
                    
                }
                
                VStack(alignment: .leading){
                    //Dino name
                    Text(predator.name)
                        .font(.largeTitle)
                    
//                  Current location
                    Map(position: $position){
                        Annotation(predator.name, coordinate: predator.location) {
                            Image(predator.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .scaleEffect(x: -1)
                        }
                        
//                        .annotationTitles(.hidden)
                        
                    }
                    .frame(height: 150)
                    .clipShape(.rect(cornerRadius: 15))
//                    .disabled(true)
//                    .allowsHitTesting(false)

                    //Movie list
                    Text("Appears In:")
                        .font(.title3)
                        .padding()
                    
                    
                    ForEach(predator.movies, id: \.self){ movie in // For each array of strings, id\.self to be identifiable (the only way)
                        Text("• " + movie)
                            .font(.subheadline)
                    }
                    Spacer()
                    //Details
                    Text("Movie Moments:")
                        .font(.title)
                    
                    
                    ForEach(predator.movieScenes) { scene in
                        Text(scene.movie)
                            .font(.title2)
                            .padding(.vertical, 5)
                        
                        Text(scene.sceneDescription)
                            .font(.title3)
                            .padding(.bottom, 20)
                    }
                    
                    //Link to web page
                    Text("Learn more:")
                        .font(.caption)
                    
                    if let url = URL(string: predator.link) {
                        Link(predator.link, destination: url)
                            .font(.caption)
                            .padding(.bottom)
                    }
                    
                    
                }
                .padding()
                .frame(width: geo.size.width, alignment: .leading)
//                .border(Color.blue, width: 1)
            }
            
        }
        .ignoresSafeArea()
        .toolbarBackground(.automatic)
        
    }
}

#Preview {
    
    let predator = Predators().apexPredators[2]
    
    NavigationStack{
        PreditorDetail(predator: predator, position: .camera(
            MapCamera(
                centerCoordinate:
                    predator.location,
                distance: 30000
            )))
        .preferredColorScheme(ColorScheme.dark)
    }
}
