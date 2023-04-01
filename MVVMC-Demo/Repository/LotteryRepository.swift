//
//  LotteryRepository.swift
//  MVVMC-Demo
//
//  Created by 辜敬閎 on 2023/4/1.
//

import Foundation

class LotteryRepository: LotteryRepositoryType {
    
    func fetchLotteryNumber(completion: (Int) -> Void) {
        // Mock api response
        completion(Int.random(in: 0...99))
    }
}
