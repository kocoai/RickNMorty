//
//  CharactersViewModel.swift
//  RickNMorty
//
//  Created by Kien on 26/01/2021.
//

import Foundation
import Combine
import SwiftUI

extension CharacterCell {
    final class ViewModel: ObservableObject {
        @Published var imageURL = ""
        @Published var name = ""
        @Published var gender = ""
        @Published var status = ""
        @Published var species = ""
        @Published var location = ""
        
        private let service = RickAndMortyService()
        private var cancellables = Set<AnyCancellable>()
        var statusColor: Color {
            switch status {
            case "Alive": return .green
            case "Dead": return .red
            default: return .orange
            }
        }
        
        func loadCharacter(url: String) {
            service.fetchCharacter(url: url)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { value in
                    switch value {
                    case .failure(let error):
                        print(error)
                    case .finished:
                        break
                    }
                }, receiveValue: { [weak self] data in
                    self?.imageURL = data.image
                    self?.name = data.name
                    self?.gender = data.gender
                    self?.status = data.status
                    self?.species = data.species
                    self?.location = data.location.name
                    #if DEBUG
                    print(data)
                    #endif
                })
                .store(in: &cancellables)
        }
    }
}
