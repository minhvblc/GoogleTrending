//
//  YoutubeService.swift
//  GoogleTrending
//
//  Created by Nguyễn Minh on 01/07/2021.
//

import Foundation
import Alamofire

class YoutubeService {
    //Fetch data
    static let shared = YoutubeService()
    func getData(keyWord: String, region: String, order : String? ,completionBlock: @escaping ((VideoData?) -> Void)){
        let apiKey = "AIzaSyDZUSin7T5fFVITUzKzQXzBUZYOzQL-fxI"
        let parameter = ["part": "snippet", "key" : apiKey, "q" : keyWord, "regionCode": region, "order" : order]

        AF.request("https://www.googleapis.com/youtube/v3/search", method: .get, parameters: parameter).response{ response  in
            if let data = response.data {
                let decoder = JSONDecoder()
                                decoder.dateDecodingStrategy = .iso8601
                                do {
                
                                    let data = try decoder.decode(VideoData.self, from: data)
                                    completionBlock(data)
                
                                } catch  {
                                    print(error)
                                    completionBlock(nil)
                                }
            } else {
                completionBlock( nil)
            }
        }
    }
    func loadMoreData(keyWord: String, region: String, order : String?, nextPageToken: String ,completionBlock: @escaping ((VideoData?) -> Void)){
        let apiKey = "AIzaSyAM4S8_3klOi9sg3zqq7QeEtBQy7GI9WEk"
        let parameter = ["part": "snippet", "key" : apiKey, "q" : keyWord, "regionCode": region, "order" : order, "nextPageToken" : nextPageToken]

        AF.request("https://www.googleapis.com/youtube/v3/search", method: .get, parameters: parameter).response{ response  in
            if let data = response.data {
                let decoder = JSONDecoder()
                                decoder.dateDecodingStrategy = .iso8601
                                do {
                
                                    let data = try decoder.decode(VideoData.self, from: data)
                                    completionBlock(data)
                
                                } catch  {
                                    print(error)
                                    completionBlock(nil)
                                }
            } else {
                completionBlock( nil)
            }
        }
    }
}
