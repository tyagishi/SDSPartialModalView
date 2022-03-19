# SDSPartialModalView

simple partial modal view

## in 30sec
Video will come

## usage
need to use together with ZStack.

```
//
//  ContentView.swift
//
//  Created by : Tomoaki Yagishita on 2022/03/10
//  © 2022  SmallDeskSoftware
//

import SwiftUI
import SDSPartialModalView

struct ContentView: View {
    @State private var showPartial = false
    @State private var fieldValue = "Hello"

    var body: some View {
        ZStack {
            VStack {
                Button(action: {
                    withAnimation {
                        showPartial.toggle()
                    }
                }, label: {
                    Text("partial modal")
                })
            }
            PartialModalView(isPresenting: $showPartial, content: {
                VStack {
                    Text("Hello")
                    TextField("Text", text: $fieldValue)
                        .textFieldStyle(.roundedBorder)
                }
                .padding()
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

```

