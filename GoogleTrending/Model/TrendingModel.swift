//
//  TrendingModel.swift
//  GoogleTrending
//
//  Created by Nguyễn Minh on 26/06/2021.
//

import Foundation
import SWXMLHash
import Alamofire

struct Trend: Codable{
    var title : String?
    var pudDate: Date?
    var pictureURL : String?
    var traffic : String?
    var item: [Items]?
    
}
struct Items: Codable {
    var title : String?
    var url: String?
    var snippet : String?
    var source : String?
    
}



