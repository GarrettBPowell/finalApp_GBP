//
//  dayView.swift
//  finalApp_GBP
//
//  Created by Garrett Powell on 11/20/20.
//

import SwiftUI

struct dayView: View {

    var items: [SpecificContent]
    var theDate: String
    
    var body: some View {
        VStack(alignment: .leading) {

        
            List(0..<items.count) { item in
                VStack{
                    HStack {
                        Text(items[item].name)
                            .font(.title2)
                            
                        Spacer()
                    }
                    Spacer()
                    HStack (alignment: .top){
                        Text("\(items[item].startTime) \("-") \(items[item].endTime) ")
                    
                        Spacer()
                        
                        Text(items[item].description ?? "")
                    }
                }
            }
            .frame(height: 300)
            Spacer()
            Spacer()
            Spacer()
           
            Busy(busy: items).padding()
        }
    }
}

