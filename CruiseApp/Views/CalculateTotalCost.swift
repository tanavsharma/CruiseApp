//
//  CalculateTotalCost.swift
//  CruiseApp
//
//  Created by Tanav Sharma on 2022-04-15.
//

import SwiftUI

struct CalculateTotalCost: View {
    
    var totalCost = "$0.00"
    
    var body: some View {
        HStack(alignment: .center, spacing: 0){
            VStack(spacing: 16){
                Text("Total Cost")
                    .fontWeight(.bold)
                    .frame(width: 190, height: 55, alignment: .leading)
                    .font(.headline)
            }
            
            VStack(spacing: 16){
                Text("\(totalCost)")
                    .fontWeight(.bold)
                    .frame(width: 190, height: 55, alignment: .trailing)
                    .font(.headline)
            }
        }
        .padding(10)
        .background(RoundedRectangle(cornerRadius: 15).fill(.clear))
        .cornerRadius(10)
    }
}

struct CalculateTotalCost_Previews: PreviewProvider {
    static var previews: some View {
        CalculateTotalCost()
    }
}
