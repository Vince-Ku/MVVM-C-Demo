//
//  HomeViewModel.swift
//  MVVMC-Demo
//
//  Created by 辜敬閎 on 2023/4/1.
//

protocol HomeViewModelOutputDelegate: AnyObject {
    func showLotteryResult(result: LotteryResult)
}

class HomeViewModel {
    private let coordinator: HomeCoordinatorType
    private let lotteryRepository: LotteryRepositoryType

    // MARK: Output
    weak var delegate: HomeViewModelOutputDelegate?
    
    init(coordinator: HomeCoordinatorType, lotteryRepository: LotteryRepositoryType) {
        self.coordinator = coordinator
        self.lotteryRepository = lotteryRepository
    }
    
    // MARK: Input
    func recordsButtonDidTap() {
        coordinator.navigateToRecordsModule()
    }

    func lotteryButtonDidTap() {
        getLotteryResult { [weak self] result in
            self?.delegate?.showLotteryResult(result: result)
        }
    }
    
    private func getLotteryResult(completion: (LotteryResult) -> Void) {
        lotteryRepository.fetchLotteryNumber { luckyNumber in
            //
            // Note that this logic would be put into the Backend system in the real world
            //
            // if this logic become more complex, you can encapsulate to another object (e.g. LottertUseCase)
            //
            if luckyNumber > 50 {
                completion(.win)
            } else {
                completion(.lose)
            }
        }
    }
}
