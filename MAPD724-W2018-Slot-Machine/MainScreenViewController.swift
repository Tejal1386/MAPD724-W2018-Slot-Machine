//
//  MainScreenViewController.swift
//  MAPD724-W2018-Slot-Machine
//
//  Created by Tejal Patel on 2018-01-29.
//  Copyright © 2018 Centennial College. All rights reserved.
//

import UIKit
import AVFoundation


class MainScreenViewController: UIViewController, UIPickerViewDelegate,UIPickerViewDataSource {
  
  
    // --------------------------------------------------------------------------------------------
    //                                    Variables And Outlets
    // --------------------------------------------------------------------------------------------
    
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
    
    var winSound: AVAudioPlayer!
    var reelSound: AVAudioPlayer!
    
   @IBOutlet var popupMessage: UIView!
    
    @IBOutlet var winPointsView: UIView!
    @IBOutlet weak var popupMessageLabel: UILabel!
    @IBOutlet weak var playerJackpot: UILabel!
    @IBOutlet weak var playerWins: UILabel!
    @IBOutlet weak var winPointPopUp: UILabel!
    
    @IBOutlet weak var betController: UIStepper!
    @IBOutlet weak var player_bet: UILabel!
    @IBOutlet weak var ReelPickerView: UIPickerView!
    @IBOutlet weak var spinButton: UIButton!
    @IBOutlet weak var playerMoney: UILabel!
    
    //Function generate  random number
    func reandomNumber() -> Int {
        let lower : UInt32 = 20
        let upper : UInt32 = 150
        let randomNumber = arc4random_uniform(upper - lower) + lower
        
        return Int(randomNumber)
    }
    
   // --------------------------------------------------------------------------------------------
   //                                          ViewDidLoad
   // --------------------------------------------------------------------------------------------
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       //win Sound settings
        let url = Bundle.main.url(forResource: "Win", withExtension: "mp3")
        do{
            winSound = try AVAudioPlayer(contentsOf: url!)
            winSound.prepareToPlay()
        }
        catch let error as NSError{
            print(error.debugDescription)
        }
       
        //reel Sound settings
        let url1 = Bundle.main.url(forResource: "Spin", withExtension: "mp3")
        do{
            reelSound = try AVAudioPlayer(contentsOf: url1!)
            reelSound.prepareToPlay()
        }
        catch let error as NSError{
            print(error.debugDescription)
        }
        popupMessage.layer.cornerRadius = 5
    }
    
    
    // --------------------------------------------------------------------------------------------
    //                                     PickerView Settings (Reel)
    // --------------------------------------------------------------------------------------------
    // number of collumns in a pickerview(reel)
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 5
    }
    // number of rows in a pickerview(reel)
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 200
    }
    
    //Defining width and height of component in pickerview
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 50.0
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50.0
    }
    
    
    // setting number of elements (images) in a Reel
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let myView = UIView(frame: CGRect(x:0,y:0, width:50, height:50))
        
        let myImageView = UIImageView(frame: CGRect(x:0,y:0,width:50,height:50))
        
        
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
    
    // --------------------------------------------------------------------------------------------
    //                                          Action Function
    // --------------------------------------------------------------------------------------------
    
    //Reset button pressed function to reset slot machine
    @IBAction func resetButtonPressed(_ sender: UIButton) {
       
        winnings = 0
        playerWins.text = "0"
        player_Money = 1000
        playerMoney.text = "1000"
        player_bet.text = "1"
        betController.value = 1
        winNumber = 0
    }
    
    //spin button pressed function to spin a reel in slot machine
    @IBAction func spinButtonPreesed(_ sender: UIButton) {
        ReelPickerView.selectRow((reandomNumber()) , inComponent: 0, animated: true)
        ReelPickerView.selectRow((reandomNumber()) , inComponent: 1, animated: true)
        ReelPickerView.selectRow((reandomNumber()) , inComponent: 2, animated: true)
        ReelPickerView.selectRow((reandomNumber()) , inComponent: 3, animated: true)
        ReelPickerView.selectRow((reandomNumber()) , inComponent: 4, animated: true)
        
        reelSound.play()
          
        playerBet = Int(player_bet.text!)!
        
        if (player_Money == 0) // if no money then show animation message to continue game or quit
        {
            animation()
            
            spinButton.isUserInteractionEnabled = false
            
        }
        else if (playerBet > player_Money) {
            popupMessageLabel.text = "You don't have enough Money to place that bet."
           animation()
           
        }
        
        else if (playerBet <= player_Money) {
            
            determineWinnings(); // winnig criteria set for each spin
            turn += 1;
            showSpinResult(); //display result for each spin on screen
        }
      
        
    }
    
    
    //display result for each spin on screen
    func showSpinResult()
    {
        playerMoney.text = String(player_Money)
        playerWins.text = String(winnings) + " Points"
    }
    
    
    //setting winnig criteria set for each spin
    func determineWinnings()
    {
        // get element id in each collumn set on reel
        element1 = ReelPickerView.selectedRow(inComponent: 0)
        element2 = ReelPickerView.selectedRow(inComponent: 1)
        element3 = ReelPickerView.selectedRow(inComponent: 2)
        element4 = ReelPickerView.selectedRow(inComponent: 3)
        element5 = ReelPickerView.selectedRow(inComponent: 4)
        
        
        
        if(element1>6){
            element1 = element1%7
        }
        if(element2>6){
            element2 = element2%7
        }
        if(element3>6){
            element3 = element3%7
        }
        if(element4>6){
            element4 = element4%7
        }
        if(element5>6){
            element5 = element5%7
        }
        
        element = [ element1, element2, element3, element4, element5]
        
        winnings = 0
        
        //if all five elements match on reel
        if (element1 == element2 && element2 == element3 && element3 == element4 && element4 == element5){
            if element1 == 0
            {
                print("banana")
                winnings = playerBet * 10
            }
            else if element1 == 1 {
                print("grapes")
                winnings = playerBet * 20
            }
            else if element1 == 2 {
                print("strawbery")
                winnings = playerBet * 30
            }
            else if element1 == 3 {
                print("peach")
                winnings = playerBet * 40
            }
            else if element1 == 4 {
                print("bell")
                winnings = playerBet * 50
            }
            else if element1 == 5 {
                print("seven")
                winnings = playerBet * 75
            }
            else if element1 == 6 {
                print("apple")
                winnings = playerBet * 5
            }
            showWinMessage()
            winNumber += 1
            
        }else  if (element1 == element2 && element2 == element3 && element3 == element4 ){  //if four elements match on reel
            if element1 == 0
            {
                print("banana")
                winnings = playerBet * 5
            }
            else if element1 == 1 {
                print("grapes")
                winnings = playerBet * 10
            }
            else if element1 == 2 {
                print("strawbery")
                winnings = playerBet * 15
            }
            else if element1 == 3 {
                print("peach")
                winnings = playerBet * 20
            }
            else if element1 == 4 {
                print("bell")
                winnings = playerBet * 25
            }
            else if element1 == 5 {
                print("seven")
                winnings = playerBet * 35
            }
            else if element1 == 6 {
                print("apple")
                winnings = playerBet * 3
            }
            showWinMessage()
            winNumber += 1
            
        }else if (element2 == element3 && element3 == element4 && element4 == element5){  //if four elements match on reel
            if element2 == 0
            {
                print("banana")
                winnings = playerBet * 5
            }
            else if element2 == 1 {
                print("grapes")
                winnings = playerBet * 10
            }
            else if element2 == 2 {
                print("strawbery")
                winnings = playerBet * 15
            }
            else if element2 == 3 {
                print("peach")
                winnings = playerBet * 20
            }
            else if element2 == 4 {
                print("bell")
                winnings = playerBet * 25
            }
            else if element2 == 5 {
                print("seven")
                winnings = playerBet * 35
            }
            else if element2 == 6 {
                print("apple")
                winnings = playerBet * 3
            }
            showWinMessage()
            winNumber += 1
            
        }
        else if (element1 == element2 && element1 == element3){  //if three elements match on reel
            if element1 == 0
            {
                print("banana")
                winnings = playerBet * 3
            }
            else if element1 == 1 {
                print("grapes")
                winnings = playerBet * 5
            }
            else if element1 == 2 {
                print("strawbery")
                winnings = playerBet * 7
            }
            else if element1 == 3 {
                print("peach")
                winnings = playerBet * 10
            }
            else if element1 == 4 {
                print("bell")
                winnings = playerBet * 12
            }
            else if element1 == 5 {
                print("seven")
                winnings = playerBet * 15
            }
            else if element1 == 6 {
                print("apple")
                winnings = playerBet * 2
            }
            showWinMessage()
            winNumber += 1
        }
        else if (element2 == element3 && element2 == element4){ //if three elements match on reel
            if element2 == 0
            {
                print("banana")
                winnings = playerBet * 3
            }
            else if element2 == 1 {
                print("grapes")
                winnings = playerBet * 5
            }
            else if element2 == 2 {
                print("strawbery")
                winnings = playerBet * 7
            }
            else if element2 == 3 {
                print("peach")
                winnings = playerBet * 9
            }
            else if element2 == 4 {
                print("bell")
                winnings = playerBet * 10
            }
            else if element2 == 5 {
                print("seven")
                winnings = playerBet * 15
            }
            else if element2 == 6 {
                print("apple")
                winnings = playerBet * 2
            }
            showWinMessage()
            winNumber += 1
        }
           
        else if (element3 == element4 && element3 == element5 ){ //if three elements match on reel
            if element3 == 0
            {
                print("banana")
                winnings = playerBet * 3
            }
            else if element3 == 1 {
                print("grapes")
                winnings = playerBet * 5
            }
            else if element3 == 2 {
                print("strawbery")
                winnings = playerBet * 7
            }
            else if element3 == 3 {
                print("peach")
                winnings = playerBet * 9
            }
            else if element3 == 4 {
                print("bell")
                winnings = playerBet * 10
            }
            else if element3 == 5 {
                print("seven")
                winnings = playerBet * 15
            }
            else if element3 == 6 {
                print("apple")
                winnings = playerBet * 2
            }
            showWinMessage()
            winNumber += 1
        }
        else
        {
            loosePoints()
            lossNumber += 1
        }
        
    }
    
    
    // Show win message on screen
    func showWinMessage() {
        winSound.play()
        player_Money += winnings;
        animateWinPoint()
        checkJackPot()
    }
    
    // Loose points if no match on reel
    func loosePoints() {
        player_Money -= playerBet;
    }
    
    // Animation view to display winnig message on screen
    func animateWinPoint()
    {
        self.view.addSubview(winPointsView)
        winPointsView.center = self.view.center
        winPointsView.transform = CGAffineTransform.init(scaleX: 1.5, y: 1.5)
        winPointsView.alpha = 0
        winPointPopUp.text = String(winnings) + " Points"
        UIView.animate(withDuration: 3, animations: {
            self.winPointsView.alpha = 1
            
        }) { (success:Bool) in
            self.winPointsView.alpha = 0
            self.popupMessage.removeFromSuperview()
        }
    }
    
    // Check for jeckpot
    func checkJackPot() {
    /* compare two random values */
        let jackPotTry:Int = reandomNumber()
        let jackPotWin:Int = reandomNumber()
        if (jackPotTry == jackPotWin) {
    
            player_Money += jackpot;
            winSound.play()
            playerJackpot.text = String(jackpot)
            jackpot = 1000;
        }
    }
    
    
    // Increase or decrease bet for user
    @IBAction func betStepper(_ sender: UIStepper) {
        
        let bet = Int(sender.value)
        player_bet.text = String(bet)
    }
    
    // Animation message when player money is finish
    func animation(){
        self.view.addSubview(popupMessage)
        popupMessage.center = self.view.center
        popupMessage.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        popupMessage.alpha = 0
        
        UIView.animate(withDuration: 0.4){
            self.popupMessage.alpha = 1
            self.popupMessage.transform = CGAffineTransform.identity
        }
    }
    
    //If player wants to continue game after finish money Reset game
    @IBAction func popUpViewButton(_ sender: UIButton) {
      
        winnings = 0
        winNumber = 0
        playerWins.text = "0"
        player_Money = 1000
        playerMoney.text = "1000"
        player_bet.text = "1"
        betController.value = 1
        
        UIView.animate(withDuration: 0.3, animations: {
            self.popupMessage.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.popupMessage.alpha = 0
            
        }) { (success:Bool) in
            self.popupMessage.removeFromSuperview()
        }
    }
    
}
