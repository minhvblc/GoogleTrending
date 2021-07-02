//
//  StringExtension.swift
//  GoogleTrending
//
//  Created by Nguyễn Minh on 27/06/2021.
//

import Foundation


extension String {
    //htmlEncodedString to String
    init?(htmlEncodedString: String) {
        guard let data = htmlEncodedString.data(using: .utf8) else {
            return nil
        }
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return nil
        }
        self.init(attributedString.string)
        
    }
    
    
    func stringIntoDate() -> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d MMM yyyy HH:mm:ss Z"
        return dateFormatter.date(from: self)
        
    }
    
}


