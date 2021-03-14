//
//  ContentView.swift
//  Toast
//
//  Created by Azhagusundaram Tamil on 29/01/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var topToast: Bool = false
    @State private var bottomToast: Bool = false
    @State private var colorToast: Bool = false
    @State private var titleMessageToast: Bool = false
    @State private var titleImageToast: Bool = false
    @State private var imageToast: Bool = false
    
    @State private var toastType: ToastType = ToastType.scaleToast
    @State private var toastAlignment: VerticalAlignment = .bottom
    
    @State private var color: Color = Color.primary.opacity(0.5)
    @State private var duration: Int = 2
    
    private var message = "Here is the toast message"
    private var title = "Toast Title"
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Toast Type")) {
                    EnumPicker(selected: $toastType)
                        .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Toast BG Color")) {
                    ColorPicker("", selection: $color)
                }
                
                Section(header: Text("Toast Duration (seconds)")) {
                    Picker("Toast duration", selection: $duration) {
                        ForEach(1..<6) { index in
                            Text("\(index)")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Button("Top toast") {
                    withAnimation {
                        topToast.toggle()
                    }
                }
                Button("Bottom toast") {
                    withAnimation(Animation.spring()) {
                        bottomToast.toggle()
                    }
                }
                Button("Toast with title") {
                    withAnimation(Animation.spring()) {
                        titleMessageToast.toggle()
                    }
                }
                
                Button("Title and image toast") {
                    withAnimation(Animation.spring()) {
                        titleImageToast.toggle()
                    }
                }
                
                Button("Image toast") {
                    withAnimation(Animation.spring()) {
                        imageToast.toggle()
                    }
                }
            }
            .showToast(message, isPresented: $bottomToast, color: color, duration: duration, alignment: .bottom, toastType: toastType)
            .showToast(message, isPresented: $topToast, color: color, duration: duration, alignment: .top, toastType: toastType)
            .showToastWithTitle(title: title, message: message, isPresented: $titleMessageToast, color: color, toastType: toastType)
            .showToastWithTitleAndImage(title: title, message: message, image: Image(systemName: "person"), isPresented: $titleImageToast, color: color, toastType: toastType)
            .showToastWithImage(message, image: Image(systemName: "checkmark.circle"), isPresented: $imageToast, color: color, duration: duration, toastType: toastType)
            .navigationBarTitle("Toast")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



struct EnumPicker<T: Hashable & CaseIterable, V: View>: View {
    
    @Binding var selected: T
    var title: String? = nil
    
    let mapping: (T) -> V
    
    var body: some View {
        Picker(selection: $selected, label: Text(title ?? "")) {
            ForEach(Array(T.allCases), id: \.self) {
                mapping($0).tag($0)
            }
        }
    }
}

extension EnumPicker where T: RawRepresentable, T.RawValue == String, V == Text {
    init(selected: Binding<T>, title: String? = nil) {
        self.init(selected: selected, title: title) {
            Text($0.rawValue)
        }
    }
}
