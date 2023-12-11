//
//  HomeViewModel.swift
//  SwiftfulCrypto
//
//  Created by Weerawut Chaiyasomboon on 11/12/2566 BE.
//

import Foundation

class HomeViewModel: ObservableObject{
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    
    init(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
            self.allCoins.append(DeveloperPreview.instance.coin)
            self.portfolioCoins.append(DeveloperPreview.instance.coin)
        }
    }
}
