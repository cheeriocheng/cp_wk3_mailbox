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
    @IBOutlet weak var rescheduleView: UIView!
    @IBOutlet weak var feedImageView: UIImageView!
    
    var singleMessageTrayOriginalCenter: CGPoint!
    var rightIconsOriginalCenter: CGPoint!
    var leftIconsOriginalCenter: CGPoint!
    
    @IBOutlet weak var archiveIcon: UIImageView!
    @IBOutlet weak var deleteIcon: UIImageView!
    @IBOutlet weak var laterIcon: UIImageView!
    @IBOutlet weak var listIcon: UIImageView!
    
    @IBOutlet weak var rightIconsView: UIView!
    @IBOutlet weak var leftIconsView: UIView!
    @IBOutlet weak var panBG: UIView!
    
    @IBOutlet var mainScreenPan: UIScreenEdgePanGestureRecognizer!
    
    @IBOutlet weak var mainView: UIView!
    var mainViewOriginalCenter: CGPoint!
    
    var endState  = 0
    let list = 1
    let later = 2
    let archive = 3
    let delete = 4
    
    
    let myYellowColor = UIColor(
        red:248/256,
        green:204/256,
        blue:40/256,
        alpha:1.0)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize = CGSize(width: 320, height: 1400)
        singleMessageTrayOriginalCenter = singleMessageTrayView.center
        rightIconsOriginalCenter = rightIconsView.center
        leftIconsOriginalCenter = leftIconsView.center
        mainViewOriginalCenter = mainView.center
        
        mainScreenPan = UIScreenEdgePanGestureRecognizer(target: self, action: "onEdgePan:")
        mainScreenPan.edges = UIRectEdge.Left
        view.addGestureRecognizer(mainScreenPan)
        
        
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
            
            //trigger the next step
            if (endState == later){
                print("show reschedule view ")
                UIView.animateWithDuration(0.4) { () -> Void in
                    self.rescheduleView.alpha =  1
                }
                
                
            }else {
                
                //upon releasing, return to original position
                resetVisuals()
                
                
            }
            
            
            
        }
        
    }
    
    func changePanVisual( dx: CGFloat ){
        // print(dx)
        
        // list icon, brown bg
        if (dx < -260 ){
            panBG.backgroundColor = UIColor.brownColor()
            rightIconsView.center.x = rightIconsOriginalCenter.x + 60 + dx
            laterIcon.alpha = 0
            listIcon.alpha = 1
            endState = list
        }
            //later icon moves with the message, yellow bg
        else if (dx < -60){
            panBG.backgroundColor = myYellowColor
            rightIconsView.center.x = rightIconsOriginalCenter.x + 60 + dx
            laterIcon.alpha = 1
            listIcon.alpha = 0
            endState = later
        }
            //start to show later icon, grey bg
        else if (dx < 0 ){
            panBG.backgroundColor = UIColor.lightGrayColor()
            
            //later icon alpha transition from 0 to 1
            laterIcon.alpha = dx/(-60)
            
            
        }
            // start to show archive icon, grey bg
        else if (dx < 60 ){
            panBG.backgroundColor = UIColor.lightGrayColor()
            
            archiveIcon.alpha = dx/60
        }
            //show archive icon, green bg
        else if (dx < 260){
            archiveIcon.alpha = 1
            leftIconsView.center.x = leftIconsOriginalCenter.x - 60 + dx
            deleteIcon.alpha = 0
            panBG.backgroundColor = UIColor.greenColor()
            endState = archive
            
        }
            // show delete icon, red bg
        else {
            deleteIcon.alpha = 1
            archiveIcon.alpha = 0
            leftIconsView.center.x = leftIconsOriginalCenter.x - 60 + dx
            panBG.backgroundColor = UIColor.redColor()
            endState = delete
            
        }
    }
    
    
    //initalize all icons to be transparent
    //and background to be grey
    func resetVisuals(){
        //TODO add animation
        singleMessageTrayView.center = singleMessageTrayOriginalCenter
        rightIconsView.center = rightIconsOriginalCenter
        leftIconsView.center = leftIconsOriginalCenter
        
        archiveIcon.alpha =  0
        deleteIcon.alpha = 0
        laterIcon.alpha = 0
        listIcon.alpha = 0
        
        panBG.backgroundColor = UIColor.lightGrayColor()
        
        rightIconsView.center =         rightIconsOriginalCenter
        leftIconsView.center =    leftIconsOriginalCenter
        
        endState  = 0
        
        rescheduleView.alpha =  0
    }
    
    @IBAction func didTapRescheduleView(sender: UITapGestureRecognizer) {
        print("tap")
        //disappear
        UIView.animateWithDuration(0.3) { () -> Void in
            self.rescheduleView.alpha =  0
        }
     
        //move the feed up
        UIView.animateWithDuration(0.6) { () -> Void in
            self.feedImageView.center.y  = self.feedImageView.center.y  - 86
        }
        
        
    }
    
    
    @IBAction func didScreenEdgePan(sender: UIScreenEdgePanGestureRecognizer) {
        print("didScreenEdgePan")
        //yea whatever. this is never called .
    }
    
    func onEdgePan(panGestureRecognizer: UIScreenEdgePanGestureRecognizer){
         print("onedgepan")

//        let point = panGestureRecognizer.locationInView(view) //the finger position
        
        let translation = panGestureRecognizer.translationInView(view) //the relavent movement
        
        
        
        if panGestureRecognizer.state == UIGestureRecognizerState.Began {
            
//            print("Gesture began at: \(point)")
            
            
            
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Changed {
            
//            print("Gesture changed at: \(point)")
            
           mainView.center.x = mainViewOriginalCenter.x + translation.x
            
            
            
        }
            
        else if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
            print("Gesture ended at ", mainView.center.x, "moved ",mainView.center.x - mainViewOriginalCenter.x )
            let w = UIScreen.mainScreen().bounds.width
            
            //snap to left 
            if (mainView.center.x - mainViewOriginalCenter.x < w/2.0){
                 mainView.center.x = mainViewOriginalCenter.x
            }
            
            //snap to right
            else {
                mainView.center.x = mainViewOriginalCenter.x + w + 20
            }
            

            
        }
        
        
        
        
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
