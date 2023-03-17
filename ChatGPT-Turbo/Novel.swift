//
//  Novel.swift
//  ChatGPT-Turbo
//
//  Created by David_ADA on 2023/03/14.
//

import Foundation


class Novel {
    
    var title:String?
    var plot:String?
    var tag:[String]?
    
    init(title: String? = nil, plot: String? = nil, tag: [String]? = nil) {
        self.title = title
        self.plot = plot
        self.tag = tag
    }
    
}
