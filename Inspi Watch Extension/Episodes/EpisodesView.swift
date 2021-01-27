//
//  ContentView.swift
//  Inspi Watch Extension
//
//  Created by Kien on 27/01/2021.
//

import SwiftUI

struct EpisodesView: View {
    @StateObject private var viewModel = EpisodesViewModel()
    @State private var isLoaded = false
    
    var body: some View {
        ScrollView {
            ForEach(viewModel.episodes, content: EpisodeCell.init)
        }
        .padding(.horizontal)
        .onAppear {
            if !isLoaded {
                viewModel.load()
                isLoaded = true
            }
        }
    }
}

struct EpisodeCell: View {
    @ObservedObject var viewModel: EpisodeCellViewModel
    
    var body: some View {
        NavigationLink(destination: CharactersView(episode: viewModel)) {
            HStack {
                Text("Episode \(viewModel.id)")
                    .font(.title2)
                    .fontWeight(.bold)
                    .minimumScaleFactor(0.5)
                Spacer()
            }
            .frame(height: 40)
            
        }
    }
}

struct EpisodesView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodesView()
    }
}
