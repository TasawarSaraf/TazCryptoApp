//
//  HomeViewModel.swift
//  CryptoClone
//
//  Created by Tasawar Saraf on 6/27/22.
//

import Foundation
import Combine

// we will be referencing this view model in multiple screens so put it is a environment object
class HomeViewModel: ObservableObject{
    
    @Published var statistics : [StatisticModel] = [
    
    ]
    // for our HomeView
    @Published var allCoins: [CoinModel] = []
    // for our PortfolioView
    @Published var portfolioCoins: [CoinModel] = []
    
    private let coinDataService = CoinDataService()// will automatically call the init
    
    private let marketDataService = MarketDataService()
    
    @Published var searchText: String = ""
    private var cancellables = Set<AnyCancellable>()
    
    init(){
       addSubscribers()
    }
    
    
    
    func addSubscribers(){
        // UPDATES ALL COINS
        // we are connecting them together
        // so anytime either of them change this value will be published
        // (text , and then coins from coin model
        $searchText
            .combineLatest(coinDataService.$allCoins).map(filterCoins)
        // debounce will wait 0.5 seconds in case someone types fast
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
          .sink { [weak self] (returnedCoins) in
            // once we filter it out append those returnedcoins onto allCoins
            self?.allCoins = returnedCoins
        }.store(in: &cancellables)
        
        
        // sink function converts it into a model
        marketDataService.$marketData.map(mapGlobalMarketData).sink { [weak self] (returnedStats) in
            self?.statistics = returnedStats
        }.store(in: &cancellables)
    }
    
    
    private func filterCoins(text: String, coins:[CoinModel]) -> [CoinModel]{
    
        guard !text.isEmpty else{
            return coins// if it is empty we just show the coins list
        }
        // if we lower case everything when searching
        
        let lowercaseText = text.lowercased()
        // startingcoins is an array
        let filteredCoins = coins.filter { (coin) -> Bool in
            // this is basically saying if the coin name has any element of the string that is being typed
            return coin.name.lowercased().contains(lowercaseText) || coin.symbol.lowercased().contains(lowercaseText) || coin.id.lowercased().contains(lowercaseText)
        }
        
        return filteredCoins
        
    }
    
    
    private func mapGlobalMarketData(marketDataModel: MarketDataModel?) -> [StatisticModel]{
        var stats: [StatisticModel] = []
        
        guard let data = marketDataModel else{
            return stats
        }
        
        let marketCap = StatisticModel(title: "MarketCap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        
        stats.append(marketCap)
        
        let volume = StatisticModel(title: "24H Volume", value: data.volume)
        
        stats.append(volume)
        
        let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)
        stats.append(btcDominance)
        
        
        let portfolio = StatisticModel(title: "Portfolio Value", value: "$0.00", percentageChange: 0)
        
        stats.append(portfolio)
        
        return stats
    }
}
