//
//  MailboxViewController.swift
//  cp_3_mailbox
//
//  Created by Xu, Cheng on 11/14/15.
//  Copyright © 2015 sansserif. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController {
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var singleMessageTrayView: UIView!
    var singleMessageTrayOriginalCenter: CGPoint!
    
    @IBOutlet weak var archiveIcon: UIImageView!
    @IBOutlet weak var deleteIcon: UIImageView!
    @IBOutlet weak var laterIcon: UIImageView!
    @IBOutlet weak var listIcon: UIImageView!
    
    @IBOutlet weak var rightIconsView: UIView!
    @IBOutlet weak var leftIconsView: UIView!
    @IBOutlet weak var panBG: UIView!
    
    var endState  = 0
    
    
    let myYellowColor = UIColor(
        red:248/256,
        green:204/256,
        blue:40/256,
        alpha:1.0)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize = CGSize(width: 320, height: 1400)
        singleMessageTrayOriginalCenter = singleMessageTrayView.center
        
        resetVisuals()
        
    }
    
    @IBAction func didPanSingleMessage(panGestureRecognizer: UIPanGestureRecognizer) {
        //let point = panGestureRecognizer.locationInView(view) //the finger position
        let translation = panGestureRecognizer.translationInView(view) //the relavent movement
        
        
        
        if panGestureRecognizer.state == UIGestureRecognizerState.Began {
           // print("Gesture began at: \(point)")
            
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Changed {
            //print("Gesture changed at: \(point)")
            let newCenterX = singleMessageTrayOriginalCenter.x + translation.x
            singleMessageTrayView.center = CGPoint(x: newCenterX, y: singleMessageTrayOriginalCenter.y)

            //change the look underneath
            changePanVisual( translation.x )
        }
        else if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
            //print("Gesture ended at: \(point)")
            
           print("endstate ", endState)

            
            
            //upon releasing, return to original position
            
            
            resetVisuals()

            
        }
        
    }
    
    func changePanVisual( dx: CGFloat ){
       // print(dx)
        
        // list icon, brown bg
        if (dx < -260 ){
            panBG.backgroundColor = UIColor.brownColor()
            laterIcon.alpha = 0
            listIcon.alpha = 1 
            endState = 1
        }
        //later icon, yellow bg
        else if (dx < -60){
             panBG.backgroundColor = myYellowColor
            
        }
        //start to show later icon, grey bg
        else if (dx < 0 ){
            let f = dx/(-60)

            //later icon alpha transition from 0 to 1
            laterIcon.alpha = f
            
        }
        // archive 
        else if (dx > 60 ){
            
        }
        //delte 
        else if (dx > 260){
            
        }
    }
    
    
    //initalize all icons to be transparent
    //and background to be grey
    func resetVisuals(){
        //TODO add animation
        singleMessageTrayView.center = singleMessageTrayOriginalCenter
    
        archiveIcon.alpha =  0
        deleteIcon.alpha = 0
        laterIcon.alpha = 0
        listIcon.alpha = 0
        
        panBG.backgroundColor = UIColor.lightGrayColor()
//        leftIconsView.backgroundColor = UIColor.lightGrayColor()
//        rightIconsView.backgroundColor = UIColor.lightGrayColor()

        
        
        endState  = 0
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
