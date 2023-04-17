//
//  RecordsViewModel.swift
//  MVVMC-Demo
//
//  Created by 辜敬閎 on 2023/4/1.
//

import Foundation

protocol RecordsViewModelOutputDelegate: AnyObject {
    func reloadRecords(records: [RecordCellViewObject])
}

class RecordsViewModel {
    
    private let coordinator: RecordsCoordinatorType
    private let orderRepository: OrderRepositoryType
    
    // MARK: Output
    weak var delegate: RecordsViewModelOutputDelegate?
    
    init(coordinator: RecordsCoordinatorType, orderRepository: OrderRepositoryType) {
        self.coordinator = coordinator
        self.orderRepository = orderRepository
    }
    
    // MARK: Input
    func viewDidLoad() {
        getRecords(completion: { [weak self] records in
            guard let self = self else { return }
            let recordsViewObjects = self.tranform(records: records)
            self.delegate?.reloadRecords(records: recordsViewObjects)
        })
    }
    
    private func getRecords(completion: ([Record]) -> Void) {
        orderRepository.fetchOrders(completion: { [weak self] orders in
            guard let self = self else { return }
            let records = self.transform(orders: orders)
            completion(records)
        })
    }
    
    private func transform(orders: [Order]) -> [Record] {
        var records: [Record] = []
        
        for order in orders {
            let record = Record(lotteryNumber: Int(order.lotteryNumber) ?? 0,
                                lotteryResult: order.lotteryResult ? .win : .lose,
                                createdDate: order.createdData)
            
            records.append(record)
        }
        
        return records
    }
    
    private func tranform(records: [Record]) -> [RecordCellViewObject] {
        var viewObjects: [RecordCellViewObject] = []
        
        for record in records {
            switch record.lotteryResult {
            case .win:
                viewObjects.append(RecordCellViewObject(titleStyle: .highLight("恭喜中獎！！"),
                                                        detailColumnText: "您抽中的號碼為 \(record.lotteryNumber)",
                                                        starImageStyle: .regular))

            case .lose:
                viewObjects.append(RecordCellViewObject(titleStyle: .regular("下次再來"),
                                                        detailColumnText: "您抽中的號碼為 \(record.lotteryNumber)",
                                                        starImageStyle: .none))
            }
        }
        
        return viewObjects
    }
    
}

