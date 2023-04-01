//
//  StartUpCoordinator.swift
//  MVVMC-Demo
//
//  Created by 辜敬閎 on 2023/4/1.
//

import UIKit

class StartUpCoordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // setup the initial module when the app launched
    func start() {
        HomeCoordinator(navigationController: navigationController).start()
    }
}
