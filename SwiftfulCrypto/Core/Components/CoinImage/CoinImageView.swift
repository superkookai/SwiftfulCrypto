//
//  CoinImageView.swift
//  SwiftfulCrypto
//
//  Created by Weerawut Chaiyasomboon on 20/12/2566 BE.
//

import SwiftUI

struct CoinImageView: View {
    @StateObject var vm: CoinImageViewModel = CoinImageViewModel()
    
    let coin: CoinModel
    
    var body: some View {
        ZStack{
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            }else if vm.isLoading{
                ProgressView()
            }else {
                Image(systemName: "questionmark")
                    .foregroundStyle(Color.theme.secondaryText)
            }
        }
        .onAppear(perform: {
            Task{
                vm.isLoading = true
                await vm.getImage(coin: coin)
                vm.isLoading = false
            }
        })
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    CoinImageView(coin: DeveloperPreview.instance.coin)
}
