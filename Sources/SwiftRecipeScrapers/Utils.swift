//
//  File.swift
//  
//
//  Created by Laksh Chakraborty on 11/28/21.
//

import Foundation

class Utils {
    @available(OSX 10.13, *)
    @available(iOS 13, *)
    static func getMinutes(_ element: String?) -> Int? {
        let pattern = #"(\D*(?<hours>\d+)\s*(hours|hrs|hr|h|Hours|H|óra))?(\D*(?<minutes>\d+)\s*(minutes|mins|min|m|Minutes|M|perc))?"#
        
        if element == nil {
            return nil
        }
        var timeString = element
        
        if timeString!.starts(with: "P") && timeString!.contains("T") {
            timeString = String(timeString!.split(separator: "T", maxSplits: 1)[1])
        }
        
        if timeString!.contains("-") {
            timeString = String(timeString!.split(separator: "-")[1])
        }
        
        if timeString!.contains("h") {
            timeString = timeString!.replacingOccurrences(of: "h", with: "hours") + "minutes"
        }
        
        var minutes: Int = 0
        
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: [])

            let nsrange = NSRange(timeString!.startIndex ..< timeString!.endIndex, in: timeString!)
            
            if let match = regex.firstMatch(in: timeString!, options: [], range: nsrange) {
                for component in ["minutes", "hours"] {
                    let nsrange = match.range(withName: component)
                    if nsrange.location != NSNotFound, let range = Range(nsrange, in: timeString!) {
                        //                        print("\(component): \(timeString[range])")
                        if component == "minutes" {
                            minutes = Int(timeString![range]) ?? 0
                        } else if component == "hours" {
                            minutes += 60 * (Int(timeString![range]) ?? 0)
                        }
                    }
                }
            }
            
        } catch {
            print(error)
        }
        
        return minutes
    }
}
