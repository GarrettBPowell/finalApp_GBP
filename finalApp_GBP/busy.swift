//

import SwiftUI
func getHour(hour: String) -> Int
{
    if(hour.count <= 0)
    {
        return 0
    }
    var firstHalf = hour.firstIndex(of: ":")!
    firstHalf = hour.index(firstHalf, offsetBy: -1)

    switch(hour[...firstHalf])
    {
    case "01": return 1;
    case "02": return 2;
    case "03": return 3;
    case "04": return 4;
    case "05": return 5;
    case "06": return 6;
    case "07": return 7;
    case "08": return 8;
    case "09": return 9;
    case "10": return 10;
    case "11": return 11;
    case "12":
        if(isAM(ap: hour))
        {
            return 0;
        }
        return 0;
    default: return 0;
    }
}

func getMin(min: String) -> Int
{
    if(min.count <= 0)
    {
        return 0
    }
    
    var secHalf = min.firstIndex(of: ":")!

    let end = min.index(secHalf, offsetBy: 3)
//  busy.swift
//  finalApp_GBP
//
//  Created by Garrett Powell on 11/21/20.
//
    secHalf = min.index(secHalf, offsetBy: 1)
    return (Int(min[secHalf...end]) ?? 0)
}

func isAM(ap: String) -> Bool{
    
    if(ap.count <= 0){
        return true
    }
    return ap.contains("am")
}

func calcTime(array: [SpecificContent]) -> Int{
    var time: Int = 0
    if(array.count > 0) {
        for item in array {
            if((isAM(ap: item.startTime) && isAM(ap: item.endTime)) || (!isAM(ap: item.startTime) && !isAM(ap: item.endTime))){
                time += (getHour(hour: item.endTime) - getHour(hour: item.startTime))
            }
            else if(isAM(ap: item.startTime) && !isAM(ap: item.endTime))
            {
                time += (getHour(hour: item.endTime) + (12 - getHour(hour: item.startTime)))
            }
            else
            {
                time += 0
            }
        }
    }
    return time
}

struct Busy: View {
    var busy: [SpecificContent]

    
    var body: some View {
        Text(" \("Estimated Time Taken Up Today: ") \(calcTime(array: busy)) \(" Hour(s)")")
    }
}
