//
//  CoinDataService.swift
//  SwiftfulCrypto
//
//  Created by Weerawut Chaiyasomboon on 12/12/2566 BE.
//

import Foundation
import Combine

class CoinDataService{
    @Published var allCoins: [CoinModel] = []
    let coinUrl = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h"
    var coinSubcription: AnyCancellable?
    
    init(){
//        getCoins()
    }
    
    private func getCoins(){
        guard let url = URL(string: coinUrl) else { return }
        
        coinSubcription = URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap { (output)->Data in
                guard let response = output.response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .receive(on: DispatchQueue.main)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink { (completion) in
                switch completion{
                case .finished:
                    break
                case .failure(let error):
                    print("DEBUG: \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] returnCoins in
                self?.allCoins = returnCoins
                self?.coinSubcription?.cancel()
            }
    }
    
    func getCoinsAsync() async throws -> [CoinModel]{
        guard let url = URL(string: coinUrl) else { throw URLError(.badURL) }
        do{
            let (data, response) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            return try decoder.decode([CoinModel].self, from: data)
        }catch{
            throw URLError(.badServerResponse)
        }
    }
}
