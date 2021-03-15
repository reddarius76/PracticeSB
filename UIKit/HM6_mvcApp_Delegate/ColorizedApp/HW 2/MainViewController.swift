//
//  MainViewController.swift
//  HW 2
//
//  Created by Oleg Krikun on 11.01.2021.
//  Copyright © 2021 Alexey Efimov. All rights reserved.
//

import UIKit

protocol PanelColorViewControllerDelegate {
    func setColorFor(view color: UIColor)
}

class MainViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let panelColorVC = segue.destination as! PanelColorViewController
        panelColorVC.colorFromMainView = view.backgroundColor
        panelColorVC.delegate = self
    }
}

extension MainViewController: PanelColorViewControllerDelegate {
    func setColorFor(view color: UIColor) {
        view.backgroundColor = color
    }
}
