//
//  Animal.swift
//  Animals
//
//  Created by Taha Çekin on 15.06.2021.
//

import Foundation

class Animal {
  // Get the Image URL
  var imageURL: String

  // Get Image Data
  var imageData: Data?

  init() {
    self.imageURL = ""
    self.imageData = nil
  }

  init?(json: [String: Any]) {

    // Check if the JSON has the URL
    guard let imageURL = json["url"] as? String else {
      return nil
    }

    // Set The Animal Properties
    self.imageURL = imageURL
    self.imageData = nil

    // Download the Image Data
      getImage()
  }

  func getImage() {

    // Create URL Object

    let url = URL(string: imageURL)

    // Check That the URL isn't nil

    guard url != nil else {
      print("Looks like the URL is nil")
      return
    }

    // Create the session

    let session = URLSession.shared

    // Create The dataTask

    let dataTask = session.dataTask(with: url!) { data, response, error in

      if error == nil && data != nil {
        self.imageData = data
      }

    }

    // Start The dataTask
    dataTask.resume()
  }

}
