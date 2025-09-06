import Foundation
import Observation

// MARK: - Actions
enum Action {
    case onAppear
    case loadData
}

// MARK: - Protocol (testable seam)
protocol MovieListViewModel {
    var movies: [Movie] { get }
    var isLoading: Bool { get }
    var errorMessage: String? { get }
    func send(_ action: Action)
}

// MARK: - Real ViewModel using the required pattern
@Observable
class RealMovieListViewModel: MovieListViewModel {

    private(set) var movies: [Movie] = []
    private(set) var isLoading = false
    private(set) var errorMessage: String?

    let repository: Repository

    init(repository: Repository) {
        self.repository = repository
    }

    func send(_ action: Action) {
        switch action {
        case .onAppear:
            send(.loadData)
        case .loadData:
            Task { await loadMovies() }
        }
    }

    @MainActor
    private func loadMovies() async {
        isLoading = true
        errorMessage = nil
        do {
            movies = try await repository.fetchData()
        } catch {
            errorMessage = "Failed to load movies: \(error.localizedDescription)"
        }
        isLoading = false
    }
}

// MARK: - Fake VM for previews/tests
class FakeMovieListViewModel: MovieListViewModel {
    var movies: [Movie] = [
        Movie(
            id: 1,
            title: "Sample Movie",
            overview: "This is a sample movie for preview",
            posterURL: nil,
            backdropURL: nil,
            releaseDate: "2023-01-01",
            voteAverage: 7.5
        )
    ]
    var isLoading = false
    var errorMessage: String?
    func send(_ action: Action) {}
}

// MARK: - Minimal domain for the example
struct Movie: Identifiable, Equatable, Sendable {
    let id: Int
    let title: String
    let overview: String
    let posterURL: URL?
    let backdropURL: URL?
    let releaseDate: String
    let voteAverage: Double
}

// MARK: - Repository seam used by the VM
protocol Repository: Sendable {
    func fetchData() async throws -> [Movie]
}