//
//  ViewController.swift
//  UpDownGame
//
//  Created by 홍희곤 on 11/23/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        slider.setThumbImage(UIImage(named: "slider_thumb"), for: .normal)
        reset()
    }
    var randomNum = 0
    
    //프로퍼티 감시자
    var sliderValue: Int = 15 {
        willSet {
            slider.value = Float(newValue)
            sliderLable.text = "\(newValue)"
        }
    }
    var maxValue: Int = 30 {
        willSet {
            slider.maximumValue = Float(newValue)
            maxLable.text = "\(newValue)"
        }
    }
    var minValue: Int = 0 {
        willSet {
            slider.minimumValue = Float(newValue)
            minLable.text = "\(newValue)"
        }
    }
    var tryValue: Int = 0 {
        willSet {
            tryLable.text = "\(newValue)/5"
        }
    }
    
    //func
    func reset() {
        randomNum = Int.random(in: 0...30)
        tryValue = 0
        maxValue = 30
        minValue = 0
        sliderValue = 15
        mainTitle.text = "Guess the Random Number!"
    }
    
    //Outlet
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var sliderLable: UILabel!
    @IBOutlet weak var minLable: UILabel!
    @IBOutlet weak var maxLable: UILabel!
    @IBOutlet weak var tryLable: UILabel!
    @IBOutlet weak var mainTitle: UILabel!
    
    //Alert
    func showAlert (message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { action in
            self.reset()
        }
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    
    //Actions
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        sliderValue = Int(sender.value)
    }
    @IBAction func touchUpResetButton(_ sender: UIButton) {
        reset()
    }
    @IBAction func touchUpHitButton (_ sender: UIButton) {
        tryValue += 1
        if sliderValue == randomNum {
            showAlert(message: "Correct")
            tryValue = 0
        }
        else if tryValue >= 5 {
            showAlert(message: "Lose")
            reset()
        }
        else if sliderValue > randomNum {
            maxValue = sliderValue
            sliderValue = (maxValue + minValue) / 2
        }
        else {
            minValue = sliderValue
            sliderValue = (maxValue + minValue) / 2
        }
    }
}

