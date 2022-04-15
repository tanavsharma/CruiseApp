//
//  NumberOfPassangers.swift
//  CruiseApp
//
//  Created by Tanav Sharma on 2022-04-14.
//

import SwiftUI

struct NumberOfPassangers: View {
    
    @State private var numPax: String = ""
    
    var body: some View {
        HStack(alignment: .center, spacing: 0){
            VStack(spacing: 16){
                Text("Number Of Passangers")
                    .fontWeight(.bold)
                    .frame(width: 190, height: 55, alignment: .leading)
                    .font(.headline)
            }
            
            VStack(spacing: 16){
                TextField("3", text: $numPax)
                    .frame(width: 190, height: 55, alignment: .center)
                    .multilineTextAlignment(.center)
            }
        }
        .padding(10)
        .background(RoundedRectangle(cornerRadius: 15).fill(.ultraThinMaterial))
        .cornerRadius(10)
        
        
    }
}

struct NumberOfPassangers_Previews: PreviewProvider {
    static var previews: some View {
        NumberOfPassangers()
    }
}
