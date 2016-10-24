//
//  Walk.swift
//  WalkOfFame
//
//  Created by Jason Gresh on 10/18/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation

class Walk {
    let designer: String
    let description: String
    let location: String
    let sketchURLString: String
    
    init(designer: String, location: String, description: String, sketchURLString: String) {
        self.designer = designer
        self.description = description
        self.location = location
        self.sketchURLString = sketchURLString
    }
    
    convenience init?(withDict dict: [String:Any]) {
        if let design = dict["designer"] as? String,
            let descript = dict["info"] as? String,
            let loc = dict["location"] as? String,
            let sketch = dict["sketch_by_designer"] as? String  {
            self.init(designer: design, location: loc, description: descript, sketchURLString: sketch)
        }
        else {
            return nil
        }
    }
}
