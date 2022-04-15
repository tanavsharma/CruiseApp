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
    @State private var date = Date()
    @State private var numPassangers: String = "1"
    @State var totalCost = 0
    
    @EnvironmentObject private var vm: LocationsViewModel
    let location: Location
    
    
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
                    numberOfPassangers
                    datePickerTrip
                    totalCostOfTrip
                    submitButton

                }
                
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
        }
        .ignoresSafeArea()
    }
}


struct LocationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LocationDetailView(
            location: LocationsDataService.locations.first!
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
                Text("$199.99")
            }
                
            HStack(spacing: 8){
                Text("Duration of Cruise:")
                    .fontWeight(.semibold)
                    .font(.callout)
                Text("2 nights")
            }
        
            Divider()
                .padding()
        }
    }
    
    //Number of Passangers
    private var numberOfPassangers: some View {
        VStack(alignment: .leading, spacing: 8){
            HStack(spacing: 8){
                VStack(spacing: 8){
                    Text("Number Of Travellers")
                        .fontWeight(.bold)
                        .frame(height: 55)
                }
                
                VStack(spacing: 8){
                    TextField("1", text: $numPassangers, onEditingChanged: {_ in
                        totalCost = Int(numPassangers)! * Int(199.99)
                    })
                        .multilineTextAlignment(.center)
                        .frame(height: 55)
                }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 15).fill(.ultraThinMaterial))
            .cornerRadius(10)
        }
    }
    
    //DatePicker
    private var datePickerTrip: some View {
        
        HStack(spacing: 8){
            VStack(spacing: 16){
                Text("Departure Date")
                    .fontWeight(.bold)
                    .frame(height: 55)
                    .font(.headline)
            }
            
            VStack(spacing: 8){
                DatePicker("", selection: $date, in: Date()..., displayedComponents: .date)
                
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 15).fill(.ultraThinMaterial))
        .cornerRadius(10)
    }
    
    //Total Cost
    private var totalCostOfTrip: some View{
        HStack(spacing: 8){
            VStack(spacing: 8){
                Text("Total Cost")
                    .fontWeight(.bold)
                    .frame(height: 55)
                    .font(.headline)
            }
            
            VStack(spacing: 8){
                Text("$\(totalCost)")
                    .fontWeight(.bold)
                    .frame(height: 55)
                    .font(.headline)
            }
        }
        .frame(width: 370, height: 55, alignment: .center)
        .padding()
        .background(RoundedRectangle(cornerRadius: 15).fill(.clear))
        .cornerRadius(10)
    }
    
    //Submit Button
    private var submitButton: some View {
        HStack(spacing: 8){
            Button{
                //totalCost = Int(numPassangers)! * Int(199.99)
            }label: {
                Text("Book Now")
                    .fontWeight(.bold)
                    .font(.headline)
            }
            .frame(width: 370, height: 55, alignment: .center)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 15).fill(.ultraThinMaterial))
        .font(.headline)
    }

}
