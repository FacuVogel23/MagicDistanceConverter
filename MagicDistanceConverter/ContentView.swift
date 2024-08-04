//
//  ContentView.swift
//  MagicDistanceConverter
//
//  Created by kqDevs on 16/07/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var distanceValue = 0.0
    @State private var distanceFrom = "Mts"
    @State private var distanceTo = "Kms"
    @FocusState private var distanceIsFocused: Bool
    
    let distanceLenghts = ["Mts","Kms","Feets","Yards","Miles"]
    
    var convertedDistance: Double {
        var mtsDistance = distanceValue
        var finalDistance: Double
        
        if distanceFrom == "Kms" {
            mtsDistance *= 1000
        }else if distanceFrom == "Feets" {
            mtsDistance *= 0.3048
        }else if distanceFrom == "Yards" {
            mtsDistance *= 0.9144
        }else if distanceFrom == "Miles" {
            mtsDistance *= 1609.34
        }
        
        if distanceTo == "Kms" {
            finalDistance = mtsDistance / 1000
        }else if distanceTo == "Feets" {
            finalDistance = mtsDistance / 0.3048
        }else if distanceTo == "Yards" {
            finalDistance = mtsDistance / 0.9144
        }else if distanceTo == "Miles" {
            finalDistance = mtsDistance / 1609.34
        }else {
            finalDistance = mtsDistance
        }
        
        return finalDistance
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Convert") {
                    TextField("Distance Value", value: $distanceValue, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($distanceIsFocused)
                }
                
                Section("From") {
                    Picker("From", selection: $distanceFrom) {
                        //let differentDistanceTo = distanceLenghts.filter { $0 != distanceTo }
                        
                        //ForEach(differentDistanceTo, id: \.self) {
                        ForEach(distanceLenghts, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("To") {
                    Picker("To", selection: $distanceTo) {
                        let differentDistanceFrom = distanceLenghts.filter { $0 != distanceFrom }
                        
                        ForEach(differentDistanceFrom, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("New Distance in \(distanceTo)") {
                    Text(convertedDistance, format: .number)
                }
                
            }
            .navigationTitle("Magic Converter 🪄")
            .toolbar {
                if distanceIsFocused {
                    Button("Done") {
                        distanceIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

// --------------------------------------------------------------------------------------

/*
 This is another code, attempting to solve the app with "Measurement". I have to do more research to understand why it didn't work.
 */

/*
 struct ContentView: View {
     @State static private var distanceValue = 120.3
     @State private var distanceFrom = "Mts"
     @State private var distanceTo = "Kms"
     @FocusState private var distanceIsFocused: Bool
     
     let distanceLenghts = ["Mts","Kms","Feet","Yards","Miles"]
     
     let initialDistance = Measurement(value: distanceValue, unit: UnitLength.meters)
     
     var convertedDistance: Measurement<UnitLength> {
         var finalDistance = initialDistance
         
         if distanceTo == "Kms" {
             return finalDistance.converted(to: .kilometers)
         }else if distanceTo == "Feet" {
             return finalDistance.converted(to: .feet)
         }else if distanceTo == "Yards" {
             return finalDistance.converted(to: .yards)
         }else if distanceTo == "Miles" {
             return finalDistance.converted(to: .miles)
         }else {
             return finalDistance
         }
     }
     
     var body: some View {
         NavigationStack {
             Form {
                 Section("Convert") {
                     TextField("Distance Value", value: ContentView.$distanceValue, format: .number)
                         .keyboardType(.decimalPad)
                         .focused($distanceIsFocused)
                 }
                 
                 Section("From") {
                     Picker("From", selection: $distanceFrom) {
                         ForEach(distanceLenghts, id: \.self) {
                             Text($0)
                         }
                     }
                     .pickerStyle(.segmented)
                 }
                 
                 Section("To") {
                     Picker("To", selection: $distanceTo) {
                         ForEach(distanceLenghts, id: \.self) {
                             Text($0)
                         }
                     }
                     .pickerStyle(.segmented)
                 }
                 
                 Section("New Distance") {
                     Text(convertedDistance, format: .number)
                 }
                 
             }
             .navigationTitle("Magic Converter")
             .toolbar {
                 if distanceIsFocused {
                     Button("Close keyboard") {
                         distanceIsFocused = false
                     }
                 }
             }
         }
     }
 }
 */
