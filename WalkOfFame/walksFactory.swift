//
//  walksFactory.swift
//  WalkOfFame
//
//  Created by Marcel Chaucer on 10/24/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation

class walksFactory {
    
    static let manager: walksFactory = walksFactory()
    private init() {}
    
    /// Attempts to make `[InstaCat]` from the `Data` contained in a local file
    /// - parameter filename: The name of the file containing json-formatted data, including its extension in the name
    /// - returns: An array of `InstaCat` if the file is located and has properly formatted data. `nil` otherwise.
    class func makeWalks(fileName: String) -> [Walk]? {
        
        // Everything from viewDidLoad in InstaCatTableViewController has just been moved here
        guard let walksURL: URL = walksFactory.manager.getResourceURL(from: fileName),
              let walksData: Data = walksFactory.manager.getData(from: walksURL),
              let allWalks: [Walk] = walksFactory.manager.getWalks(from: walksData)
        else {
                return nil
        }
        
        return allWalks
}

    fileprivate func getResourceURL(from fileName: String) -> URL? {
        
        guard let dotRange = fileName.rangeOfCharacter(from: CharacterSet.init(charactersIn: ".")) else {
            return nil
        }
        
        let fileNameComponent: String = fileName.substring(to: dotRange.lowerBound)
        let fileExtenstionComponent: String = fileName.substring(from: dotRange.upperBound)
        
        let fileURL: URL? = Bundle.main.url(forResource: fileNameComponent, withExtension: fileExtenstionComponent)
        
        return fileURL
    }
    
    /// Gets the `Data` from the local file located at a specified `URL`
    fileprivate func getData(from url: URL) -> Data? {
        
        let fileData: Data? = try? Data(contentsOf: url)
        return fileData
}
   func getWalks(from jsonData: Data) -> [Walk]? {
    do {
    let walkJSONData: Any = try JSONSerialization.jsonObject(with: jsonData, options: [])
    if let walkArrayDict = walkJSONData as? [String:Any] {
        if let allWalkArray = walkArrayDict["data"] as? [String: Any] {
    for el in allWalkArray {
    if let w = Walk(withDict: el) {
        walks.append(w)
        }
        }
        }
        }
    }
    catch let error as NSError {
        // JSONSerialization doc specficially says an NSError is returned if JSONSerialization.jsonObject(with:options:) fails
    print("Error occurred while parsing data: \(error.localizedDescription)")
    }
    
    print("Function Array Count \(walks.count)")
    return walks
}
    func getWalksTwo(from apiEndpoint: String, callback:@escaping ([Walk]?)->()) {
        if let validInstaCatEndpoint: URL = URL(string: apiEndpoint) {
            let session = URLSession(configuration: URLSessionConfiguration.default)
            session.dataTask(with: validInstaCatEndpoint) { (data: Data?, response: URLResponse?, error: Error?) in
                if error != nil {
                    print("Error encountered!: \(error!)")
                }
                if let validData: Data = data {
                    if let allTheWalks = self.getWalks(from: validData) {
                        callback(allTheWalks)
                        if error != nil {
                            print("Error encountered!: \(error!)")
                        }
                    }
                }
                }.resume()
        }
    }
    
    

    
}


