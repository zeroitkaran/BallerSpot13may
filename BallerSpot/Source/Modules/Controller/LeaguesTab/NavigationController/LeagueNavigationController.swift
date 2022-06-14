//
//  LeagueNavigationController.swift
//  BallerSpot
//
//  Created by Zeroit on 24/02/20.
//  Copyright © 2020 Zero ITSolutions. All rights reserved.
//

import UIKit

class LeagueNavigationController: UINavigationController {

    open override var childForStatusBarHidden: UIViewController? {
        return self.topViewController
    }

    open override var childForStatusBarStyle: UIViewController? {
        return self.topViewController
    }
}
