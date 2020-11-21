//
//  addDate.swift
//  finalApp_GBP
//
//  Created by Garrett Powell on 11/20/20.
//

import SwiftUI

struct addDate: View {
    @State public var name: String = "Event Name: "
    @State private var start: String = "Start Time: "
    @State private var end: String = "End Time: "
    @State private var descrip: String = "Description: "
    
    var body: some View {
        ZStack{
            Color.black
                .ignoresSafeArea()
            VStack{
                HStack{
                    TextField("Event Title: ", text: $name)
                        .foregroundColor(.white)
                }
                HStack{
                    TextField("Start Time: ", text: $start)
                        .foregroundColor(Color.white)
                    TextField("End Time: ", text: $end)
                        .foregroundColor(Color.white)
                }
                TextField("Event Description: ", text: $descrip)
                    .foregroundColor(Color.white)
                Spacer()    
            }
            .padding()
        }
        
    }
   
}

struct addDate_Previews: PreviewProvider {
    static var previews: some View {
        addDate()
    }
}
