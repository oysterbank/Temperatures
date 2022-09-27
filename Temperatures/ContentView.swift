//
//  ContentView.swift
//  Temperatures
//
//  Created by Kris Laratta on 9/27/22.
//

import SwiftUI

struct ContentView: View {
    @State private var temperatureValue = 0.0
    @State private var inputUnit = "Fahrenheit"
    @State private var outputUnit = "Celsius"
    let units = ["Fahrenheit", "Celsius", "Kelvin"]
    
    func convertTemp(temp: Double, from inputTempType: UnitTemperature, to outputTempType: UnitTemperature) -> Double {
        let input = Measurement(value: temp, unit: inputTempType)
        let output = input.converted(to: outputTempType)
        return output.value
    }
    
    var outputTemperature: Double {
        // Convert to Kelvin first
        var normalizedTemp = 0.0
        if (inputUnit == "Fahrenheit") {
            normalizedTemp = convertTemp(temp: temperatureValue, from: .fahrenheit, to: .kelvin)
        } else if (inputUnit == "Celsius") {
            normalizedTemp = convertTemp(temp: temperatureValue, from: .celsius, to: .kelvin)
        } else {
            normalizedTemp = temperatureValue
        }
        
        // Then convert to output unit
        if (outputUnit == "Fahrenheit") {
            return round(convertTemp(temp: normalizedTemp, from: .kelvin, to: .fahrenheit) * 100) / 100
        } else if (outputUnit == "Celsius") {
            return round(convertTemp(temp: normalizedTemp, from: .kelvin, to: .celsius) * 100) / 100
        } else {
            return round(normalizedTemp * 100) / 100
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Input Temperature", value: $temperatureValue, format: .number)
                        .keyboardType(.decimalPad)
                } header: {
                    Text("Input Temperature")
                }
                
                Section {
                    Picker("Input Unit", selection: $inputUnit) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                } header: {
                    Text("Input Unit")
                }
                
                Section {
                    Picker("Output Unit", selection: $outputUnit) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                } header: {
                    Text("Output Unit")
                }
                
                Section {
                    Text(outputTemperature, format: .number)
                } header: {
                    Text("Output Temperature")
                }
            }
            .navigationTitle("Temperatures")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
