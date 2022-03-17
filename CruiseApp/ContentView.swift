//
//  ContentView.swift
//  CruiseApp
//
//  Created by Tanav Sharma on 2022-03-15.
//

import SwiftUI
import FirebaseAuth
import FirebaseDatabase

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home: View{
    
    @State var show = false
    @State var sucessLogin = false
    @State var successSignup = false
    
    var body: some View{
        VStack{
            NavigationView{
                ZStack{
                    NavigationLink(destination: Register(show: self.$show, successSignup: self.$successSignup), isActive: self.$show){
                        
                    }
                    .hidden()
                    
                    NavigationLink(destination: UserScreen(sucessLogin: self.$sucessLogin), isActive: self.$sucessLogin){
                        
                    }
                    .hidden()
                    
                    NavigationLink(destination: MoreInformation(successSignup: self.$successSignup, sucessLogin: self.$sucessLogin), isActive: self.$successSignup){
                        
                    }
                    .hidden()
                    
                    Login(show: self.$show, sucessLogin: self.$sucessLogin)
                }
                .navigationTitle("")
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
            }
        }
    }
}

// MARK: Login View
struct Login: View {
    
    @State var color = Color.black.opacity(0.7)
    @State var email = ""
    @State var pass = ""
    @State var visible = false
    @Binding var show : Bool
    @Binding var sucessLogin: Bool
    let auth = Auth.auth()
    
    var body: some View{
        ZStack(alignment: .topTrailing){
            GeometryReader{_ in
                VStack{
                    // MARK: Logo
                    Image("logo")
                        .resizable()
                        .frame(width: 120, height: 120)
                    
                    // MARK: App Name Text
                    Text("Cruise App")
                        .font(.title)
                    
                    // MARK: Information Text
                    Text("Login to your account")
                        .font(.body)
                        .fontWeight(.bold)
                        .foregroundColor(self.color)
                        .padding(.top, 25)
                    
                    // MARK: Email Text Field
                    TextField("Email", text: self.$email)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.email != "" ? Color("Theme"): self.color,lineWidth: 2))
                    
                    // MARK: Passord Handler
                    HStack{
                        VStack{
                            if self.visible{
                                TextField("Password", text: self.$pass)
                            }else{
                                SecureField("Password", text: self.$pass)
                            }
                        }
                        
                        Button(action: {
                            self.visible.toggle()
                        }){
                            Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(self.color)
                        }
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 4).stroke(self.pass != "" ? Color("Theme"): self.color,lineWidth: 2))
                    .padding(.top, 15)
                    
                    // MARK: Forgot Password Field
                    HStack{
                        Spacer()
                        Button(action: {
                            
                        }){
                            Text("Forgot Password")
                                .fontWeight(.bold)
                                .foregroundColor(Color("Theme"))
                        }
                    }
                    .padding(.top, 20)
                    
                    
                    // MARK: Login Button
                    Button(action: {
                        auth.signIn(withEmail: email, password: pass){ result, error in
                            guard result != nil,  error == nil else{
                                
                                self.sucessLogin.toggle()
                                return
                                
                            }
                            
                            // Success
                            
                            
                        }
                    }){
                        Text("Log In")
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 50)
                    }
                    .background(Color("Theme"))
                    .cornerRadius(10)
                    .padding(.top, 15)
                    
                }
                .padding(.horizontal, 25)
            }
            
            Button(action: {
                self.show.toggle()
            }){
                Text("Register\nHere")
                    .fontWeight(.bold)
                    .foregroundColor(Color("Theme"))
            }
            .padding()
        }
    }
}

// MARK: Register View
struct Register: View {
    
    @State var color = Color.black.opacity(0.7)
    @State var email = ""
    @State var pass = ""
    @State var repass = ""
    @State var visible = false
    @State var revisible = false
    @Binding var show : Bool
    @Binding var successSignup: Bool
    let auth = Auth.auth()
    
    var body: some View{
        ZStack(alignment: .topLeading){
            GeometryReader{_ in
                VStack{
                    // MARK: Logo
                    Image("logo")
                        .resizable()
                        .frame(width: 120, height: 120)
                    
                    // MARK: App Name Text
                    Text("Cruise App")
                        .font(.title)
                    
                    // MARK: Information Text
                    Text("Register for your account")
                        .font(.body)
                        .fontWeight(.bold)
                        .foregroundColor(self.color)
                        .padding(.top, 25)
                                
                    // MARK: Email Text Field
                    TextField("Email", text: self.$email)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.email != "" ? Color("Theme"): self.color,lineWidth: 2))
                    
                    // MARK: Passord Handler
                    HStack{
                        VStack{
                            if self.visible{
                                TextField("Password", text: self.$pass)
                            }else{
                                SecureField("Password", text: self.$pass)
                            }
                        }
                        
                        Button(action: {
                            self.visible.toggle()
                        }){
                            Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(self.color)
                        }
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 4).stroke(self.pass != "" ? Color("Theme"): self.color,lineWidth: 2))
                    .padding(.top, 15)
                    
                    // MARK: Passord Handler Again
                    HStack{
                        VStack{
                            if self.revisible{
                                TextField("Confirm Password", text: self.$repass)
                            }else{
                                SecureField("Confirm Password", text: self.$repass)
                            }
                        }
                        
                        Button(action: {
                            self.revisible.toggle()
                        }){
                            Image(systemName: self.revisible ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(self.color)
                        }
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 4).stroke(self.pass != "" ? Color("Theme"): self.color,lineWidth: 2))
                    .padding(.top, 15)
                    
                    
                    
                    // MARK: Login Button
                    Button(action: {
                        auth.createUser(withEmail: email, password: pass){ result, error in
                            guard result != nil, error == nil else{
                                
                                return
                            }
                            self.successSignup.toggle()
                            
                            
                            
                        }
                    }){
                        Text("Sign Up")
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 50)
                    }
                    .background(Color("Theme"))
                    .cornerRadius(10)
                    .padding(.top, 15)
                
                }
                .padding(.horizontal, 25)
            }
            
            Button(action: {
                self.show.toggle()
            }){
                Text("Login\nHere")
                    .fontWeight(.bold)
                    .foregroundColor(Color("Theme"))
            }
            .padding()
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

// MARK: User Profile or Main Screen
struct UserScreen: View {
    @Binding var sucessLogin : Bool
    let auth = Auth.auth()
    private let database = Database.database().reference()
    var refHandle: DatabaseHandle?

    
    var body: some View{
        ZStack(alignment: .topLeading){
            GeometryReader{_ in
                VStack{
                    
                }
                .padding(.horizontal, 25)
            }
        }
    }
}

// MARK: More Information From User
struct MoreInformation: View {
    
    @State var color = Color.black.opacity(0.7)
    @State var first_name = ""
    @State var last_name = ""
    @State var address = ""
    @State var city = ""
    @State var country = ""
    @State var postalcode = ""
    @Binding var successSignup : Bool
    @Binding var sucessLogin : Bool
    let auth = Auth.auth()
    private let database = Database.database().reference()
    
    var body: some View{
        ZStack(alignment: .bottomLeading){
            GeometryReader{_ in
                VStack{
                    // MARK: Logo
                    Text("We need more information,\nplease fill all fields below.")
                        .font(.title3)
                        .padding(.top, 15)
                                
                    // MARK: First Name Text Field
                    TextField("First Name", text: self.$first_name)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.first_name != "" ? Color("Theme"): self.color,lineWidth: 2))
                    
                    // MARK: Last Name Text Field
                    TextField("Last Name", text: self.$last_name)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.last_name != "" ? Color("Theme"): self.color,lineWidth: 2))
                    
                    // MARK: Address Text Field
                    TextField("Address", text: self.$address)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.address != "" ? Color("Theme"): self.color,lineWidth: 2))
                    
                    // MARK: Country Text Field
                    TextField("Country", text: self.$country)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.country != "" ? Color("Theme"): self.color,lineWidth: 2))
                    
                    // MARK: City Text Field
                    TextField("City", text: self.$city)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.city != "" ? Color("Theme"): self.color,lineWidth: 2))
                    
                    // MARK: Postal Code Text Field
                    TextField("Postal Code or Zip Code", text: self.$postalcode)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.postalcode != "" ? Color("Theme"): self.color,lineWidth: 2))
 
                    
                    // MARK: Login Button
                    Button(action: {
                        var user: [String:String] = [:]
                        user["First Name"] = first_name
                        user["Last Name"] = last_name
                        user["Address"] = address
                        user["Country"] = country
                        user["City"] = city
                        user["Postal Code"] = postalcode
                        
                        self.sucessLogin.toggle()
                        database.child(auth.currentUser!.uid).setValue(user)
                    }){
                        Text("Next")
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 50)
                    }
                    .background(Color("Theme"))
                    .cornerRadius(10)
                    .padding(.top, 15)
                
                }
                .padding(.horizontal, 25)
            }
            
            Button(action: {
                
            }){
                Text("Cancle")
                    .fontWeight(.bold)
                    .foregroundColor(Color("Theme"))
            }
            .padding()
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}


