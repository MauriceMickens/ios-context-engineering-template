import SwiftUI

struct MovieListView: View {
    // Per requirement: use @State (not @StateObject)
    @State var viewModel: MovieListViewModel

    var body: some View {
        NavigationStack {
            ZStack {
                if viewModel.isLoading {
                    ProgressView("Loading movies…")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .accessibilityLabel("Loading movies")
                } else if let error = viewModel.errorMessage {
                    VStack(spacing: 16) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(.largeTitle)
                            .foregroundStyle(.orange)
                            .accessibilityHidden(true)
                        Text(error)
                            .multilineTextAlignment(.center)
                        Button("Retry") { viewModel.send(.loadData) }
                            .buttonStyle(.borderedProminent)
                    }
                    .padding()
                    .accessibilityElement(children: .combine)
                    .accessibilityLabel("Error: \(error)")
                } else if viewModel.movies.isEmpty {
                    VStack(spacing: 16) {
                        Image(systemName: "film")
                            .font(.largeTitle)
                            .foregroundStyle(.gray)
                        Text("No movies found")
                        Button("Refresh") { viewModel.send(.loadData) }
                            .buttonStyle(.borderedProminent)
                    }
                    .padding()
                } else {
                    List(viewModel.movies) { movie in
                        HStack {
                            Text(movie.title).font(.headline)
                            Spacer()
                            HStack(spacing: 4) {
                                Image(systemName: "star.fill")
                                    .font(.caption)
                                    .foregroundStyle(.yellow)
                                Text(String(format: "%.1f", movie.voteAverage))
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                    .refreshable { viewModel.send(.loadData) }
                }
            }
            .navigationTitle("Trending Movies")
            .task { viewModel.send(.onAppear) }
        }
    }
}

// Preview example:
#Preview {
    MovieListView(viewModel: FakeMovieListViewModel())
}