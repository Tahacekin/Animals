//
//  AnimalViewModel.swift
//  Animals
//
//  Created by Taha Çekin on 15.06.2021.
//

import Foundation

class AnimalViewModel: ObservableObject {

  @Published var animal = Animal()

  func getAnimal() {

    let stringURL = Bool.random() ? catUrl : dogUrl

    // Create URL Object

    let url = URL(string: stringURL)

    // Check The URL isn't nil

    guard url != nil else {
      print("Looks like the URL is nil")
      return
    }

    // Get a URLSession

    let session = URLSession.shared

    // Create a dataTask

    let dataTask = session.dataTask(with: url!) { data, response, error in
      if error == nil && data != nil {

        // Attempt To Parse JSON
        do {

          if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [[String: Any]] {

            let item = json.isEmpty ? [:] : json[0]

            if let animal = Animal(json: item) {

              DispatchQueue.main.async {

                while animal.imageData == nil {}
                self.animal = animal

              }

            }
          }

        }
        catch {
          print("Coudln't parse JSON")
        }
      }
    }

    // Start the dataTask
    dataTask.resume()
  }

}
