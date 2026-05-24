//
//  PredatorMapView.swift
//  JpApex Peditors
//
//  Created by Aggelos Nimfopoulos on 24/5/26.
//

import SwiftUI
import MapKit

struct PredatorMapView: View {
    
    let predators = Predators()
    let predator : ApexPredator
    
    @State var position: MapCameraPosition
    @State var globalView: Bool = false

    var body: some View {
        
        ZStack(alignment: .bottomTrailing){
            Map(position: $position){
                ForEach(predators.apexPredators) { predator in
                    Annotation(predator.image, coordinate: predator.location) {
                        Image(predator.image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 100)
                            .scaleEffect(x: -1)
                            .shadow(color: .white, radius:4)
                    }
                    .annotationTitles(.hidden)
                }
            }
            .mapStyle(
                globalView
                ? .imagery(elevation: .realistic)
                : .standard
            )
            
            
            Button{
                
                globalView.toggle()
                
                withAnimation(.easeInOut(duration: 4)){
                    
                    if globalView{
                        position = .camera(
                            MapCamera(
                                centerCoordinate: predator.location,
                                distance: 40000000
                            )
                        )
                    }
                    
                    else {
                        position = .camera(
                            MapCamera(
                                centerCoordinate: predator.location,
                                distance: 1000,
                                heading: 250,
                                pitch: 80
                            )
                        )
                    }
                    
                }
                
            } label: {
                Image(systemName: "globe")
            }
            .font(.largeTitle)
            .imageScale(.large)
            .background(.black.opacity(0.7))
            .clipShape(.rect(cornerRadius: 100))
            .padding(3)
        }
        
    }
}

#Preview {
    PredatorMapView(predator: Predators().apexPredators[0], position: .camera(MapCamera(
        centerCoordinate: Predators().apexPredators[0].location,
        distance: 1000,
        heading: 250,
        pitch: 80))
    )
}
