//
//  WOFTableViewController.swift
//  WalkOfFame
//
//  Created by Jason Gresh on 10/18/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class WOFTableViewController: UITableViewController {
    var walks = [Walk]()
    var apiEndPoint = "https://data.cityofnewyork.us/resource/btth-hrxi.json"
    
    override func viewDidLoad() {
        super.viewDidLoad()
           }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
  

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return walks.count
    }
    
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
     func getResourceURL(from fileName: String, withExt ext: String) -> URL? {
        let fileURL: URL? = Bundle.main.url(forResource: fileName, withExtension: ext)
        
        return fileURL
    }
    
     func getData(from url: URL) -> Data? {
        let fileData: Data? = try? Data(contentsOf: url)
        return fileData
    }
    
     func getWalks(from jsonData: Data) -> [Walk]? {
        do {
            let walkJSONData: Any = try JSONSerialization.jsonObject(with: jsonData, options: [])
            if let walkArrayDict = walkJSONData as? [String:Any] {
                if let allWalkArray = walkArrayDict["data"] as? [[Any]] {
                    for el in allWalkArray {
                        if let w = Walk(withArray: el) {
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
        // Dispose of any resources that can be recreated.
        }

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


