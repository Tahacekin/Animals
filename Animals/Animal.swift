//
//  Animal.swift
//  Animals
//
//  Created by Taha Çekin on 15.06.2021.
//

import Foundation
import CoreML
import Vision

struct Results: Identifiable {

  var imageLabel: String
  var confidence: Double
  var id = UUID()

}

class Animal {
  // Get the Image URL
  var imageURL: String

  // Get Image Data
  var imageData: Data?

  // Classified Results
  var results: [Results]

  let modelFile = try! MobileNetV2(configuration: MLModelConfiguration())

  init() {
    self.imageURL = ""
    self.imageData = nil
    self.results = []
  }

  init?(json: [String: Any]) {

    // Check if the JSON has the URL
    guard let imageURL = json["url"] as? String else {
      return nil
    }

    // Set The Animal Properties
    self.imageURL = imageURL
    self.imageData = nil
    self.results = []

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
        self.classifyAnimal()
      }

    }

    // Start The dataTask
    dataTask.resume()
  }

  func classifyAnimal() {

    // Get a refrence to the Model

    let model = try! VNCoreMLModel(for: modelFile.model)

    // Create an ImageHandler

    let handler = try! VNImageRequestHandler(data: imageData!)

    // Create a request to the model

    let request = try! VNCoreMLRequest(model: model) { (request, error) in

      guard let results = request.results as? [VNClassificationObservation] else {
        print("Couldn't find the animal")
        return
      }

      // Update Results

      for classification in results {
        var identifier = classification.identifier
        identifier = identifier.prefix(1).capitalized + identifier.dropFirst()
        self.results.append(Results(imageLabel: identifier, confidence: Double(classification.confidence)))
      }

    }

    // Excute The Request
    do {
      try handler.perform([request])
    }
    catch {
      print("Invalid Image")
    }
  }

}
