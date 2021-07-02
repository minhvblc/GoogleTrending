//
//  DateExtension.swift
//  GoogleTrending
//
//  Created by Nguyễn Minh on 28/06/2021.
//

import Foundation
extension Date{
    func dateIntoString () -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d MMM yyyy"
        return dateFormatter.string(from: self)
    }
    
    
    
    func calHourBetweenDateAndNowToString() -> String{
        let diffComponents = Calendar.current.dateComponents([.hour], from: self, to: Date())
        let hours = diffComponents.hour
        let result = String(hours!) + " \((hours!<=1) ? "hour" : "hours") ago"
        return result
    }
}
