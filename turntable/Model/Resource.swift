//
//  Resource.swift
//  turntable
//
//  Created by Mark Brown on 09/01/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import UIKit

class Resource: NSObject {
    
    var id: String?
    var name: String?
    var imageSmall: String?
    var imageLarge: String?
    
    override init() {
    }
    
    init(id: String, name: String, imageSmall: String?, imageLarge: String?) {
        self.id = id
        self.name = name
        if let imageSmall = imageSmall, let imageLarge = imageLarge {
            self.imageSmall = imageSmall
            self.imageLarge = imageLarge
        }
    }

} 

class Track: Resource {
    
    var artist: String?
    var runtime: String?
    
    override init(){
        super.init()
    }
    
    init(id: String, name: String, imageSmall: String?, imageLarge: String?, artist: String, runtime: String?) {
        super.init(id: id, name: name, imageSmall: imageSmall, imageLarge: imageLarge)
        self.artist = artist
        self.runtime = runtime
    }
    
    init(dictonary: [String: Any]) {
        super.init(id: dictonary["id"] as! String, name: dictonary["name"] as! String, imageSmall: (dictonary["imageSmall"] as! String), imageLarge: (dictonary["imageLarge"] as! String))
        self.artist = (dictonary["artist"] as! String)
        self.runtime = (dictonary["runtime"] as! String)
    }
    
    func formatDuration(duration: Int) {
        
        let duration = TimeInterval(duration)
        
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.minute, .second]
        formatter.zeroFormattingBehavior = [.pad]
        
        
        self.runtime = formatter.string(from: duration)
    }
    
}

class Artist: Resource {
    
    override init(id: String, name: String, imageSmall: String?, imageLarge: String?) {
        super.init(id: id, name: name, imageSmall: imageSmall, imageLarge: imageLarge)
    }
}
