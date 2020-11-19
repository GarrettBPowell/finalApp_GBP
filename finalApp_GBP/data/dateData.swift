//
//  dateData.swift
//  finalApp_GBP
//
//  Created by Garrett Powell on 11/19/20.
//

import SwiftUI

struct DateModel: Codable {
    let dateContent: [DateContent]
}

struct DateContent: Codable {
    let actualDate: String
    let name: String
    let startTime: String
    let endTime: String?
    let description: String?
}

