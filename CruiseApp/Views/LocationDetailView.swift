//
//  LocationDetailView.swift
//  CruiseApp
//
//  Created by Tanav Sharma on 2022-04-14.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct LocationDetailView: View {
    
    @State private var eBill: [String: String] = [:]
    @State private var selectedPassangers = "2"
    @State private var date = Date()
    @State private var numPassangers: String = "1"
    @State var totalCost = 0
    @State private var nameOnCard: String = ""
    @State private var cardNumber: String = ""
    @State private var cardExpiry: String = ""
    @State private var cardCVV: String = ""
    
    let db = Firestore.firestore()
    let auth = Auth.auth()
    
    
    
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
                    bookATicket
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
    //Image of Cruise Company
    private var imageSection: some View {
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
    
    //Title of Cruise Company
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 8){
            Text(location.name)
                .font(.largeTitle)
                .fontWeight(.semibold)
            Text(location.cityName)
                .font(.title3)
                .foregroundColor(.gray)
        }
    }
    
    //Description of Cruise Company
    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 8){
            Text(location.description)
                .font(.subheadline)
                .foregroundColor(.gray)
            Spacer()
            Text("Please find pricing and booking information below.")
                .font(.subheadline)
        }
    }
    
    //Booking Information
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
    private var totalCostOfTrip: some View {
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
        .frame(width: UIScreen.main.bounds.width-55, height: 55, alignment: .trailing)
        .padding()
        .background(RoundedRectangle(cornerRadius: 15).fill(.clear))
        .cornerRadius(10)
    }
    
    //Payment Card Screen
    private var bookATicket: some View {
        VStack(alignment: .center, spacing: 18){
            
            Text("Payment Information")
                .font(.title2)
                .fontWeight(.bold)

            Divider()
            
            VStack(alignment: .center){
                TextField("Name On Card", text: $nameOnCard)
            }
            .frame(height: 55)
            .padding(10)
            .background(RoundedRectangle(cornerRadius: 15).fill(.white))
            .cornerRadius(10)
            
            VStack(alignment: .center){
                TextField("Card Number", text: $cardNumber)
            }
            .frame(height: 55)
            .padding(10)
            .background(RoundedRectangle(cornerRadius: 15).fill(.white))
            .cornerRadius(10)
            
            Divider()
            
            HStack(spacing: 18){
                VStack{
                    TextField("Expiry", text:$cardExpiry)
                        .padding()
                }
                
                .padding(10)
                .background(RoundedRectangle(cornerRadius: 15).fill(.white))
                .cornerRadius(10)
                
                VStack{
                    TextField("CVV", text:$cardCVV)
                        .padding()
                }
                
                .padding(10)
                .background(RoundedRectangle(cornerRadius: 15).fill(.white))
                .cornerRadius(10)
                
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 15).fill(.ultraThinMaterial))
        .cornerRadius(10)
    }
    
    //Submit Button
    private var submitButton: some View {
        HStack(spacing: 8){
            Button{
                
                /*Take all values such as
                 *
                 * 1. Total Cost
                 * 2. Name on Card
                 * 3. Card Number
                 * 4. Expiry Date
                 * 5. CVV
                 * * * * * * * * * * * * * * * * * * * * * * * * * *
                 * and store them into a dictionary. * * * * * * * *
                 * then import that dictonary into firebase database
                 */
                
                let user = auth.currentUser!.uid
                
                eBill["totalCost"] = String(totalCost)
                eBill["CardHolderName"] = nameOnCard
                eBill["CardNumber"] = cardNumber
                eBill["ExpiryDate"] = cardExpiry
                eBill["CVV"] = cardCVV
                
                let docRef = db.collection(user).document(UUID().uuidString)
                docRef.setData(eBill){ error in
                    if let error = error {
                        print("error: \(error)")
                    }else{
                        print("no error")
                    }
                }
            
            }label: {
                Text("Book Now")
                    .fontWeight(.bold)
                    .font(.headline)
            }
            
        }
        .frame(width: UIScreen.main.bounds.width-55, height: 55, alignment: .center)
        .padding()
        .background(RoundedRectangle(cornerRadius: 15).fill(.ultraThinMaterial))
        .font(.headline)
    }
}
