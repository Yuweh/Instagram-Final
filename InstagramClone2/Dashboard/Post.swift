//
//  Post.swift
//  InstagramClone2
//
//  Created by Republisys on 09/05/2018.
//  Copyright © 2018 Francis Jemuel Bergonia. All rights reserved.
//

import UIKit

class Post {
    
    var userName: String
    var photo: UIImage?
    
    init?(name: String, photo: UIImage?) {
        
        guard !name.isEmpty else {
            return nil
        }
        
        self.userName = name
        self.photo = photo
        
    }
    
}
