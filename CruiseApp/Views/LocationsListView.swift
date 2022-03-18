//
//  LocationsListView.swift
//  CruiseApp
//
//  Created by Tanav Sharma on 2022-03-17.
//

import SwiftUI

struct LocationsListView: View {
    @EnvironmentObject private var vm: LocationsViewModel
    var body: some View {
        List{
            ForEach(vm.locations){ location in
                HStack{
                    if let imageName = location.imageName{
                        Image(imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 45, height: 45)
                            .cornerRadius(10)
                    }
                    VStack(alignment: .leading){
                        Text(location.name)
                            .font(.headline)
                        Text(location.cityName)
                            .font(.subheadline)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 4)
                    .listRowBackground(Color.clear)
                }
            }
        }
        .listStyle(PlainListStyle())
    }
}

struct LocationsListView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsListView()
            .environmentObject(LocationsViewModel())
    }
}
