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

        
            List(0..<items.count) { item in
                VStack{
                    Text(items[item].name).font(.title2)
                    Spacer()
                    HStack{
                        Text("\(items[item].startTime) \(" - ") \(items[item].endTime) ")
                    
                   Spacer()
                    Text(items[item].description ?? "")
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

