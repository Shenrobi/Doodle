//
//  ViewController.swift
//  Doodle
//
//  Created by Terrell Robinson on 11/15/16.
//  Copyright © 2016 FlyGoody. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var opacityImageView: UIImageView!
    
    var lastPoint = CGPoint.zero
    var swiped = false
    
    var red: CGFloat = 0.0
    var green: CGFloat = 0.0
    var blue: CGFloat = 0.0
    
    var brushWidth: CGFloat = 10.0
    var opacity: CGFloat = 1.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Helper Methods
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        swiped = false
        
        if let touch = touches.first as UITouch! {
            
            lastPoint = touch.location(in: self.view)
            
        }
    }

    
    func drawLine(_ fromPoint: CGPoint, toPoint: CGPoint) {
        
        UIGraphicsBeginImageContext(view.frame.size)
        
        let context = UIGraphicsGetCurrentContext() // will reference the remainder of the func
        opacityImageView.image?.draw(in: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
        
        context?.move(to: CGPoint(x: fromPoint.x, y: fromPoint.y)) // moving from the point when we move our finger
        context?.addLine(to: CGPoint(x: toPoint.x, y: toPoint.y)) // moving to the point when we move our finger
        
        // Setting the line cap
        
        context?.setLineCap(CGLineCap.round) // Sets the cap of the drawing (circle)
        context?.setLineWidth(brushWidth)
        context?.setStrokeColor(red: red, green: green, blue: blue, alpha: opacity) // Starts off as black
        context?.setBlendMode(CGBlendMode.normal)
        
        context?.strokePath()
        
        opacityImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        opacityImageView.alpha = opacity
        UIGraphicsEndImageContext()
        
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        swiped = true // swiping the screen
        
        if let touch = touches.first as UITouch! {
            
            let currentPoint = touch.location(in: view)
            drawLine(lastPoint, toPoint: currentPoint)
            
            lastPoint = currentPoint // When our finger moves to the next point, our current point becomes our last point. Allows us to continue to draw new points
            
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if !swiped {
            
            drawLine(lastPoint, toPoint: lastPoint) // Drawing stops once the user takes their finger off the screen.
            
        }
        
        // Merge Second Image View into the First One
        
        UIGraphicsBeginImageContext(opacityImageView.frame.size)
        
        imageView.image?.draw(in: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), blendMode: CGBlendMode.normal, alpha: 1.0)
        opacityImageView.image?.draw(in: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), blendMode: CGBlendMode.normal, alpha: opacity)
        
        imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        opacityImageView.image = nil // Merged and then cleared the image view
        
    }
    
    
    @IBAction func resetButtonPressed(_ sender: Any) {
        
        imageView.image = nil // Cleans the imageView
        
    }
    
    
    @IBAction func settingsButtonPressed(_ sender: Any) {
        
        
    }
    
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        
        UIGraphicsBeginImageContext(imageView.bounds.size)
        imageView.image?.draw(in: CGRect(x: 0, y: 0, width: imageView.frame.size.width, height: imageView.frame.size.height))
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext() // stores the image in the variable of image
        
        let activity = UIActivityViewController(activityItems: [image!], applicationActivities: nil)
        
        present(activity, animated: true, completion: nil)
        
        
        
        
        
    }
    
    
    @IBAction func redButtonPressed(_ sender: Any) {
        
        (red, green, blue) = (255, 0, 0)
        
    }
    
    
    @IBAction func greenButtonPressed(_ sender: Any) {
        
        (red, green, blue) = (0, 255, 0)
        
    }
    
    
    @IBAction func blueButtonPressed(_ sender: Any) {
        
        (red, green, blue) = (0, 0, 255)
        
    }
    
    
    @IBAction func yellowButtonPressed(_ sender: Any) {
        
        (red, green, blue) = (255, 255, 0)
        
    }
    
    
    @IBAction func pinkButtonPressed(_ sender: Any) {
        
        (red, green, blue) = (255, 0, 255)
        
    }
    
    
    @IBAction func tealButtonPressed(_ sender: Any) {
        
        (red, green, blue) = (0, 255, 255)
        
    }
    
    
    @IBAction func whiteButtonPressed(_ sender: Any) {
        
        (red, green, blue) = (255, 255, 255)
        
    }
    
    
    
    @IBAction func blackButtonPressed(_ sender: Any) {
        
        (red, green, blue) = (0, 0, 0)
        
    }
    
    // Saving Settings from the SettingsVC
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let settingsViewController = segue.destination as! SettingsVC
        settingsViewController.delegate = self
        settingsViewController.red = red
        settingsViewController.green = green
        settingsViewController.blue = blue
        
        settingsViewController.brush = brushWidth
        settingsViewController.opacity = opacity
        
    }
    
}

extension ViewController: SettingsVCDelegate {
    
    func settingsViewControllerFinished(_ settingsViewController: SettingsVC) {
        
        self.brushWidth = settingsViewController.brush
        self.opacity = settingsViewController.opacity
        self.red = settingsViewController.red
        self.green = settingsViewController.green
        self.blue = settingsViewController.blue
        
        
    }
    
    
}


















