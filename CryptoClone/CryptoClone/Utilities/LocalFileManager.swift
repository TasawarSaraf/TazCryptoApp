//
//  LocalFileManager.swift
//  CryptoClone
//
//  Created by Tasawar Saraf on 6/29/22.
//

import Foundation
import SwiftUI


class LocalFileManager{
    
    static let instance = LocalFileManager()
    
    private init(){
        
    }
    
    // we can save the data of the image to the file manager
    

    
    func saveImage(image: UIImage, imageName: String, folderName: String){
        // create folder
        createFolderIfNeeded(folderName: folderName)
        
        // get path for image
        guard
            let data = image.pngData(),
            let url = getURLForImage(imageName: imageName, folderName: folderName)
        
        else {return}
        
        
        // save image to path
        do {
            try data.write(to: url)
        } catch let error{
            print("Error saving image \(imageName). \(error)")
        }
        
       
    }
    
    
    func getImage(imageName: String, folderName: String) -> UIImage?{
        guard let url = getURLForImage(imageName: imageName, folderName: folderName),
              FileManager.default.fileExists(atPath: url.path) else{
            return nil
        }
        
        // for file manager
        return UIImage(contentsOfFile: url.path)
        
    }
    
    
    // we need to make sure we create these folders
    private func createFolderIfNeeded(folderName: String){
        guard let url = getUrlForFolder(folderName: folderName) else {return}
        // if this folder does not exist
        if !FileManager.default.fileExists(atPath: url.path){
            do{
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            }catch let error{
                print("Error creating directory, Foldername: \(folderName). \(error)")
            }
        }
    }
    
    
    private func getUrlForFolder(folderName: String) -> URL?{
        
        
        
        guard  let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else{
            return nil
        }
        
        return url.appendingPathComponent(folderName)
        
        
    }
    
    
    
    private func getURLForImage(imageName: String, folderName: String) -> URL? {
        // first get folder url
        guard let folderURL = getUrlForFolder(folderName: folderName) else {
            return nil
        }
        // now append that image in that folder
        
        return folderURL.appendingPathComponent(imageName + ".png")
    }
}
