//
//  ContentView.swift
//  sample-keychain-ios
//
//  Created by Abhishek Warokar on 23/08/23.
//

import SwiftUI

struct ContentView: View {
    @State var uuid: String?

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "key.viewfinder")
                .imageScale(.large)
                .foregroundColor(.accentColor)

            Text("\(Keychain.shared.get(.randomNumber) ?? "No random number stored in Keychain")")
                .font(.body)

            HStack(spacing: 12) {
                Button("Fetch random number") {
                    Task { @MainActor in
                        URLSession.shared.dataTask(with: URLRequest(url: URL(string: "https://keychain.glitch.me/random")!)) { data, response, error in
                            if let data, let number = String(data: data, encoding: .utf8) {
                                print("Received: \(number). Writing to Keychain.")
                                Keychain.shared.set(.randomNumber, number)
                            }
                        }.resume()
                    }
                }

                Button("Clear Keychain") {
                    uuid = nil
                    Keychain.shared.clearAll()
                }
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
