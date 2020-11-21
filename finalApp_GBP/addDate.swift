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
    @State public var name: String = ""
    @State private var start: String = ""
    @State private var end: String = ""
    @State private var descrip: String = ""
    @State private var addedDate: Bool = false;
    let dateClicked: String
    var body: some View {
        ZStack{
            Color.black
                .ignoresSafeArea()
            VStack{
                HStack{
                    Text("Event Name: ")
                        .foregroundColor(.white)
                    TextField("Event Name: ", text: $name)
                        .foregroundColor(.white)
                }
                HStack{
                    Text("Start Time: ")
                        .foregroundColor(.white)
                    TextField("Start Time: ", text: $start)
                        .foregroundColor(Color.white)
                    Spacer()
                    Text("End Time: ")
                        .foregroundColor(.white)
                    TextField("End Time: ", text: $end)
                        .foregroundColor(Color.white)
                }
                HStack{
                    Text("Event Description: ")
                        .foregroundColor(.white)
                    TextField("Event Description: ", text: $descrip)
                        .foregroundColor(Color.white)
                }
                Spacer()
                
                Button(action: {
                    if(name != "" && start != "" && end != "" && descrip != ""){
                        addDateToJson(currentDate: dateClicked, eventName: name, startTime: start, endTime: end, description: descrip)
                        addedDate = true
                    }
                }) {
                    switch(!addedDate){
                        case true: Text("Add Event")
                        case false: Text("Event Added")
                    }
                }.disabled(addedDate)
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
