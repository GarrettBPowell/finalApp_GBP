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

            List(0..<5) { item in
                VStack{
                    Text(items[0].name).font(.title2)
                    Spacer()
                    HStack{
                        Text("\(items[0].startTime) \(" - ") \(items[0].endTime) ")
                    
                   Spacer()
                    Text(items[0].description ?? "")
                    }
                }
            }
            .frame(height: 300)
            Spacer()
            Spacer()
            Spacer()
            Text("Hopefully have time density graph here or a button to get to it")
        }
    }
}

