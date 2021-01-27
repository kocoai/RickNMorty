//
//  EpisodesView.swift
//  Inspi
//
//  Created by Kien on 1/25/21.
//

import Foundation
import Combine

final class EpisodesViewModel: ObservableObject {
    private let service = RickAndMortyService()
    private var cancellables = Set<AnyCancellable>()
    @Published var episodes = [EpisodeCellViewModel]()
    @Published var navigationTitle = "Episodes"
    
    func load() {
        service.fetchEpisode()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { value in
                switch value {
                case .failure(let error):
                    print(error)
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] data in
                self?.episodes = data.results.map(EpisodeCellViewModel.init)
                self?.navigationTitle = "Episodes (\(data.info.count))"
                #if DEBUG
                print(data)
                #endif
            })
            .store(in: &cancellables)
    }
}

final class EpisodeCellViewModel: ObservableObject, Identifiable {
    let id: Int
    let name: String
    let characters: [String]
    let airDate: String
    @Published var isLiked = false
    
    init(_ episode: RickAndMortyService.EpisodeResponse.Episode) {
        self.id = episode.id
        self.name = episode.name
        self.characters = episode.characters
        self.airDate = episode.airDate
    }
}

