//
//  CoinImageService.swift
//  CryptoClone
//
//  Created by Tasawar Saraf on 6/28/22.
//

import Foundation
import SwiftUI
import Combine


class CoinImageService{
    
    
    @Published var image: UIImage? = nil
    private var imageSubscription: AnyCancellable?
    private let coin: CoinModel
    
    // file manager
    
    private let fileManager = LocalFileManager.instance
    
    private let folderName="coin_images"
    
    
    private let imageName: String
    init(coin: CoinModel){
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }
    
    // we want to save these images in a file manager
    
    // let us check if the image is saved in the file Manager
    

    
    
    private func getCoinImage(){
        if let savedImage = fileManager.getImage(imageName: coin.id, folderName: folderName){
            image = savedImage
            print("Retrieved image from File Manager")
        } else{
            // if it isn't saved we then download it and within this function it will then save it
            downloadCoinImage()
            print("Downloading images now")
        }
    }
    
    
    
    private func downloadCoinImage(){
        print("Downloading image now")
        // need url of this image , it isn't static it is dynamic
        guard let url = URL(string: coin.image) else {return}
        
        
        // download for us from the url
        imageSubscription =  NetworkingManager.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedImage) in
            guard let self = self, let downloadedImage = returnedImage else {return}
                self.image = downloadedImage
                self.imageSubscription?.cancel()
                self.fileManager.saveImage(image: downloadedImage, imageName: self.imageName, folderName: self.folderName)
        })
        
    }
}
