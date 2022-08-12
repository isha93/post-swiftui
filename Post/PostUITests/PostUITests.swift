//
//  PostUITests.swift
//  PostUITests
//
//  Created by isa nur fajar on 11/08/22.
//

import XCTest
import SwiftUI

class PostUITests: XCTestCase {
    let app = XCUIApplication()

      override func setUp() {
          super.setUp()
      }
      
      func postItemView() {
          app.launch()
          let detail = app.buttons["PostItemView"]
          XCTAssertTrue(detail.exists)
      }
    
    func progressView() {
        app.launch()
        let progressView = app.buttons["ProgressView"]
        XCTAssertTrue(progressView.exists)
    }
}
