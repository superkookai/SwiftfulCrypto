//
//  CoinImageService.swift
//  SwiftfulCrypto
//
//  Created by Weerawut Chaiyasomboon on 20/12/2566 BE.
//

import SwiftUI

class CoinImageService{
    
    static func getCoinImage(urlString: String) async throws -> UIImage?{
        guard let url = URL(string: urlString) else {
            return nil
        }
        do{
            let (data,response) = try await URLSession.shared.data(from: url)
            guard
                let image = UIImage(data: data),
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300
            else {
                return nil
            }
            return image
        }catch{
            throw error
        }
    }
}
