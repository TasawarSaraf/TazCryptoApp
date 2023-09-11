//
//  MarketDataService.swift
//  CryptoClone
//
//  Created by Tasawar Saraf on 7/4/22.
//




import Foundation
import Combine


// Services for third party

class MarketDataService{
    @Published var marketData: MarketDataModel? = nil
    // we can cancel this later on but
    var marketDataSubscription: AnyCancellable?
    
    init(){
        getData()
    }
    
    
    
    private func getData(){
        // need url to download data from
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else {return}
        
        marketDataSubscription =  NetworkingManager.download(url: url).decode(type: GlobalData.self, decoder: JSONDecoder()).sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedGlobal) in
            self?.marketData = returnedGlobal.data // this will now return the market data
            self?.marketDataSubscription?.cancel()
        })
        

        
        
    }
}
