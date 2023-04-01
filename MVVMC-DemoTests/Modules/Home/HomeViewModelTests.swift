//
//  HomeViewModelTests.swift
//  MVVMC-DemoTests
//
//  Created by 辜敬閎 on 2023/4/1.
//

import XCTest
@testable import MVVMC_Demo

final class HomeViewModelTests: XCTestCase {

    private var sut: HomeViewModel!
    
    ///
    /// `Records Button` 點擊後，開啟 `Records` 模組
    ///
    func testRecordsButtonDidTapAndThenOpenRecordsModule() {
        let mockHomeViewControllerDelegate = MockHomeViewControllerDelegate()
        let mockHomeCoordinator = MockHomeCoordinator()
        let mockLotteryRepository = MockLotteryRepository(lotteryNumber: 10)
        
        sut = makeSUT(viewDelegate: mockHomeViewControllerDelegate, coordinator: mockHomeCoordinator, lotteryRepository: mockLotteryRepository)
        
        sut.recordsButtonDidTap()
        
        XCTAssertTrue(mockHomeCoordinator.calledFunctions.contains(where: { $0 == .navigateToRecordsModule }))
    }
    
    ///
    /// `Lottery Button` 點擊後，執行`抽獎動作`，得到抽獎號碼為`10`，將抽獎結果`失敗`顯示在畫面上。
    ///
    func testLotteryButtonDidTapAndThenShowNumber10FailedResult() {
        let mockHomeViewControllerDelegate = MockHomeViewControllerDelegate()
        let mockHomeCoordinator = MockHomeCoordinator()
        let mockLotteryRepository = MockLotteryRepository(lotteryNumber: 10)
        
        sut = makeSUT(viewDelegate: mockHomeViewControllerDelegate, coordinator: mockHomeCoordinator, lotteryRepository: mockLotteryRepository)
        
        sut.lotteryButtonDidTap()
        
        XCTAssertTrue(mockHomeViewControllerDelegate.calledFunctions.contains(where: { $0 == .showLotteryResult(.lose) }))
    }
    
    ///
    /// `Lottery Button` 點擊後，執行`抽獎動作`，得到抽獎號碼為`50`，將抽獎結果`失敗`顯示在畫面上。
    ///
    func testLotteryButtonDidTapAndThenShowNumber50FailedResult() {
        let mockHomeViewControllerDelegate = MockHomeViewControllerDelegate()
        let mockHomeCoordinator = MockHomeCoordinator()
        let mockLotteryRepository = MockLotteryRepository(lotteryNumber: 50)
        
        sut = makeSUT(viewDelegate: mockHomeViewControllerDelegate, coordinator: mockHomeCoordinator, lotteryRepository: mockLotteryRepository)
        
        sut.lotteryButtonDidTap()
        
        XCTAssertTrue(mockHomeViewControllerDelegate.calledFunctions.contains(where: { $0 == .showLotteryResult(.lose) }))
    }
    
    ///
    /// `Lottery Button` 點擊後，執行`抽獎動作`，得到抽獎號碼為`99`，將抽獎結果`勝利`顯示在畫面上。
    ///
    func testLotteryButtonDidTapAndThenShowNumber99SuccessfulResult() {
        let mockHomeViewControllerDelegate = MockHomeViewControllerDelegate()
        let mockHomeCoordinator = MockHomeCoordinator()
        let mockLotteryRepository = MockLotteryRepository(lotteryNumber: 99)
        
        sut = makeSUT(viewDelegate: mockHomeViewControllerDelegate, coordinator: mockHomeCoordinator, lotteryRepository: mockLotteryRepository)
        
        sut.lotteryButtonDidTap()
        
        XCTAssertTrue(mockHomeViewControllerDelegate.calledFunctions.contains(where: { $0 == .showLotteryResult(.win) }))
    }
    
    private func makeSUT(viewDelegate: HomeViewControllerDelegate, coordinator: HomeCoordinatorType, lotteryRepository: LotteryRepositoryType) -> HomeViewModel {
        let viewModel = HomeViewModel(coordinator: coordinator, lotteryRepository: lotteryRepository)
        viewModel.viewDelegate = viewDelegate
        return viewModel
    }
    
}

// MARK: Mock Objects
private class MockHomeViewControllerDelegate: HomeViewControllerDelegate {
    enum Function: Equatable {
        case showLotteryResult(LotteryResult)
    }
    
    var calledFunctions: [Function] = []
    
    func showLotteryResult(result: LotteryResult) {
        calledFunctions.append(.showLotteryResult(result))
    }
}

private class MockHomeCoordinator: HomeCoordinatorType {
    enum Function {
        case start
        case navigateToRecordsModule
    }
    
    var calledFunctions: [Function] = []
    
    func start() {}
    func navigateToRecordsModule() {
        calledFunctions.append(.navigateToRecordsModule)
    }
}

private class MockLotteryRepository: LotteryRepositoryType {
    private let lotteryNumber: Int
    
    init(lotteryNumber: Int) {
        self.lotteryNumber = lotteryNumber
    }
    
    func fetchLotteryNumber(completion: (Int) -> Void) {
        completion(lotteryNumber)
    }
}
