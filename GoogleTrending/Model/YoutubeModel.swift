//
//  YoutubeModel.swift
//  GoogleTrending
//
//  Created by Nguyễn Minh on 27/06/2021.
//

import Foundation
import Alamofire


// MARK: - VideoData Model
struct VideoData: Codable {
    let nextPageToken: String
    let items: [Video]
}



// MARK: - Video
struct Video: Codable {
    let id: ID?
    let snippet: Snippet
}



// MARK: - Snippet
struct Snippet: Codable {
    let publishedAt: String
    let title: String
    let thumbnails: Thumbnails
    let channelTitle: String
    
    
    enum CodingKeys: String, CodingKey {
        case publishedAt
        case title
        case thumbnails, channelTitle
    }
}

// MARK: - Thumbnails
struct Thumbnails: Codable {
    let thumbnailsDefault, medium, high: Default
    
    enum CodingKeys: String, CodingKey {
        case thumbnailsDefault = "default"
        case medium, high
    }
}

// MARK: - Default
struct Default: Codable {
    let url: String
    let width, height: Int
}
// MARK: - ID
struct ID: Codable {
    let videoID: String
    
    enum CodingKeys: String, CodingKey {
        
        case videoID = "videoId"
    }
}


