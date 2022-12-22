//
//  ContentView.swift
//  AncestralWatch
//
//  Created by Jakob Hartman on 12/20/22.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var selection: String? = nil
    @State private var showLogin: Bool = false
    
    
    var body: some View {
        NavigationView {
            VStack {
                if (showLogin){
                    Text("Ancestral Watch")
                        .fontWeight(.bold)
                        .padding(.bottom, 20.0)
                    Text("“… And the hearts of the children shall turn to their fathers.” - Joseph Smith—History 1:38, 39").padding(.bottom, 30.0)
                    Text("Sign into Family Search with")
                    HStack {
                        NavigationLink(destination: LDSLoginView(selection: $selection), tag: "A", selection: $selection){
                            EmptyView()
                        }
                        Button(action: {
                            selection = "A"
                        }) {
                            Image("LDSIcon")
                        }
                        NavigationLink(destination: FacebookLoginView(selection: $selection), tag: "B", selection: $selection){
                            EmptyView()
                        }
                        Button(action: {
                            selection = "B"
                        }) {
                            Image("FacebookIcon")
                        }
                        NavigationLink(destination: WWWLoginView(selection: $selection), tag: "C", selection: $selection){
                            EmptyView()
                        }
                        Button(action:{
                            selection = "C"
                        }){
                            Image("WWWIcon").resizable().frame(width: 100.0, height: 100.0)
                        }
                    }
                }else {
                    Text("You are logged in...")
                    Button("Log out", action: {
                        let prefs = UserDefaults.standard
                        prefs.removeObject(forKey: "AccessToken")
                        prefs.removeObject(forKey: "Expiration")
                        showLogin = true
                    }).border(.primary)
                }
            }.padding()
                .onAppear{
                    DispatchQueue.main.async {
                        let prefs = UserDefaults.standard
                        let now = Date().timeIntervalSince1970
                        var ts = Double.greatestFiniteMagnitude
                        if(prefs.object(forKey: "Expiration") != nil){
                            ts = prefs.double(forKey: "Expiration")
                        }
                        
                        showLogin = prefs.object(forKey: "AccessToken") == nil || now > ts
                        print("Show Login - \(String(describing: showLogin))")
                    }
                }
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
