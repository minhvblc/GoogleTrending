//
//  TrendService.swift
//  GoogleTrending
//
//  Created by Nguyễn Minh on 01/07/2021.
//

import Foundation
import Alamofire
import SWXMLHash
class TrendService{
    static let shared = TrendService()
    func fetchData(region: String?,completionBlock: @escaping (([Trend]?) -> Void)) {
        
        AF.request("https://trends.google.com/trends/trendingsearches/daily/rss?geo=\(region ?? "VN")").responseString{response in
            var trends = [Trend]()
            switch response.result {
            case .success(let value):
                print(value)
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                    let xml = SWXMLHash.parse(value)
                    for trend in xml["rss"]["channel"]["item"].all{
                        
                        var items = [Items]()
                        
                        for item in trend["ht:news_item"].all{
                            let newItem = Items(title: item["ht:news_item_title"].element?.text, url: item["ht:news_item_url"].element?.text, snippet: item["ht:news_item_snippet"].element?.text, source: item["ht:news_item_source"].element?.text)
                            items.append(newItem)
                            
                        }
                        trends.append(Trend(title: trend["title"].element?.text, pudDate: String(htmlEncodedString: trend["pubDate"].element?.text ?? "")?.stringIntoDate()  , pictureURL: trend["ht:picture"].element?.text, traffic: trend["ht:approx_traffic"].element?.text, item: items))
                    }
                    
                    completionBlock(trends)
                    
                
            case .failure(let error):
                print(error)
                completionBlock(nil)
            }
            
        }
    }
}
