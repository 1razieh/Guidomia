//
//  WebService.swift
//  Guidomia
//
//  Created by Razieh Halimi on 2022-08-31.
//

import Foundation

enum NetWorkError: Error {
    case decodingError
    case urlError
}

class WebService {
    
    func getData(completion: @escaping([Car])-> Void) {
        if let fileLocation = Bundle.main.url(forResource: "data", withExtension: "json"){
            do {
                let content = try Data(contentsOf: fileLocation)
                guard parseJson(content) != nil else {
                    print(NetWorkError.decodingError.localizedDescription)
                    return
                }
                if let cars = self.parseJson(content) {
                    completion(cars)
                }
            }
            catch{
                print(NetWorkError.urlError.localizedDescription)
            }
        }
    }
        
    func parseJson(_ data: Data) -> [Car]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([Car].self, from: data)
            return decodedData
            
        } catch {
            print(NetWorkError.decodingError.localizedDescription)
            return nil
        }
    }
}
