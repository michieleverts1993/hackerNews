//
//  TimeIntervalExtension.swift
//  
//
//  Created by Michiel Everts on 30-10-17.
//

import Foundation

extension TimeInterval {
    func timepassed() -> String{
        let currentTime = NSDate().timeIntervalSince1970
        let timeDifference = (currentTime - self)/1000
        let minutes = timeDifference / 60
        var time = ""
        
        if minutes <= 60 {
            time = ("\(minutes.rounded())M")
        } else if minutes >= 60  {
            let hours = Int(minutes) % 60
            time = ("\(hours)H"+"\(minutes.rounded())M")
        }
        return time
    }
}
