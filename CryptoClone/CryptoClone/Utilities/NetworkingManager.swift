//
//  NetworkingManager.swift
//  CryptoClone
//
//  Created by Tasawar Saraf on 6/28/22.
//

import Foundation
import Combine


class NetworkingManager{
    
    // custom errors
    
    enum NetworkingError: LocalizedError{
        case badURLResponse(url: URL)
        case unknown
        
        var errorDescription: String? {
            // two selfs badURLResponse or unknown
            switch self{
            case .badURLResponse(url: let url): return "{🔥} Bad response from the URL \(url)"
                case .unknown: return "[⚠️] Unknown error occurred"
            }
        }
    }
    
    
    
    // a singleton function
    static func download(url: URL) -> AnyPublisher<Data,Error>{
        return URLSession.shared.dataTaskPublisher(for: url).subscribe(on: DispatchQueue.global(qos: .default)).tryMap({ try handleURLResponse(output: $0, url: url)}) .receive(on: DispatchQueue.main)
        // we want to convert this to ANYPUBLISHER<DATA,ERROR> TYPE
            .eraseToAnyPublisher()
    }
    
    
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data{
        // option click the output to see the type that is how I got the type
        // and returns data
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else{
                  throw NetworkingError.badURLResponse(url: url)
              }
        return output.data
    }
    
    
    static func handleCompletion(completion: Subscribers.Completion<Error>){
        switch completion{
            case .finished:
                break
            case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
