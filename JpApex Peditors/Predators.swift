//
//  Predators.swift
//  JpApex Peditors
//
//  Created by Aggelos Nimfopoulos on 5/4/26.
//

import Foundation

class Predators {
    var apexPredators: [ApexPredator] = []
    
    var allApexPredators: [ApexPredator] = []
    
    init(){
        decodeApexPredatorsData()
    }
    
    func decodeApexPredatorsData(){
        if let url = Bundle.main.url(forResource: "jpapexpredators", withExtension: "json"){
            do{
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                allApexPredators = try decoder.decode([ApexPredator].self, from: data)
                apexPredators = allApexPredators
            } catch {
                print(error)
            }
            
        }
    }
    
    
    func search(for searchTerm: String) -> [ApexPredator] {
        if searchTerm.isEmpty {
            return apexPredators
        }
        else{
            return apexPredators.filter{
                preditor in
                preditor.name.localizedCaseInsensitiveContains(searchTerm) //contains whatever we type in searchfield
            }
        }
    }
    
    
    func sort(by alphabetical: Bool) {//sort the list
        
        apexPredators.sort{predator1, predator2 in
            if alphabetical{
                return predator1.name < predator2.name
            }
            else{
                return predator1.id < predator2.id
            } // if alphabetical is true return the dinos from a -> z, else return by id = film year
            
        }
    }
        
        func filter(by type: APType){// it moves our items in a new "list"
            if type == .all {
                apexPredators = allApexPredators // we set a master allApexPredators property/collection to reset the filters, allApexPredators will never change after the decoding
            }else {
                apexPredators = allApexPredators.filter{ predator in
                    predator.type == type}
            }
        } // when the function is done, the list of the items it will be equal to the type that we selected
        
}
