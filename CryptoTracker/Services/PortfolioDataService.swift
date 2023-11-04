//
//  PortfolioDataService.swift
//  CryptoTracker
//
//  Created by Anton Tropin on 31.10.23.
//

import Foundation
import CoreData

class PortfolioDataService {
    
    private let container: NSPersistentContainer
    private let containerName: String = "PortfolioContainer"
    private let entityName: String = "PortfolioEntity"
    
    @Published var savedEntities: [PortfolioEntity] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Error loading Core Data: \(error)")
            }
            self.getPortfolio()
        }
    }
    
}

// MARK: - PUBLIC METHODS

extension PortfolioDataService {
    func updatePortfolio(coin: Coin, amount: Double) {
        // check if coin is already in portfolio
        if let entity = savedEntities.first(where: { $0.coinID == coin.id }) {
            if amount > 0 {
                update(entity: entity, amount: amount)
            } else {
                delete(entity: entity)
            }
        } else {
            add(coin: coin, amount: amount)
        }
    }
}

// MARK: - PRIVATE METHODS

private extension PortfolioDataService {
    func getPortfolio() {
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error Fetching Portfolio Entities: \(error) ")
        }
    }
    
    func add(coin: Coin, amount: Double) {
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinID = coin.id
        entity.amount = amount
        applyChanges()
    }
    
    func update(entity: PortfolioEntity, amount: Double) {
        entity.amount = amount
        applyChanges()
    }
    
    func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error Saving to Core Data: \(error)")
        }
    }
    
    func delete(entity: PortfolioEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    func applyChanges() {
        save()
        getPortfolio()
    }
}
