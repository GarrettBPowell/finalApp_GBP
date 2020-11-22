//
//  busy.swift
//  finalApp_GBP
//
//  Created by Garrett Powell on 11/21/20.
//

import SwiftUI

func calcTime(array: [SpecificContent]) -> Int{
    var time: Int = 0
    if(array.count != 0) {
        for item in array {
            if ((Int(item.endTime) ?? 0) - (Int(item.startTime) ?? 0) <= 0) {
                    time += 12
            }
            else {
                time += (Int(item.endTime) ?? 0) - (Int(item.startTime) ?? 0)
            }   
        }
    }
    
    
    return time
}

struct Busy: View {
    var busy: [SpecificContent]

    
    var body: some View {
        Text(" \("Estimated Time Taken Up Today: ") \(calcTime(array: busy)) \(" Hours")")
    }
}
