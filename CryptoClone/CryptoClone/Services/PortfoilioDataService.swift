//
//  PortfoilioDataService.swift
//  CryptoClone
//
//  Created by Tasawar Saraf on 7/4/22.
//

import Foundation
import CoreData

class PortfolioDataService{
    
    private let container : NSPersistentContainer
    // our core data container name
    private let containerName = "portfolioContainer"
    
    // entitiy name
    private let entityName = "PortfolioEntity"
    
    // save the entities
    
    @Published var savedEntities: [PortfolioEntity] = []
    
    init(){
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error = error{
                print("Error loading core data \(error)")
            }
        }
    }
    
    private func getPortfolio(){
        // fetch request is generic
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        
        do{
            savedEntities = try container.viewContext.fetch(request)
        } catch let error{
            print("Error fetching Portfolio entities \(error)")
        }
    }
    
    private func add(coin: CoinModel, amount: Double){
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinID = coin.id
        entity.amount = amount
    }
    
}
