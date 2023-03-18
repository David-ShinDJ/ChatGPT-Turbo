//
//  Novel.swift
//  ChatGPT-Turbo
//
//  Created by David_ADA on 2023/03/14.
//

import Foundation


class Novel {
    
    let title:String
    let plot:String
    let tag:[String]
    
    init(title: String, plot: String, tag: [String]) {
        self.title = title
        self.plot = plot
        self.tag = tag
    }
    
    
}
