//
//  HomeCoordinator.swift
//  MVVMC-Demo
//
//  Created by 辜敬閎 on 2023/4/1.
//

import UIKit

class HomeCoordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = HomeViewController()
        navigationController.pushViewController(viewController, animated: true)
    }
}
