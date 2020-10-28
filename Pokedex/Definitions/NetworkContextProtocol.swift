import Foundation

protocol NetworkContextProtocol {
    func getPokemonList(completion: @escaping (Result<PokePreviewList, Error>) -> Void) -> Request?
    func getPokemonList(with urlString: String, completion:  @escaping (Result<PokePreviewList, Error>) -> Void) -> Request?
    func getPokemonImage(with urlString: String, completion:  @escaping (Result<Data, Error>) -> Void) -> Request?
}
