//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Kian Chuan Ang on 24/3/15.
//  Copyright (c) 2015 kcology. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
    var filePathUrl: NSURL!
    var title: String!
    
    init(filePathUrl: NSURL, title: String){
        self.filePathUrl = filePathUrl
        self.title = title
    }
}
