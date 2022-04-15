//
//  NumberOfPassangers.swift
//  CruiseApp
//
//  Created by Tanav Sharma on 2022-04-14.
//

import SwiftUI

struct DatePickerView: View {
    
    @State private var numPax: String = ""
    @State private var date = Date()
    
    var body: some View {
        HStack(alignment: .center, spacing: 0){
            VStack(spacing: 16){
                Text("Departure Date")
                    .fontWeight(.bold)
                    .frame(width: 190, height: 55, alignment: .leading)
                    .font(.headline)
            }
            
            VStack(spacing: 16){
                DatePicker("", selection: $date, in: Date()..., displayedComponents: .date)
                
            }
        }
        .padding(10)
        .background(RoundedRectangle(cornerRadius: 15).fill(.ultraThinMaterial))
        .cornerRadius(10)
        
        
    }
}

struct DatePickerView_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerView()
    }
}




