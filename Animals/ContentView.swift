//
//  ContentView.swift
//  Animals
//
//  Created by Taha Çekin on 15.06.2021.
//

import SwiftUI

struct ContentView: View {
  @ObservedObject var viewModel: AnimalViewModel

    var body: some View {
      VStack {

        Image(uiImage: UIImage(data: viewModel.animal.imageData ?? Data()) ?? UIImage())
          .resizable()
          .scaledToFill()
          .clipped()
          .edgesIgnoringSafeArea(.all)

        HStack {

          Text("What is it?")
            .font(.title)
            .bold()
            .padding()

          Spacer()

          Button(action: {
            self.viewModel.getAnimal()
          }, label: {
            Text("Next")
              .bold()
          }).padding()
        }
      }.onAppear(perform: viewModel.getAnimal)
      .opacity(viewModel.animal.imageData == nil ? 0 : 1)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      ContentView(viewModel: AnimalViewModel())
    }
}
