//
//  HomeViewModel.swift
//  MVVMC-Demo
//
//  Created by 辜敬閎 on 2023/4/1.
//

class HomeViewModel {
    private let coordinator: HomeCoordinatorType

    // MARK: Output
    weak var viewDelegate: HomeViewControllerDelegate?
    
    init(coordinator: HomeCoordinatorType) {
        self.coordinator = coordinator
    }
    
    // MARK: Input
    func recordsButtonDidTap() {
        coordinator.navigateToRecordsModule()
    }

    func lotteryButtonDidTap() {
        getLotteryResult { [weak self] result in
            self?.viewDelegate?.showLotteryResult(result: result)
        }
    }
    
    private func getLotteryResult(completion: (LotteryResult) -> Void) {
        // TODO: implement getLotteryResult
        completion(.win)
    }
}
