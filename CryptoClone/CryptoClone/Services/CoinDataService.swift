//
//  CoinDataService.swift
//  CryptoClone
//
//  Created by Tasawar Saraf on 6/28/22.
//

import Foundation
import Combine


// Services for third party

class CoinDataService{
    @Published var allCoins: [CoinModel] = [] // publishers can have subscribers
    // we can cancel this later on but
    var coinSubscription: AnyCancellable?
    
    init(){
        getCoins()
    }
    
    
    
    private func getCoins(){
        // need url to download data from
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h") else {return}
        
        coinSubscription =  NetworkingManager.download(url: url).decode(type: [CoinModel].self, decoder: JSONDecoder()).sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedCoins) in
            self?.allCoins = returnedCoins
            self?.coinSubscription?.cancel()
        })
        

        
        
    }
}
