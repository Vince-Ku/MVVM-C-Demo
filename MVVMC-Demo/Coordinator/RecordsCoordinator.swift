//
//  RecordsCoordinator.swift
//  MVVMC-Demo
//
//  Created by 辜敬閎 on 2023/4/1.
//

import UIKit

class RecordsCoordinator: RecordsCoordinatorType {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = RecordsViewModel(coordinator: self, orderRepository: OrderRepository())
        let viewController = RecordsViewController(viewModel: viewModel)
        
        navigationController.pushViewController(viewController, animated: true)
    }
}
