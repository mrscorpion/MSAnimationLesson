//
//  ContainerVC.swift
//  MSAnimationsLesson
//
//  Created by mr.scorpion on 2016/11/4.
//  Copyright © 2016年 mr.scorpion. All rights reserved.
//

import UIKit

class ContainerVC: UIViewController {

    // MARK: Properties
    let container = UIView()
    let container2 = UIView()
    let redSquare = UIView()
    let blueSquare = UIView()
    let orangeSquare = UIView()
    let purpleSquare = UIView()
    let fish = UIImageView()
    
    @IBOutlet weak var toggleButton: UIButton!
    
    /* xib 跳转 2 */
    // 2.继承并重写用nibName初始化的init方法
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    // 3.重写无参数初始化方法，自动调用xib文件
    convenience init() {
        var nibNameOrNil = String?("ContainerVC")
        //考虑到xib文件可能不存在或被删，故加入判断
        if Bundle.main.path(forResource: nibNameOrNil, ofType: "xib") == nil
        {
            nibNameOrNil = nil
        }
        self.init(nibName: nibNameOrNil, bundle: nil)
    }
    // 4.编译器提示需要加入的代码
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /* Container view transitions */
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // set container frame and add to the screen
        self.container.frame = CGRect(x: 60, y: 60, width: 100, height: 100)
        self.view.addSubview(container)
        self.container2.frame = CGRect(x: 60, y: 200, width: 100, height: 100)
        self.view.addSubview(container2)
        let transitonGesture = UITapGestureRecognizer(target: self.container2, action: #selector(ContainerVC.transitionAction))
        transitonGesture.numberOfTapsRequired = 2
        // 附加识别器到视图
        self.container2.addGestureRecognizer(transitonGesture)
        
        // set red square frame up
        // we want the blue square to have the same position as redSquare
        // so lets just reuse blueSquare.frame
        self.redSquare.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        self.blueSquare.frame = redSquare.frame
        self.orangeSquare.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        self.purpleSquare.frame = orangeSquare.frame
        
        // set background colors
        self.redSquare.backgroundColor = UIColor.red
        self.blueSquare.backgroundColor = UIColor.blue
        self.orangeSquare.backgroundColor = UIColor.orange
        self.purpleSquare.backgroundColor = UIColor.purple
        
        // for now just add the redSquare
        // we'll add blueSquare as part of the transition animation
        self.container.addSubview(self.redSquare)
        self.container2.addSubview(self.orangeSquare)
        
        
        // create and add blue-fish.png image to screen
        fish.image = UIImage(named: "blue-fish.png")
        fish.frame = CGRect(x: 50, y: 350, width: 50, height: 50)
        self.view.addSubview(fish)
        // angles in iOS are measured as radians PI is 180 degrees so PI × 2 is 360 degrees
        let fullRotation = CGFloat(M_PI * 2)
        
        UIView.animate(withDuration: 3.0, animations: {
            // animating `transform` allows us to change 2D geometry of the object
            // like `scale`, `rotation` or `translate`
            self.fish.transform = CGAffineTransform(rotationAngle: fullRotation)
        })
        
        
        // loop from 0 to 5
//        for i in 0...5 {
            // first set up an object to animate
            // we'll use a familiar red square
            let square = UIView()
            square.frame = CGRect(x: 55, y: 400, width: 20, height: 20)
            square.backgroundColor = UIColor.red
            
            // add the square to the screen
            self.view.addSubview(square)
            
            // now create a bezier path that defines our curve
            // the animation function needs the curve defined as a CGPath
            // but these are more difficult to work with, so instead
            // we'll create a UIBezierPath, and then create a
            // CGPath from the bezier when we need it
            let path = UIBezierPath()
            path.move(to: CGPoint(x: 16,y: 239))
            path.addCurve(to: CGPoint(x: 301, y: 239), controlPoint1: CGPoint(x: 136, y: 373), controlPoint2: CGPoint(x: 178, y: 110))
            
            // create a new CAKeyframeAnimation that animates the objects position
            let anim = CAKeyframeAnimation(keyPath: "position")
            
            // set the animations path to our bezier curve
            anim.path = path.cgPath
            
            // set some more parameters for the animation
            // this rotation mode means that our object will rotate so that it's parallel to whatever point it is currently on the curve
            anim.rotationMode = kCAAnimationRotateAuto
            anim.repeatCount = Float.infinity
            anim.duration = 5.0
            
            /*// Lets set some more properties to the animation object that adds some randomness to how long the animation take
            // each square will take between 4.0 and 8.0 seconds
            // to complete one animation loop
            anim.duration = Double(arc4random_uniform(40)+30) / 10
            // stagger each animation by a random value
            // `290` was chosen simply by experimentation
            anim.timeOffset = Double(arc4random_uniform(290))*/
            
            // we add the animation to the squares 'layer' property
            square.layer.add(anim, forKey: "animate position along path")
//        }
    }

    
    // MARK : Actions
    @IBAction func animateButtonTapped(sender: AnyObject) {
        
        // create a 'tuple' (a pair or more of objects assigned to a single variable)
        var views : (frontView: UIView, backView: UIView)
        
        if((self.redSquare.superview) != nil){
            views = (frontView: self.redSquare, backView: self.blueSquare)
        }
        else {
            views = (frontView: self.blueSquare, backView: self.redSquare)
        }
        
        
        var transitionOptions = UIViewAnimationOptions.transitionCurlUp
        if self.toggleButton.isSelected == !sender.isSelected {
            transitionOptions = UIViewAnimationOptions.transitionCurlDown
        }
        
        UIView.transition(with: self.container, duration: 1.0, options: transitionOptions, animations: {
            // remove the front object...
            views.frontView.removeFromSuperview()
            
            // ... and add the other object
            self.container.addSubview(views.backView)
            
            }, completion: { finished in
                // any code entered here will be applied
                // .once the animation has completed
        })
    }
    
    
    @IBAction func KeyframeAnimations(_ sender: UIButton) {
        // angles in iOS are measured as radians PI is 180 degrees so PI × 2 is 360 degrees
        let fullRotation = CGFloat(M_PI * 2)
        
        let duration = 2.0
        let delay = 0.0
//        let options = UIViewKeyframeAnimationOptions.calculationModeLinear
        let options = UIViewKeyframeAnimationOptions.calculationModePaced
        
        UIView.animateKeyframes(withDuration: duration, delay: delay, options: options, animations: {
            // each keyframe needs to be added here
            // within each keyframe the relativeStartTime and relativeDuration need to be values between 0.0 and 1.0
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/3, animations: {
                // start at 0.00s (5s × 0)
                // duration 1.67s (5s × 1/3)
                // end at   1.67s (0.00s + 1.67s)
                self.fish.transform = CGAffineTransform(rotationAngle: 1/3 * fullRotation)
            })
            UIView.addKeyframe(withRelativeStartTime: 1/3, relativeDuration: 1/3, animations: {
                self.fish.transform = CGAffineTransform(rotationAngle: 2/3 * fullRotation)
            })
            UIView.addKeyframe(withRelativeStartTime: 2/3, relativeDuration: 1/3, animations: {
                self.fish.transform = CGAffineTransform(rotationAngle: 3/3 * fullRotation)
            })
            
            }, completion: {finished in
                // any code entered here will be applied
                // once the animation has completed
                
            })
    }
    
    
    func transitionAction() {
        // create a 'tuple' (a pair or more of objects assigned to a single variable)
        var views : (frontView: UIView, backView: UIView)
        
        if((self.orangeSquare.superview) != nil){
            views = (frontView: self.orangeSquare, backView: self.purpleSquare)
        }
        else {
            views = (frontView: self.purpleSquare, backView: self.orangeSquare)
        }

        let transitionOptions = UIViewAnimationOptions.transitionFlipFromLeft
        UIView.transition(with: self.container, duration: 1.0, options: transitionOptions, animations: {
            // remove the front object...
            views.frontView.removeFromSuperview()
            
            // ... and add the other object
            self.container2.addSubview(views.backView)
            
            }, completion: { finished in
                // any code entered here will be applied
                // .once the animation has completed
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
