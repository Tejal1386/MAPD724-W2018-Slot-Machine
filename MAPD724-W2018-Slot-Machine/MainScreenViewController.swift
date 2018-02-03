//
//  MainScreenViewController.swift
//  MAPD724-W2018-Slot-Machine
//
//  Created by Tejal Patel on 2018-01-29.
//  Copyright © 2018 Centennial College. All rights reserved.
//

import UIKit



class MainScreenViewController: UIViewController, UIPickerViewDelegate,UIPickerViewDataSource {
  
  
    // ---------------------------------------------- ---------------------------------------------- ----------------------------------------------
    //                                                               Variables And Outlets
    // ---------------------------------------------- ---------------------------------------------- ----------------------------------------------
    
    var player_Money: Int = 1000
    var winnings:Int = 0
    var jackpot:Int = 5000
    var turn:Int = 0
    var playerBet:Int = 1
    var winNumber:Int = 0
    var lossNumber:Int = 0
    var WinRatio:Int = 0
    
    var element1: Int = 0
    var element2: Int = 0
    var element3: Int = 0
    var element4: Int = 0
    var element5: Int = 0
    var element:[Int] = [0]
    
    
    @IBOutlet weak var playerLoose: UILabel!
    @IBOutlet weak var playerWins: UILabel!
    @IBOutlet weak var player_bet: UILabel!
    @IBOutlet weak var ReelPickerView: UIPickerView!
    @IBOutlet weak var spinButton: UIButton!
    @IBOutlet weak var winNumberLabel: UILabel!
    @IBOutlet weak var playerMoney: UILabel!
    
    //Function generate  random number
    func reandomNumber() -> Int {
        let lower : UInt32 = 20
        let upper : UInt32 = 150
        let randomNumber = arc4random_uniform(upper - lower) + lower
        return Int(randomNumber)
    }
    
   // ---------------------------------------------- ---------------------------------------------- ----------------------------------------------
   //                                                               ViewDidLoad
   // ---------------------------------------------- ---------------------------------------------- ----------------------------------------------
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    // ---------------------------------------------- ---------------------------------------------- ----------------------------------------------
    //                                                               PickerView Settings (Reel)
    // ---------------------------------------------- ---------------------------------------------- ----------------------------------------------
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 5
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 200
    }
    
    //Defining width and height of component in pickerview
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 60.0
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60.0
    }
    
    
    // setting number of elements as an image in Reel
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let myView = UIView(frame: CGRect(x:0,y:0, width:60, height:60))
        
        let myImageView = UIImageView(frame: CGRect(x:0,y:0,width:60,height:60))
        
        
        var Banana:Int=0
        var Grape:Int=1
        var Strawberry:Int=2
        var Peaches:Int=3
        var Bell:Int=4
        var Seven:Int=5
        var Apple:Int=6
        
        for _ in 6 ... 200 {
            Apple=Apple+7
            
            switch row {
                
            case Banana:
               
                myImageView.image = UIImage(named:"banana.png")
            
            case Grape:
               
                myImageView.image = UIImage(named:"grapes.png")
                
            case Strawberry:
                
                myImageView.image = UIImage(named:"strawberry.png")
                
            case Peaches:
                
                myImageView.image = UIImage(named:"peach.png")
                
            case Bell:
             
                myImageView.image = UIImage(named:"bell.png")
                
            case Seven:
               
                myImageView.image = UIImage(named:"Seven.jpg")
                
            default :
               
                myImageView.image = UIImage(named:"apple.png")
                Banana=Banana+7
                Grape=Grape+7
                Strawberry=Strawberry+7
                Peaches=Peaches+7
                Bell=Bell+7
                Seven=Seven+7
                
            }
        }
        myView.addSubview(myImageView)
        
        return myView
    }
    
    // ---------------------------------------------- ---------------------------------------------- ----------------------------------------------
    //                                                               Action Function
    // ---------------------------------------------- ---------------------------------------------- ----------------------------------------------
    
    
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        
    
    }
    
    @IBAction func spinButtonPreesed(_ sender: UIButton) {
        ReelPickerView.selectRow((reandomNumber()) , inComponent: 0, animated: true)
        ReelPickerView.selectRow((reandomNumber()) , inComponent: 1, animated: true)
        ReelPickerView.selectRow((reandomNumber()) , inComponent: 2, animated: true)
        ReelPickerView.selectRow((reandomNumber()) , inComponent: 3, animated: true)
        ReelPickerView.selectRow((reandomNumber()) , inComponent: 4, animated: true)
        
        
        playerBet = Int(player_bet.text!)!
        
      if (playerBet <= player_Money) {
            
            // play
        }
        else {
            //  pay more money to continue spins
        }
        
    }
    
   
}
