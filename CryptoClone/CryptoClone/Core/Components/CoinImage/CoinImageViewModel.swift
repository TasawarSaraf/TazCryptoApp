//
//  CoinImageViewModel.swift
//  CryptoClone
//
//  Created by Tasawar Saraf on 6/28/22.
//

import Foundation
import SwiftUI
import Combine

class CoinImageViewModel: ObservableObject{
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
  
    
    private var cancellables = Set<AnyCancellable>()
    private let dataService : CoinImageService
    private let coin : CoinModel
    
    init (coin: CoinModel){
        self.coin = coin
        // remember that url from that image if you paste it on google it will show up
        self.dataService = CoinImageService(coin: coin)
        self.addSubscribers()
        self.isLoading = true
    }
    
    private func addSubscribers(){
        dataService.$image.sink { [weak self] (_) in
            self?.isLoading = false
        } receiveValue: { [weak self] (returnedImage) in
            self?.image = returnedImage
        }.store(in: &cancellables)

    }
}
