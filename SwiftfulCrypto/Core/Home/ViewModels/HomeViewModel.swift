//
//  HomeViewModel.swift
//  SwiftfulCrypto
//
//  Created by Weerawut Chaiyasomboon on 11/12/2566 BE.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject{
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    
    private let dataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init(){
//        addSubcribers()
        Task{
            await getAllCoins()
        }
    }
    
    func addSubcribers(){
        dataService.$allCoins
            .sink { [weak self] returnCoins in
                self?.allCoins = returnCoins
            }
            .store(in: &cancellables)
    }
    
    @MainActor
    func getAllCoins() async {
        do{
            self.allCoins = try await dataService.getCoinsAsync()
        }catch{
            print("DEBUG: \(error.localizedDescription)")
        }
    }
}
