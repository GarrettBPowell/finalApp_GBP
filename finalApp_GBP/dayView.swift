//
//  dayView.swift
//  finalApp_GBP
//
//  Created by Garrett Powell on 11/20/20.
//

import SwiftUI

struct dayView: View {

    var items: [DateModel]
    
    
    var body: some View {
        VStack(alignment: .leading) {

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {
                    Text(" ")
                }
            }
            .frame(height: 185)
        }
    }
}

struct eventView: View {
    var dateContent: SpecificContent
    var body: some View {
        VStack(alignment: .leading) {
            Text(dateContent.name)
                .foregroundColor(.primary)
                .font(.caption)
        }
        .padding(.leading, 15)
    }
}
