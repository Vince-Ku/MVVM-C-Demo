//
//  HomeCoordinator.swift
//  MVVMC-Demo
//
//  Created by 辜敬閎 on 2023/4/1.
//

import UIKit

class HomeCoordinator: HomeCoordinatorType {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = HomeViewModel(coordinator: self, lotteryRepository: LotteryRepository())
        let viewController = HomeViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func navigateToRecordsModule() {
        // TODO: implement start RecordsModule
        print("")
        print("navigateToRecordsModule")
        print("")
    }
}
