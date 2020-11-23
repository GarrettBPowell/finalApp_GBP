//
//  busy.swift
//  finalApp_GBP
//
//  Created by Garrett Powell on 11/21/20.
//

import SwiftUI
func getHour(hour: String) -> Int
{
    let firstHalf = hour.firstIndex(of: ":")!
    return (Int(hour[...firstHalf]) ?? 0)
}

func getMin(min: String) -> Int
{
    var secHalf = min.firstIndex(of: ":")!
    let end = min.index(secHalf, offsetBy: 3)
    secHalf = min.index(secHalf, offsetBy: 1)
    return (Int(min[secHalf...end]) ?? 0)
}

func isAM(ap: String) -> Bool{
    let time = ap.firstIndex(of: "a")!
    if(ap[time...] == "am") {
        return true
    }
    return false
}

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
