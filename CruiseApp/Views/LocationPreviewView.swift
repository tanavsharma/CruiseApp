//
//  LocationPreviewView.swift
//  CruiseApp
//
//  Created by Tanav Sharma on 2022-03-18.
//

import SwiftUI
import UserNotifications

class NotificationManager{
    static let instance = NotificationManager()
    
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        
        UNUserNotificationCenter.current().requestAuthorization(
            options: options) { success, error in
                if let error = error{
                    print("Error:\(error)")
                }else{
                    print("Yay")
                }
            }
    }
    
    func sendNotification(){
        let content = UNMutableNotificationContent()
        content.title = "Favourite"
        content.subtitle = "We will save your selection!"
        content.sound = .default
        content.badge = 1
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 15, repeats: true)
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
}

struct LocationPreviewView: View {
    
    let location: Location
    @EnvironmentObject private var vm: LocationsViewModel
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 0){
            VStack(alignment: .leading , spacing: 16){
                imageSection
                titleSection
            }
            
            VStack(spacing: 8){
                detailsButton
                favButton
                nextButton
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.ultraThinMaterial)
                .offset(y: 65)
        )
        .cornerRadius(10)
    }
}

struct LocationPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color.white.ignoresSafeArea()
            LocationPreviewView(location: LocationsDataService.locations.first!)
                .padding()
        }
        .environmentObject(LocationsViewModel())
    }
}

extension LocationPreviewView{
    private var imageSection: some View{
        ZStack{
            if let imageName = location.imageName {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
            }
        }
        .padding(6)
        .background(Color.white)
        .cornerRadius(10)
    }
    
    private var titleSection: some View{
        VStack(alignment: .leading, spacing: 4){
            Text(location.name)
                .font(.title2)
                .fontWeight(.bold)
        
            Text(location.cityName)
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        
    }
    
    private var detailsButton: some View{
        Button{
            //
        } label: {
            Text("Details")
                .font(.headline)
                .frame(width: 125, height: 35)
        }
        .buttonStyle(.borderedProminent)
    }
    
    private var favButton: some View{
        Button{
            NotificationManager.instance.requestAuthorization()
            NotificationManager.instance.sendNotification()
        } label: {
            Text("Favourite")
                .font(.headline)
                .frame(width: 125, height: 35)
        }
        .buttonStyle(.borderedProminent)
    }
    
    private var nextButton: some View{
        Button{
            vm.nextButtonPressed()
        } label: {
            Text("Next")
                .font(.headline)
                .frame(width: 125, height: 35)
        }
        .buttonStyle(.bordered)
    }
}
