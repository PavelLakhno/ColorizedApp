//
//  MainViewController.swift
//  ColorizedApp
//
//  Created by Павел Лахно on 11.10.2022.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func setupBackgroundColor(_ color: UIColor)
}

class MainViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        settingsVC.backgroundColor = view.backgroundColor
        settingsVC.delegate = self
    }
}

// MARK: - SettingsViewControllerDelegate

extension MainViewController : SettingsViewControllerDelegate {
    func setupBackgroundColor(_ color: UIColor) {
        view.backgroundColor = color
    }
}


