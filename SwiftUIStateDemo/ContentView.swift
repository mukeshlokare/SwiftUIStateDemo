//
//  ContentView.swift
//  SwiftUIStateDemo
//
//  Created by mukesh on 20/06/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var experience = 1
    @State private var temperature: Double = 0
    @State var percentage: Float = 50

    
    var body: some View {
        
        VStack {
            
            Stepper("Your experience",value: $experience, in: 0...15)
            Text("Your experience is \(experience)")
            
            VStack {
                Slider(value: $temperature, in: -50...100, step: 0.1)
                Text("\(temperature) Temperature is \(temperature * 9 / 5 + 32) Fahrenheit")
            }
            
            CustomView(percentage: $percentage)
                            .accentColor(.red)
                            .frame(width: 200, height: 44)
//            https://github.com/spacenation/swiftui-sliders
            
            //https://github.com/AvdLee/SwiftUIKitView.git
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CustomView: View {

    @Binding var percentage: Float // or some value binded

    var body: some View {
        GeometryReader { geometry in
            // TODO: - there might be a need for horizontal and vertical alignments
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(.gray)
                Rectangle()
                    .foregroundColor(.accentColor)
                    .frame(width: geometry.size.width * CGFloat(self.percentage / 100))
            }
            .cornerRadius(12)
            .gesture(DragGesture(minimumDistance: 0)
                .onChanged({ value in
                    // TODO: - maybe use other logic here
                    self.percentage = min(max(0, Float(value.location.x / geometry.size.width * 100)), 100)
                }))
        }
    }
}
