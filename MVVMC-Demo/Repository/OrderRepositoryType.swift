//
//  OrderRepositoryType.swift
//  MVVMC-Demo
//
//  Created by 辜敬閎 on 2023/4/1.
//

import Foundation

protocol OrderRepositoryType {
    func fetchOrders(completion: (([Order]) -> Void))
}
