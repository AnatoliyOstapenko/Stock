//
//  NewsCoordinator.swift
//  Stock
//
//  Created by AnatoliiOstapenko on 10.12.2022.
//

import UIKit
import SafariServices

protocol NewsCoordinatorProtocol: CoordinatorProtocol {
    func setUpSafariNewsCoordinator(url: URL, viewController: UIViewController)
    func setUpAlertNewsCoordinator(viewController: UIViewController, message: CustomErrors)
    func stop()
}

class NewsCoordinator: NewsCoordinatorProtocol {

    var childCoordinators: [CoordinatorProtocol] = []
    var navController: UINavigationController
    var parentCoordinator: WatchListCoordinatorProtocol?
    
    init(navController: UINavigationController) {
        self.navController = navController
    }
    
    func setUpSafariNewsCoordinator(url: URL, viewController: UIViewController) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .label

        if viewController is NewsVC { newsIsPresent( viewController, vcToPresent: safariVC) }
    }
    
    func setUpAlertNewsCoordinator(viewController: UIViewController, message: CustomErrors) {
        let alertVC = AlertVC(text: message)
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        alertVC.coordinator = self

        if viewController is NewsVC { newsIsPresent(viewController, vcToPresent: alertVC) }
    }
    
    private func newsIsPresent(_ vc: UIViewController, vcToPresent: UIViewController) {
        if vc is NewsVC {
            DispatchQueue.main.async { vc.present(vcToPresent, animated: true) }
        }
    }
    
    func stop() {
        parentCoordinator?.childDidFinish(self)
    }
    
    func start() {}
}
