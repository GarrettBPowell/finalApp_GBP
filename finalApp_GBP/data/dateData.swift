//
//  dateData.swift
//  finalApp_GBP
//
//  Created by Garrett Powell on 11/19/20.
//

import SwiftUI

struct DateModel: Codable{
    var dateContent: [DateContent]
}

struct DateContent: Codable {
    var actualDate: String
    var specificContent: [SpecificContent]
}

struct SpecificContent: Codable {
    var name: String
    var startTime: String
    var endTime: String
    var description: String?
}

