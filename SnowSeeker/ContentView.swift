//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Esben Viskum on 02/06/2021.
//

import SwiftUI
import FileManagerExtension

struct UserView: View {
    var body: some View {
        Group {
            Text("Name: Esben")
            Text("Country: Denmark")
            Text("City: Jelling")
        }
    }
}

struct WelcomeView: View {
    var body: some View {
        VStack {
            Text("Welcome to SnowSeeker!")
                .font(.largeTitle)
            
            Text("Please select a resort from the left-hand menu; swipe from the left edge to show it.")
                .foregroundColor(.secondary)
        }
    }
}

extension View {
    func phoneOnlyStackNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return AnyView(self.navigationViewStyle(StackNavigationViewStyle()))
        } else {
            return AnyView(self)
        }
    }
}

struct ContentView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    @ObservedObject var favorites = Favorites()
    @State private var layoutVertically = false
    var resorts: [Resort] = Bundle.main.readJSONsimple("resorts.json")
    
/*    init() {
        Bundle.main.readJSON([Resort].self, docName: "resorts.json") {  (result) in
            switch result {
            case .success(let data):
                print("loadFromDisk: Data loaded successfully")
                resorts = data
            case .failure(let error):
                print("loadFromDisk: Unable to load data")
                print(error.localizedDescription)
            }
        }
    } */
    
    var body: some View {
        NavigationView {
            List(resorts) { resort in
                NavigationLink(destination: ResortView(resort: resort)) {
                    Image(resort.country)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 25)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.black, lineWidth: 1))
                
                    VStack(alignment: .leading) {
                        Text(resort.name)
                            .font(.headline)
                        Text("\(resort.runs) runs")
                            .foregroundColor(.secondary)
                    }
                    .layoutPriority(1)
                    
                    if self.favorites.contains(resort) {
                        Spacer()
                        Image(systemName: "heart.fill")
                            .accessibility(label: Text("This is a favorite resort"))
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationBarTitle("Resorts")
            
            WelcomeView()
        }
        .phoneOnlyStackNavigationView()
        .environmentObject(favorites)
        
/*        Group {
            if sizeClass == .compact {
                VStack(content: UserView.init)
            } else {
                HStack(content: UserView.init)
            }
        } */
        
/*        Group {
            if layoutVertically {
                VStack {
                    UserView()
                }
            } else {
                HStack {
                    UserView()
                }
            }
        }
        .onTapGesture {
            self.layoutVertically.toggle()
        } */
        
/*        NavigationView {
            NavigationLink(
                destination: Text("Destination"),
                label: {
                    Text("Hello World")
                })
                .navigationBarTitle("Primary")
            
            Text("Secondary")
        } */
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
