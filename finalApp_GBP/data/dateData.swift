//
//  dateData.swift
//  finalApp_GBP
//
//  Created by Garrett Powell on 11/19/20.
//

import SwiftUI

class dateData: Codable {
    var actualDate: String
    var dateContent: [DateContent]
}

class DateContent: Codable {
    let name: String
    let startTime: String
    let endTime: String?
    let description: String?
}

