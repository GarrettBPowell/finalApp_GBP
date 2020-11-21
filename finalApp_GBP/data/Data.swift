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


func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

//should append new data to local json file
func append (filename: String, dateAdd: String, contentToAdd: DateModel) {
    var dateData: [DateModel] = load("dateData.json")
    print("got here")
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
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
            else {
                fatalError("Couldn't find \(filename) in main bundle.")
        }
        print("inside do, above encoder")
    try JSONEncoder().encode(dateData).write(to: file)
        print(dateData)

    }catch {
        print(error)}
}
