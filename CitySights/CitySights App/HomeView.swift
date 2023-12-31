//
//  ContentView.swift
//  CitySights App
//
//  Created by Molyneux, Piers on 23/12/2023.
//

import SwiftUI

struct HomeView: View {
    
    @Environment(BusinessModel.self) var model
    @State var selectedTab = 0
    
    @State var query: String = ""
    @FocusState var queryBoxFocused: Bool
    
    @State var showOptions = false
    @State var popularOn = false
    @State var dealsOn = false
    @State var categorySelection = "restaurants"
    
    
    var body: some View {
        
        @Bindable var model = model
        
        VStack {
            
            
            HStack {
                TextField("What are you looking for?", text:$query)
                    .textFieldStyle(.roundedBorder)
                    .focused($queryBoxFocused) // Focuse the options depending if user is in text box
                    .onTapGesture {
                        withAnimation {
                            showOptions = true
                        }
                    }
                
                Button {
                    // Perform a search
                    withAnimation {
                        showOptions = false
                        queryBoxFocused = false
                    }
                    model.getBusinesses(query: query,
                                        options: getOptionsString(),
                                        category: categorySelection)
                    
                } label: {
                    Text("Go")
                        .padding(.horizontal)
                        .frame(height: 32)
                    //                        .padding(.vertical, 10)
                        .background(.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
            }
            .padding(.horizontal)
            
            // Query options. Show if textbox is focused
            if showOptions {
                VStack {
                    Toggle("Popular", isOn: $popularOn)
                    Toggle("Deals", isOn: $dealsOn)
                    
                    HStack {
                        Text("Category")
                        Spacer()
                        Picker("Category", selection: $categorySelection) {
                            Text("Restaurants")
                                .tag("restaurants")
                            Text("Arts")
                                .tag("arts")
                        }
                    }
                }
                .padding(.horizontal, 40)
                .transition(.push(from: .top)) // tells type of transition for .withAnimation {}
            }
            
            
            // Show picker
            Picker("", selection: $selectedTab) {
                Text("List")
                    .tag(0)
                Text("Map")
                    .tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            
            // Show map or list - only 2 options so if, if more consider using Switch statement.
            // also if locations auth status is not allowed, then show text asking for permission
            if model.locationAuthStatus == .denied {
                Text("Please allow loaction services for this app to see sights near you.")
                    .padding(.horizontal)
                Button {
                    
                    if let url = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(url)
                    }
                    
                } label: {
                    Text("Open App Privacy Settings")
                }
                .buttonStyle(.bordered)
            }
            else if selectedTab == 1 {
                MapView()
                    .onTapGesture {
                        withAnimation {
                            showOptions = false
                            queryBoxFocused = false
                        }
                    }
            }
            else {
                ListView()
                    .onTapGesture {
                        withAnimation {
                            showOptions = false
                            queryBoxFocused = false
                        }
                    }
            }
        }
        .sheet(item: $model.selectedBusiness) { item in
            BusinessDetailView()
        }
    }
    
    func getOptionsString() -> String {
        var optionsArray = [String]()
        if popularOn {
            optionsArray.append("hot_and_new")
        }
        if dealsOn {
            optionsArray.append("deals")
        }
        return optionsArray.joined(separator: ",")
    }
}

#Preview {
    HomeView()
        .environment(BusinessModel())
}
