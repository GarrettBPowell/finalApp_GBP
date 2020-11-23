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
    @State private var descrip: String = ""
    @State private var addedDate: Bool = false;
    @State private var startHours = 0
    @State private var startMin = 0
    @State private var startAP = 0
    @State private var endHours = 0
    @State private var endMin = 0
    @State private var endAP = 0
    @State private var hours = ["12", "01", "02", "03", "04", "05", "06", "07", "08" ,"09", "10", "11"]
    @State private var min = ["00", "01", "02", "03", "04", "05", "06", "07", "08" ,"09", "10", "11", "12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59"]
    @State private var times = ["am", "pm"]
    let dateClicked: String
    
    var body: some View {
        ScrollView{
            VStack{
                TextField("Event Name: ", text: $name)
                    .border(Color.gray)
                    .padding()
                    .frame(height:50)
                
                
                //start time stuff
                HStack{
                    //start hours
                    VStack{
                        Picker(selection: $startHours, label: Text("Start Time: ")) {
                            ForEach(0..<hours.count, id: \.self){
                                Text(String(self.hours[$0])).tag($0)
                            }
                        }.frame(width:50, height: 75)
                        .clipped()
                    }
                    
                    //start minutes
                    VStack{
                        Picker(selection: $startMin, label: Text("Start Time: ")) {
                            ForEach(0..<min.count, id: \.self){
                                Text(String(self.min[$0])).tag($0)
                            }
                        }.frame(width:50, height: 75)
                        .clipped()
                    }
                    
                    //start am pm
                    VStack{
                        Picker(selection: $startAP, label: Text("AmPm")) {
                            Text("am").tag(0)
                            Text("pm").tag(1)
                        }.frame(width:50)
                        .clipped()
                    }
                }.padding()
                .frame(height:100)
  
                
                //end time stuff
                HStack{
                    //end hours
                    VStack{
                        Picker(selection: $endHours, label: Text("End Time: ")) {
                            ForEach(0..<hours.count, id: \.self){
                                Text(String(self.hours[$0])).tag($0)
                            }
                        }.frame(width:50, height: 75)
                        .clipped()
                    }
                    
                    //end minutes
                    VStack{
                        Picker(selection: $endMin, label: Text("End Time: ")) {
                            ForEach(0..<min.count, id: \.self){
                                Text(String(self.min[$0])).tag($0)
                            }
                        }.frame(width:50, height: 75)
                        .clipped()
                    }
                    
                    //end am pm
                    VStack{
                        Picker(selection: $endAP, label: Text("AmPm")) {
                            Text("am").tag(0)
                            Text("pm").tag(1)
                        }.frame(width:50)
                        .clipped()
                    }
                }.padding()
                .frame(height:100)


                TextField("Event Description: ", text: $descrip)
                    .border(Color.gray)
                    .padding()
                    .frame(height:50)

                Button(action: {
                    if(name != "" && descrip != ""){
                        addDateToJson(currentDate: dateClicked, eventName: name, startTime: String(" \(hours[startHours]) \(":") \(min[startMin]) \(" ") \(times[startAP])"), endTime: String(" \(hours[endHours]) \(":") \(min[endMin]) \(" ") \(times[endAP])"), description: descrip)
                        addedDate = true
                    }
                    
                }) {
                    switch(!addedDate){
                        case true: Text("Add Event")
                        case false: Text("Event Added")
                    }
                }.disabled(addedDate)
            }

        }
    }
}

struct addDate_Previews: PreviewProvider {
    static var previews: some View {
        addDate(dateClicked: "1/1/20")
    }
}
