//
//  PartialModalView.swift
//
//  Created by : Tomoaki Yagishita on 2022/03/18
//  © 2022  SmallDeskSoftware
//

import SwiftUI

public struct PartialModalView<Content: View>: View {
    @Binding var isPresenting: Bool
    @State private var sheetHeight: CGFloat = 300
    @State private var fieldString = "Hello"
    var partialView: Content

    let closeThreshold: CGFloat = 30.0

    public init(isPresenting: Binding<Bool>, content: () -> Content) {
        self._isPresenting = isPresenting
        self.partialView = content()
    }
    
    public var body: some View {
        let sheetCloseGesture = DragGesture(minimumDistance: 0.1)
            .onChanged({ value in
                if value.translation.height > closeThreshold {
                    withAnimation {
                        isPresenting = false
                    }
                }
            })
        VStack(spacing:0) {
            Spacer()
            VStack(spacing:0) {
                sheetBar
                partialView
            }
            .gesture(sheetCloseGesture)
            .background(sheetBackground)
            .offset(y: isPresenting ? 0: sheetHeight + 30) // offset a little bit more because of safe area on iOS
            .onPreferenceChange(FrameViewRectPreferenceKey.self, perform: { prefs in
                for pref in prefs {
                    if pref.name == "viewgeom" {
                        sheetHeight = pref.rect.height
                    }
                }
            })
        }
    }
    @ViewBuilder
    var sheetBar: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 2.5).frame(width: 40, height: 5).foregroundColor(.gray)
                .padding()
            HStack(spacing:0) {
                Spacer()
                Button(action: { withAnimation { isPresenting.toggle() } }, label:  {
                    Image(systemName: "xmark.circle").resizable().scaledToFit().frame(width: 25)
                })
                .padding(.trailing, 12)
            }
        }
    }
    
    @ViewBuilder
    var sheetBackground: some View {
        GeometryReader { viewGeom in
            RoundedRectangle(cornerRadius: 10).fill(Color("SheetBackground", bundle: .module))
                .frame(height: viewGeom.frame(in: .local).height + 30)
                .preference(key: FrameViewRectPreferenceKey.self, value: [FrameViewRectPreferenceData(name: "viewgeom", rect: viewGeom.frame(in: .local))])
        }
    }
}

struct FrameViewRectPreferenceData: Equatable {
    let name: String
    let rect: CGRect
}

struct FrameViewRectPreferenceKey: PreferenceKey {
    typealias Value = [FrameViewRectPreferenceData]
    
    static var defaultValue:[FrameViewRectPreferenceData] = []
    
    static func reduce(value: inout [FrameViewRectPreferenceData], nextValue: () -> [FrameViewRectPreferenceData]) {
        value.append(contentsOf: nextValue())
    }
}

struct PartialModalView_Previews: PreviewProvider {
    static var previews: some View {
        PartialModalView(isPresenting: .constant(true), content: {Text("Hello world")})
    }
}
