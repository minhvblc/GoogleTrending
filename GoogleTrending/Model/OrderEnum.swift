//
//  OrderEnum.swift
//  GoogleTrending
//
//  Created by Nguyễn Minh on 01/07/2021.
//

import Foundation
enum Order : String, CaseIterable{
    
    
    case date = "date"
    case rating = "rating"
    case relevance = "relevance"
    case title = "title"

    case viewCount = "viewCount"
}

let orders = ["Date", "Rating", "Relevance", "Title",  "ViewCount"]
