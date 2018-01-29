//
//  MainScreenViewController.swift
//  MAPD724-W2018-Slot-Machine
//
//  Created by Tejal Patel on 2018-01-29.
//  Copyright © 2018 Centennial College. All rights reserved.
//

import UIKit

class MainScreenViewController: UIViewController, UIPickerViewDelegate,UIPickerViewDataSource {
   

    @IBOutlet weak var fruitTraypickerView: UIPickerView!
    @IBOutlet weak var spinButton: UIButton!
    
    func reandomNumber(num: Int) -> Int {
        return Int(arc4random_uniform(UInt32(num)))
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func spinButtonClick(_ sender: UIButton) {
        fruitTraypickerView.selectRow((reandomNumber(num: 8)) , inComponent: 0, animated: true)
        fruitTraypickerView.selectRow((reandomNumber(num: 8)) , inComponent: 1, animated: true)
        fruitTraypickerView.selectRow((reandomNumber(num: 8)) , inComponent: 2, animated: true)
        
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 8
    }
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 130.0
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 130.0
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let myView = UIView(frame: CGRect(x:0,y:0, width:130, height:130))
        
        let myImageView = UIImageView(frame: CGRect(x:0,y:0,width:130,height:130))
        
        switch row {
        case 0:
            myImageView.image = UIImage(named:"apple.png")
        case 1:
            myImageView.image = UIImage(named:"banana.png")
        case 2:
            myImageView.image = UIImage(named:"grapes.png")
        case 3:
            myImageView.image = UIImage(named:"cherry.png")
        case 4:
            myImageView.image = UIImage(named:"strawberry.png")
        case 5:
            myImageView.image = UIImage(named:"peach.png")
        case 6:
            myImageView.image = UIImage(named:"bell.png")
        case 7:
            myImageView.image = UIImage(named:"Seven.png")
        default:
            myImageView.image = UIImage(named:"Seven.png")
        }
        
        myView.addSubview(myImageView)
        
        return myView
    }
    
    
    

}
