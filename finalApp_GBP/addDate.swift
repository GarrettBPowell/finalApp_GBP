//
//  addDate.swift
//  finalApp_GBP
//
//  Created by Garrett Powell on 11/20/20.
//

import SwiftUI

//this should go and append or update current date in the json file
func addDateToJson(currentDate: String, eventName: String, startTime: String, endTime: String, description: String?){
    let sc = [SpecificContent(name: eventName, startTime: startTime, endTime: endTime, description: description)]
    let dateContent = DateModel(actualDate: currentDate, specificContent: sc)
    
    print("in add date")

    append(filename: "dateData.json", dateAdd: currentDate, contentToAdd: dateContent)
}

//view for adding new events
struct addDate: View {
    @State public var name: String = "Event Name: "
    @State private var start: String = "Start Time: "
    @State private var end: String = "End Time: "
    @State private var descrip: String = "Description: "
    let dateClicked: String
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
                Button(action: {
                    addDateToJson(currentDate: dateClicked, eventName: name, startTime: start, endTime: end, description: descrip)
                    
                }) {
                    Text("Add Event")
                }
            }
            .padding()
        }
    }
    
}

struct addDate_Previews: PreviewProvider {
    static var previews: some View {
        addDate(dateClicked: "1/1/20")
    }
}
