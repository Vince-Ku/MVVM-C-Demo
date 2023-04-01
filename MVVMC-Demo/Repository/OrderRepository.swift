//
//  OrderRepository.swift
//  MVVMC-Demo
//
//  Created by 辜敬閎 on 2023/4/1.
//

import Foundation

class OrderRepository: OrderRepositoryType {
    
    // mock orders api response
    func fetchOrders(completion: (([Order]) -> Void)) {
        completion([
            Order(id: "1", lotteryNumber: "1", lotteryResult: false, createdData: Date()),
            Order(id: "2", lotteryNumber: "99", lotteryResult: true, createdData: Date()),
            Order(id: "3", lotteryNumber: "50", lotteryResult: false, createdData: Date()),
            Order(id: "4", lotteryNumber: "12", lotteryResult: false, createdData: Date()),
            Order(id: "5", lotteryNumber: "77", lotteryResult: true, createdData: Date()),
            Order(id: "6", lotteryNumber: "83", lotteryResult: true, createdData: Date()),
        ])
    }
}
