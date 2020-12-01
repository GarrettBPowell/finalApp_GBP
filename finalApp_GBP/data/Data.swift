//
//  Data.swift
//  finalApp_GBP
//
//  Created by Garrett Powell on 11/19/20.
//

//
//JSON READING STUFF
import SwiftUI
import UIKit
import CoreLocation

func baseThing() {
    let url = getDocumentsDirectory().appendingPathComponent("message.txt")
    let str = "[{\"actualDate\": \"*/*/**\",\"specificContent\": [{\"name\": \"\",\"startTime\": \"\",\"endTime\":\"\",\"description\": \"\"}]}]"


            do {
                try str.write(to: url, atomically: true, encoding: .utf8)
                let input = try String(contentsOf: url)
                print(input)
            } catch {
                print(error.localizedDescription)
            }
}

func getDocumentsDirectory() -> URL {
    // find all possible documents directories for this user
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

    // just send back the first one, which ought to be the only one
    return paths[0]
}


func delete (filename: String, dateDelete: String, contentToDelete: SpecificContent) {
    var dateData: [DateModel] = load()
    //checking to see if date exits already
    let indexOfThing: Int = dateData.firstIndex(where: {$0.actualDate == dateDelete}) ?? 0
    var countThing: Int = 0
    for item in dateData[indexOfThing].specificContent {
        
        if(item.name == contentToDelete.name && item.description == contentToDelete.description
            && item.startTime == contentToDelete.startTime && item.endTime == contentToDelete.endTime) {
            
            dateData[indexOfThing].specificContent.remove(at: countThing)
        }
            countThing += 1
    }
    
        do {
            let url = getDocumentsDirectory().appendingPathComponent("message.txt")

            try JSONEncoder().encode(dateData).write(to: url)
            let input = try String(contentsOf: url)
            print(input)
        } catch {
            print(error.localizedDescription)
        }
        updateDateData()
}

var didOnce = true
func load<T: Decodable>() -> T {
    let data: Data
    
    let file = getDocumentsDirectory().appendingPathComponent("message.txt")
    if(didOnce) {
        didOnce = false
        baseThing()
    }
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load from main bundle:\n\(error)")
    }
    print("Done")
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse as \(T.self):\n\(error)")
    }
    
}



//should append new data to local json file
func append (filename: String, dateAdd: String, contentToAdd: DateModel) {
    var dateData: [DateModel] = load()
    //checking to see if date exits already
    let indexOfThing: Int = dateData.firstIndex(where: {$0.actualDate == dateAdd}) ?? 0
    if indexOfThing == 0 {
        dateData.append(contentToAdd)
    }
    else {
        dateData[indexOfThing].specificContent.append(contentsOf: contentToAdd.specificContent)
    }
    //at this point array should be updated and the file just needs to be written to

//trying to add to file
    do{
        let url = getDocumentsDirectory().appendingPathComponent("message.txt")

        do {
            try JSONEncoder().encode(dateData).write(to: url)
            let input = try String(contentsOf: url)
            print(input)
        } catch {
            print(error.localizedDescription)
        }
        updateDateData()
        

    }
}
