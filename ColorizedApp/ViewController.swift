//
//  ViewController.swift
//  ColorizedApp
//
//  Created by Павел Лахно on 24.09.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var redValueLabel: UILabel!
    @IBOutlet weak var greenValueLabel: UILabel!
    @IBOutlet weak var blueValueLabel: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorView.layer.cornerRadius = 10
        setupLabels()
        setupSliders()
    }

    @IBAction func changeColor() {
        setupLabels()
        setupSliders()
    }
    
    private func setupLabels() {
        redValueLabel.text = String(format: "%.2f", redSlider.value)
        greenValueLabel.text = String(format: "%.2f", greenSlider.value)
        blueValueLabel.text = String(format: "%.2f", blueSlider.value)
    }
    
    private func setupSliders() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value), alpha: 1)
    }
}

