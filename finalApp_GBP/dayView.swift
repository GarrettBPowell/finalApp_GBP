//
//  dayView.swift
//  finalApp_GBP
//
//  Created by Garrett Powell on 11/20/20.
//

import SwiftUI

struct dayView: View {
    @State private var showAlert = false
    
    var items: [SpecificContent]
    var model: DateModel
    var theDate: String
    
    var body: some View {
        VStack(alignment: .leading) {
            if(items.count > 0) {
                if(items[0].name != "" && items[0].description != "") {
                    List(0..<items.count) { item in
                        VStack{
                            
                            HStack {
                            Text(items[item].name)
                                    .font(.title2)
                                    
                                Spacer()
                            }
                            HStack{
                                Spacer()
                                HStack (alignment: .top){
                                    Text("\(items[item].startTime) \("-") \(items[item].endTime) ")
                                
                                    Spacer()
                                    
                                    Text(items[item].description ?? "")
                                }
                                Spacer()
                                Button(action: {
                                    self.showAlert = true
                                }, label: { Text("X" )
                                    .foregroundColor(Color.red)
                                    .font(Font.subheadline.weight(.bold))
                                    .foregroundColor(Color.white)
                                    .cornerRadius(12)
                                })
                                    .alert(isPresented: $showAlert) {
                                        Alert(
                                            title: Text("Are you sure?"),
                                            message: Text("Do you want to delete this event?"),
                                            primaryButton: .destructive(Text("No"), action: {
                                                showAlert = false
                                            }),
                                            secondaryButton: .default(Text("Yes"), action: {
                                                delete(filename: "dateData.json", dateDelete: theDate, contentToDelete: model.specificContent[item])
                                            })
                                        )
                                    }
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
    }
}

