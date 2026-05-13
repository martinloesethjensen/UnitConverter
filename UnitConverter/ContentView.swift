//
//  ContentView.swift
//  UnitConverter
//
//  Created by Martin Jensen on 13/05/2026.
//

import SwiftUI

struct ContentView: View {
    @State private var inputUnit: UnitLength = .meters
    @State private var length: Double = 0
    @State private var outputUnit: UnitLength = .miles
    @FocusState private var lengthIsFocused: Bool
    
    var output: Measurement<UnitLength> {
        var input = Measurement(value: length, unit: inputUnit)
        return input.converted(to: outputUnit)
    }
    
    private let units: [UnitLength] = [.meters, .kilometers, .yards, .feet, .miles]
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Input") {
                    Picker("Unit", selection: $inputUnit) {
                        ForEach(units, id: \.self) {
                            Text($0.symbol)
                        }
                    }
                    .pickerStyle(.segmented)
                    HStack {
                        TextField("Length", value: $length, format: .number)
                            .keyboardType(.decimalPad)
                            .focused($lengthIsFocused)
                        Text(inputUnit.symbol)
                            .foregroundColor(.secondary)
                    }
                }
                
                Section("Output") {
                    Picker("Unit", selection: $outputUnit) {
                        ForEach(units, id: \.self) {
                            Text($0.symbol)
                        }
                    }
                    .pickerStyle(.segmented)

                    Text(output.formatted(.measurement(width: .abbreviated, usage: .asProvided)))                                            .font(.headline)
                }
            }
            .navigationTitle("UnitConverter")
            .toolbar {
                if lengthIsFocused {
                    Button("Done") {
                        lengthIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
