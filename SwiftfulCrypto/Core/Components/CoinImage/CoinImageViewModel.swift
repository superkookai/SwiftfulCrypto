//
//  CoinImageViewModel.swift
//  SwiftfulCrypto
//
//  Created by Weerawut Chaiyasomboon on 20/12/2566 BE.
//

import SwiftUI

class CoinImageViewModel: ObservableObject{
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    
    @MainActor
    func getImage(coin: CoinModel) async{
        self.image = try? await CoinImageService.getCoinImage(urlString: coin.image)
    }
}
