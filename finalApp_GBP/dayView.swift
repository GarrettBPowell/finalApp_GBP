//
//  dayView.swift
//  finalApp_GBP
//
//  Created by Garrett Powell on 11/20/20.
//

import SwiftUI

struct dayView: View {

    var items: [SpecificContent]
    
    
    var body: some View {
        VStack(alignment: .leading) {

            ScrollView(.horizontal, showsIndicators: false) {
                VStack{
                    Text("\(items[0].startTime) \(" - ") \(items[0].endTime) ")
                    Text(items[0].description ?? "")
                }
            }
            .frame(height: 185)
        }
    }
}

