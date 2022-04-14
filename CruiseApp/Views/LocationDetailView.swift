//
//  LocationDetailView.swift
//  CruiseApp
//
//  Created by Tanav Sharma on 2022-04-14.
//

import SwiftUI

struct LocationDetailView: View {
    
    let passangers = ["1", "2", "3", "4", "5", "6", "7"]
    @State private var selectedPassangers = "2"
    
    
    let location: Location
    let booking: Bookings
    
    var body: some View {
        ScrollView{
            VStack{
                imageSection
                    .shadow(color: Color.black.opacity(0.5), radius: 20, x: 0, y: 10)
                
                VStack(alignment: .leading, spacing: 16){
                    titleSection
                    Divider()
                    descriptionSection
                    Divider()
                    bookingSection
                }
                
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
        }
        .ignoresSafeArea()
        .overlay(backButton, alignment: .topLeading)
    }
}

struct LocationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LocationDetailView(
            location: LocationsDataService.locations.first!,
            booking: BookingsDataService.bookings.first!
        )
    }
}

extension LocationDetailView {
    private var imageSection: some View{
        TabView{
            Image(location.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width)
                .clipped()
        }
        .frame(height: 500)
        .tabViewStyle(PageTabViewStyle())
    }
    
    private var titleSection: some View{
        VStack(alignment: .leading, spacing: 8){
            Text(location.name)
                .font(.largeTitle)
                .fontWeight(.semibold)
            Text(location.cityName)
                .font(.title3)
                .foregroundColor(.gray)
        }
    }
    
    private var descriptionSection: some View{
        VStack(alignment: .leading, spacing: 8){
            Text(location.description)
                .font(.subheadline)
                .foregroundColor(.gray)
            Spacer()
            Text("Please find pricing and booking information below.")
                .font(.subheadline)
        }
    }
    
    private var bookingSection: some View {
        
        
        VStack(alignment: .leading, spacing: 8){
            
            HStack(spacing: 8){
                Text("Price per person:")
                    .fontWeight(.semibold)
                    .font(.callout)
                Text(booking.price)
            }
                
            HStack(spacing: 8){
                Text("Duration of Cruise:")
                    .fontWeight(.semibold)
                    .font(.callout)
                Text(booking.duration)
            }
        
            Divider()
                .padding()
            
            HStack{
                Text("Number of Passangers:")
                Picker("Please choose a color", selection: $selectedPassangers) {
                                ForEach(passangers, id: \.self) {
                                    Text($0)
                                }
                            }
                }
                
            }
            
        }
    
    private var backButton: some View{
        Button{
            
        }label:{
            Image(systemName: "xmark")
                .font(.headline)
                .padding(16)
                .foregroundColor(.black)
                .background(.thickMaterial)
                .cornerRadius(10)
                .shadow(radius: 4)
                .padding()
        }
    }
}

