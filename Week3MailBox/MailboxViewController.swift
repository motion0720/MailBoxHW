//
//  MailboxViewController.swift
//  Week3MailBox
//
//  Created by SHEN, MENGNAN on 10/10/16.
//  Copyright © 2016 SHEN, MENGNAN. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var mailScrollView: UIScrollView!
    @IBOutlet weak var laterImageView: UIImageView!
    @IBOutlet weak var archiveImageView: UIImageView!
    @IBOutlet weak var messageImageView: UIImageView!
    
    @IBOutlet weak var rescheduleImageView: UIImageView!
    @IBOutlet weak var listImageView: UIImageView!
    @IBOutlet weak var backgroundColorView: UIView!
    @IBOutlet weak var feedImageView: UIImageView!
    
    var laterImageCenter: CGPoint!
    var archiveImageCenter: CGPoint!
    var messageImageCenter: CGPoint!
    
    let greyBackgroud = UIColor(red: 0.89, green: 0.88, blue: 0.89, alpha: 1)
    
    let yellowBackground = UIColor(red: 0.98, green: 0.82, blue: 0.20, alpha: 1)
    let greenBackground = UIColor(red: 0.44, green: 0.85, blue: 0.38, alpha: 1)
    let redBackground = UIColor(red: 0.92, green: 0.33, blue: 0.20, alpha: 1)
    let whiskyBackground = UIColor(red: 0.85, green: 0.65, blue: 0.46, alpha: 1)
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mailScrollView.delegate = self
        
        rescheduleImageView.alpha = 0
        listImageView.alpha = 0
        
        messageImageView.isUserInteractionEnabled = true
        
        mailScrollView.contentSize = CGSize(width: 320, height: 1500)
       
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func didPan(_ sender: UIPanGestureRecognizer) {
       
        //let location = sender.location(in: view)
        //let velocity = sender.velocity(in: view)
        let translation = sender.translation(in: view)
        
        if sender.state == .began {
            laterImageView.alpha = 0
            archiveImageView.alpha = 0
            
            messageImageCenter = messageImageView.center
            laterImageCenter = laterImageView.center
            archiveImageCenter = archiveImageView.center
            
            
        } else if sender.state == .changed {
            messageImageView.center = CGPoint(x: messageImageCenter.x + translation.x, y: messageImageCenter.y)
            
            if translation.x > -60 && translation.x < 0 {
                backgroundColorView.backgroundColor = greyBackgroud
                UIView.animate(withDuration: 0.5, animations: {
                    self.laterImageView.alpha = 1
                })

                //laterImageView.alpha = 1
            }
            
            
            else if translation.x < -60 && translation.x > -260{
                backgroundColorView.backgroundColor = yellowBackground
                archiveImageView.alpha = 0
                laterImageView.center.x = laterImageCenter.x +
                translation.x + 60
            }
            
            else if translation.x < -260 {
                backgroundColorView.backgroundColor = whiskyBackground
                laterImageView.image = UIImage(named: "list_icon.png")
                archiveImageView.alpha = 0
                laterImageView.center.x = laterImageCenter.x +
                    translation.x + 60
            }
            
                
            else if translation.x < 60 && translation.x > 0 {
                backgroundColorView.backgroundColor = greyBackgroud
                UIView.animate(withDuration: 0.5, animations: {
                    self.archiveImageView.alpha = 1
                })
                //archiveImageView.alpha = 1
            }
            
            else if translation.x > 60 && translation.x < 260 {
                backgroundColorView.backgroundColor = greenBackground
                laterImageView.alpha = 0
                archiveImageView.center.x = archiveImageCenter.x + translation.x - 60
            }
            
            else if translation.x > 260 {
                backgroundColorView.backgroundColor = redBackground
                archiveImageView.image = UIImage(named: "delete_icon.png")
                archiveImageView.center.x = archiveImageCenter.x + translation.x - 60
            }
            
            
        } else if sender.state == .ended {
            
         
            if translation.x < -60 && translation.x > -260{
                UIView.animate(withDuration: 0.5, animations: {                    self.messageImageView.frame.origin.x = -320
                    self.laterImageView.frame.origin.x = -320
                    }, completion: {(finished: Bool) -> Void in
                        self.rescheduleImageView.alpha = 1
                        self.listImageView.alpha = 0
                })
            }
                
            else if translation.x > -60 && translation.x < 0{
                
                UIView.animate(withDuration: 0.5, animations: {                    self.messageImageView.frame.origin.x = 0
                    //self.laterImageView.center.x = self.laterImageCenter.x
                    }, completion: {(finished: Bool) -> Void in
                    
                })
            }
            
            else if translation.x < -260{
                UIView.animate(withDuration: 0.5, animations: {                    self.messageImageView.frame.origin.x = -320
                    self.laterImageView.frame.origin.x = -320
                    }, completion: {(finished: Bool) -> Void in
                        self.listImageView.alpha = 1
                        self.rescheduleImageView.alpha = 0
                })
            }
            
                
            else if translation.x < 60 && translation.x > 0{
                
                UIView.animate(withDuration: 0.5, animations: {                    self.messageImageView.frame.origin.x = 0
                    //self.archiveImageView.frame.origin.x = self.archiveImageCenter.x
                    }, completion: {(finished: Bool) -> Void in
                        
                })
            }
            
            else if translation.x > 60 && translation.x < 260{
                UIView.animate(withDuration: 0.7, animations: {                    self.messageImageView.frame.origin.x = 320
                    self.archiveImageView.frame.origin.x = 320
                    }, completion: {(finished: Bool) -> Void in
                        self.feedImageView.frame.origin.y = 74                })
            }
            
            else if translation.x > 260{
                UIView.animate(withDuration: 0.7, animations: {                    self.messageImageView.frame.origin.x = 320
                    self.archiveImageView.frame.origin.x = 320
                    }, completion: {(finished: Bool) -> Void in
                        self.feedImageView.frame.origin.y = 74                })
            }

        }
    }

    @IBAction func didTap(_ sender: UITapGestureRecognizer) {
        
        rescheduleImageView.alpha = 0
        //messageImageView.center.x = messageImageCenter.x
        //laterImageView.center.x = laterImageCenter.x
        
        UIView.animate(withDuration: 0.5, animations: {
             self.feedImageView.frame.origin.y = 74
            }, completion: {(finished: Bool) -> Void in
                             })
        
    }
    
    @IBAction func didTapList(_ sender: UITapGestureRecognizer) {
        listImageView.alpha = 0
        //messageImageView.center.x = messageImageCenter.x
        //laterImageView.center.x = laterImageCenter.x
        
        UIView.animate(withDuration: 0.5, animations: {
            self.feedImageView.frame.origin.y = 74
            }, completion: {(finished: Bool) -> Void in
        })
        
    }
    
    @IBAction func clickonButton(_ sender: UIButton) {
        self.feedImageView.frame.origin.y = 160
        messageImageView.center.x = messageImageCenter.x
        laterImageView.center.x = laterImageCenter.x
        archiveImageView.center.x = archiveImageCenter.x
        laterImageView.image = UIImage(named: "later_icon.png")
        archiveImageView.image = UIImage(named: "archive_icon.png")

        
    }
}
