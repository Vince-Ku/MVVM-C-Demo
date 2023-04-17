//
//  RecordsViewModelTests.swift
//  MVVMC-DemoTests
//
//  Created by 辜敬閎 on 2023/4/2.
//

import XCTest
@testable import MVVMC_Demo

final class RecordsViewModelTests: XCTestCase {

    private var sut: RecordsViewModel!
    
    ///
    /// 當`畫面成功載入`時, 撈取歷史`抽獎訂單記錄 mockOrders`，顯示所有`抽獎紀錄 expectedRecordCellViewObject`
    ///
    func testShowLotteryRecordsWhenViewDidLoad() {
        let mockOrders = [
            Order(id: "1", lotteryNumber: "99", lotteryResult: true, createdData: Date()),
            Order(id: "2", lotteryNumber: "1", lotteryResult: false, createdData: Date()),
            Order(id: "3", lotteryNumber: "50", lotteryResult: false, createdData: Date()),
            Order(id: "4", lotteryNumber: "77", lotteryResult: true, createdData: Date())
        ]
        
        let expectedRecordCellViewObject = [
            RecordCellViewObject(titleStyle: .highLight("恭喜中獎！！"),
                                 detailColumnText: "您抽中的號碼為 99",
                                 starImageStyle: .regular),
            RecordCellViewObject(titleStyle: .regular("下次再來"),
                                 detailColumnText: "您抽中的號碼為 1",
                                 starImageStyle: .none),
            RecordCellViewObject(titleStyle: .regular("下次再來"),
                                 detailColumnText: "您抽中的號碼為 50",
                                 starImageStyle: .none),
            RecordCellViewObject(titleStyle: .highLight("恭喜中獎！！"),
                                 detailColumnText: "您抽中的號碼為 77",
                                 starImageStyle: .regular),
        ]
        
        let delegate = MockRecordsViewModelOutputDelegate()
        let coordinator = MockRecordsCoordinator()
        let orderRepository = MockOrderRepository(orders: mockOrders)
            
        sut = makeSUT(delegate: delegate, coordinator: coordinator, orderRepository: orderRepository)
        
        sut.viewDidLoad()
        
        XCTAssertTrue(delegate.calledFunctions.contains(where: { $0 == .releadRecords(expectedRecordCellViewObject)}))
    }
        
    private func makeSUT(delegate: RecordsViewModelOutputDelegate, coordinator: RecordsCoordinatorType, orderRepository: OrderRepositoryType) -> RecordsViewModel {
        let viewModel = RecordsViewModel(coordinator: coordinator, orderRepository: orderRepository)
        viewModel.delegate = delegate
        return viewModel
    }
}

// MARK: Mock Objects
private class MockRecordsViewModelOutputDelegate: RecordsViewModelOutputDelegate {
    enum Function: Equatable {
        static func == (lhs: MockRecordsViewModelOutputDelegate.Function, rhs: MockRecordsViewModelOutputDelegate.Function) -> Bool {
            switch (lhs, rhs) {
            case (.releadRecords(let lViewObjects), .releadRecords(let rViewObjects)):
                return lViewObjects == rViewObjects
            }
        }

        case releadRecords([RecordCellViewObject])
    }
    
    var calledFunctions: [Function] = []
    
    func reloadRecords(records: [RecordCellViewObject]) {
        calledFunctions.append(.releadRecords(records))
    }
}

private class MockRecordsCoordinator: RecordsCoordinatorType {
    func start() {}
}

private class MockOrderRepository: OrderRepositoryType {
    private let orders: [Order]
    
    init(orders: [Order]) {
        self.orders = orders
    }
    
    func fetchOrders(completion: (([Order]) -> Void)) {
        completion(orders)
    }
}
