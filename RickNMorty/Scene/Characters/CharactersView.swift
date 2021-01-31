//
//  CharactersView.swift
//  RickNMorty
//
//  Created by Kien on 1/25/21.
//

import SwiftUI
import Kingfisher

struct CharactersView: View {
    @ObservedObject var episode: EpisodeCellViewModel
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                ForEach(episode.characters, id: \.self, content: CharacterCell.init)
            }
        }
        .navigationTitle("Episode \(episode.id)")
        .navigationBarItems(trailing: Button(action: { episode.isLiked.toggle() }, label: { Image(systemName: episode.isLiked ? "heart.fill" : "heart") })
        )
    }
}

struct CharacterCell: View {
    let characterUrl: String
    @StateObject var viewModel = ViewModel()
    
    init(characterUrl: String) {
        self.characterUrl = characterUrl
    }
    
    var body: some View {
        VStack {
            KFImage.url(URL(string: viewModel.imageURL))
                .cornerRadius(20.0)
            VStack {
                Text(viewModel.name)
                    .font(.title)
                    .multilineTextAlignment(.center)
                HStack {
                    Text("●").foregroundColor(viewModel.statusColor)
                    Text("\(viewModel.status.capitalized) - \(viewModel.species)")
                }
                Text("Gender: \(viewModel.gender)")
                if viewModel.location != "unknown" {
                    Text("Last known location:")
                    Text("\(viewModel.location)")
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            Spacer(minLength: 40)
        }
        .onAppear {
            viewModel.loadCharacter(url: characterUrl)
        }
    }
}

struct CharactersView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersView(episode: EpisodeCellViewModel(RickAndMortyService.EpisodeResponse.Episode(id: 1, name: "", characters: [], airDate: "")))
    }
}
