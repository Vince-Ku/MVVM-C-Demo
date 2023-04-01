//
//  LotteryRepositoryType.swift
//  MVVMC-Demo
//
//  Created by 辜敬閎 on 2023/4/1.
//

import Foundation

protocol LotteryRepositoryType {
    func fetchLotteryNumber(completion: (Int) -> Void)
}
