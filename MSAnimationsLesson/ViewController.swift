//
//  ViewController.swift
//  MSAnimationsLesson
//
//  Created by 清风 on 2016/11/4.
//  Copyright © 2016年 mr.scorpion. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: Properties
    @IBOutlet weak var numberOfFishSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create and add a colored square
        let coloredSquare = UIView()
        let coloredSquare2 = UIView()
        let coloredSquare3 = UIView()
        let coloredSquare4 = UIView()
        
        let topMargin = 70, wh = 50
        
        // set background color to blue
        coloredSquare.backgroundColor = UIColor.blue
        coloredSquare2.backgroundColor = UIColor.blue
        coloredSquare3.backgroundColor = UIColor.blue
        coloredSquare4.backgroundColor = UIColor.blue
        
        // set frame (position and size) of the square
        // iOS coordinate system starts at the top left of the screen
        // so this square will be at top left of screen, 50x50pt
        // CG in CGRect stands for Core Graphics
        coloredSquare.frame = CGRect(x: 0, y: topMargin, width: wh, height: wh)
        coloredSquare2.frame = CGRect(x: 0, y: topMargin + wh, width: wh, height: wh)
        coloredSquare3.frame = CGRect(x: 0, y: topMargin + wh * 2, width: wh, height: wh)
        coloredSquare3.frame = CGRect(x: 0, y: topMargin + wh * 3, width: wh, height: wh)
        
        // finally, add the square to the screen
        self.view.addSubview(coloredSquare)
        self.view.addSubview(coloredSquare2)
        self.view.addSubview(coloredSquare3)
        self.view.addSubview(coloredSquare4)
        
        
        /* 1. Simple animation block */
        // lets set the duration to 1.0 seconds
        // and in the animations block change the background color
        // to red and the x-position  of the frame
        UIView.animate(withDuration: 1.0, animations: {
            coloredSquare.backgroundColor = UIColor.red
            
            // for the x-position I entered 320-50 (width of screen - width of the square)
            // if you want, you could just enter 270
            // but I prefer to enter the math as a reminder of what's happenings
            coloredSquare.frame = CGRect(x: 320-50, y: topMargin, width: 50, height: 50)
        })
        
        
        /* 4. Animation block with spring physics */
        // 4.1
        let options = UIViewAnimationOptions.repeat
        UIView.animate(withDuration: 1.0, delay: 1.0, options: options, animations: {
            
            // any changes entered in this block will be animated
            coloredSquare2.backgroundColor = UIColor.red
            coloredSquare2.frame = CGRect(x: 320-50, y: topMargin + wh, width: 50, height: 50)
            
            }, completion: nil)
        
        
        // 4.2
        let options2 = UIViewAnimationOptions.autoreverse
        let duration = 1.0
        let delay = 0.0
        let damping = 0.5 // set damping ration
        let velocity = 1.0 // set initial velocity
        
        UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: CGFloat(damping), initialSpringVelocity: CGFloat(velocity), options: options2, animations: {
            
            // any changes entered in this block will be animated
            coloredSquare3.backgroundColor = UIColor.red
            coloredSquare3.frame = CGRect(x: 320-50, y: topMargin + wh * 2, width: 50, height: 50)
            
            }, completion: { finished in
                // any code entered here will be applied
                // once the animation has completed
        })
        
        
        /*// 4.3 Animation block with options & completion block
        let options3 = [UIViewAnimationOptions.autoreverse, UIViewAnimationOptions.repeat, UIViewAnimationOptions.curveEaseInOut]
        let duration3 = 1.0
        let delay3 = 0.0 // delay will be 0.0 seconds (e.g. nothing)
        
        UIView.animate(withDuration: duration3, delay: delay3, options: options3, animations: {
            // any changes entered in this block will be animated
            coloredSquare4.backgroundColor = UIColor.red
            coloredSquare4.frame = CGRect(x: 320-50, y: topMargin + wh * 3, width: 50, height: 50)
            }, completion: { finished in
                // any code entered here will be applied
                // once the animation has completed
        })*/
        
        
        // Tap gesture
        // 建立手势识别器
        let gesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.toNext))
        gesture.numberOfTapsRequired = 2
        // 附加识别器到视图
        self.view.addGestureRecognizer(gesture)
    }

    
    // MARK: Actions
    @IBAction func animateButtonPressed(_ sender: UIButton) {
        
        /* 5. */
        // set up some constants for the square
        let size : CGFloat = 50
        let yPosition : CGFloat = 70+150
        
        // set up some constants for the animation
        let duration = 1.0
        let delay = 0.0
        let options = UIViewAnimationOptions.curveLinear
        
        // Create and add a colored square
        let coloredSquare5 = UIView()
        
        // set background color to blue
        coloredSquare5.backgroundColor = UIColor.blue
        
        // set frame (position and size) of the square
        // iOS coordinate system starts at the top left of the screen
        // CGRect creates a frame with (x,y,width,height) values
        // so this square will be at top left of screen, 50x50pt
        // CG in CGRectMake stands for Core Graphics
        coloredSquare5.frame = CGRect(x:0, y:yPosition, width:size, height:size)
        
        // finally, add the square to the screen
        self.view.addSubview(coloredSquare5)
        
        // lets set the duration to 1.0 seconds
        // and in the animations block change the background color
        // to red and the x-position  of the frame
        // define the animation
        UIView.animate(withDuration: duration, delay: delay, options: options, animations: {
            
            coloredSquare5.backgroundColor = UIColor.red
            
            // again use the square constants size and yPosition
            coloredSquare5.frame = CGRect(x: 320-size, y: yPosition, width: size, height: size)
            
            }, completion: { animationFinished in
                // when complete, remove the square from the parent view
                coloredSquare5.removeFromSuperview()
                
        })
        
        
        /* 6. */
        let numberOfFish = Int(self.numberOfFishSlider.value)
        // loop for 10 times
//        for loopNumber in 0...10 {
        for _ in 0...numberOfFish {
            
            // set up some constants for the animation
            let duration6 : TimeInterval = 1.0
            // let delay6 : TimeInterval = 0.0
            // … to be a random value between 0.9 and 1.0
            // randomly assign a delay of 0.9 to 1s
            let delay6 = TimeInterval(900 + arc4random_uniform(100)) / 1000
            
            let options6 = UIViewAnimationOptions.curveLinear
            
            // set up some constants for the fish
            // set size to be a random number between 20.0 and 60.0
            let size6 : CGFloat = CGFloat( arc4random_uniform(40))+20
            // set yPosition to be a random number between yPosition.0 and 200.0+yPosition
            let yPosition6 : CGFloat = CGFloat( arc4random_uniform(200))+yPosition+50
            
            // create the fish and add it to the screen
            let fish = UIImageView()
            fish.image = UIImage(named: "blue-fish.png")
            fish.frame = CGRect(x: 0, y: yPosition6, width: size6, height: size6)
            self.view.addSubview(fish)
            
            // define the animation
            UIView.animate(withDuration: duration6, delay: delay6, options: options6, animations: {
                
                // move the fish
                fish.frame = CGRect(x: 320-size, y: yPosition, width: size, height: size)
                
                }, completion: { animationFinished in
                    
                    // remove the fish
                    fish.removeFromSuperview()
            })
        }
        
    }
    
    /* xib 跳转 1 */
    func toNext() {
        let firstVC = ContainerVC(nibName:"ContainerVC",bundle: nil)
        present(firstVC, animated: true, completion: nil)
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

