# SDSPartialModalView

![macOS iOS](https://img.shields.io/badge/platform-iOS_macOS-lightgrey)
![iOS](https://img.shields.io/badge/iOS-v15_orLater-blue)
![macOS](https://img.shields.io/badge/macOS-Monterey_orLater-blue)
![SPM is supported](https://img.shields.io/badge/SPM-Supported-orange)
![license](https://img.shields.io/badge/license-MIT-lightgrey)

simple partial modal view

## in 30sec

### light mode
https://user-images.githubusercontent.com/6419800/159105241-3200b3ef-d6c3-4ddc-9873-15db9a288ed8.mp4

### dark mode
https://user-images.githubusercontent.com/6419800/159105246-424e3fa8-b6a7-46a2-9499-351e0f245eaf.mp4

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

