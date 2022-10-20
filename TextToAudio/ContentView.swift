//
//  ContentView.swift
//  TextToAudio
//
//  Created by 茅根 啓介 on 2022/10/20.
//

import SwiftUI

struct ContentView: View {
    let text = "test"
    var body: some View {
        VStack {
            Button(action: {
                let sp = NSSavePanel()
                sp.allowedContentTypes = [.caf]
                if sp.runModal() == NSApplication.ModalResponse.OK {
                    if sp.url != nil {
                        exportAudio(text,
                                    "",
                                    "en-US",
                                    0.5,
                                    1.0,
                                    0.5,
                                    sp.url!)
                    }
                }
            }) {
                Text("Export")
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
