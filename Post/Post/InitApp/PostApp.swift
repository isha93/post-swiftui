//
//  PostApp.swift
//  Post
//
//  Created by isa nur fajar on 11/08/22.
//

import SwiftUI
import netfox

@main
struct PostApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                PostView()
            }
            .onAppear(perform: self.setupNetfox)
        }
    }
}

extension PostApp{
    func setupNetfox(){
        #if DEBUG
        NFX.sharedInstance().start()
        #endif
    }
}
