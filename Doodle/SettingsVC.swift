//
//  SettingsVC.swift
//  Doodle
//
//  Created by Terrell Robinson on 11/15/16.
//  Copyright © 2016 FlyGoody. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {
    
    
    @IBOutlet weak var brushImage: UIImageView!
    @IBOutlet weak var brushSizeLabel: UILabel!
    @IBOutlet weak var brushSizeSlider: UISlider!
    
    @IBOutlet weak var opacityLabel: UILabel!
    @IBOutlet weak var opacitySlider: UISlider!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    var delegate: SettingsVCDelegate?
    
    var red: CGFloat = 0.0
    var green: CGFloat = 0.0
    var blue: CGFloat = 0.0
    
    var brush: CGFloat = 10.00
    var opacity: CGFloat = 1.0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        brushSizeSlider.value = Float(brush)
        brushSizeLabel.text = String(format: "Brush Size: %.2f", brush.native) as String
        
        opacitySlider.value = Float(opacity)
        opacityLabel.text = String(format: "Opacity: %.1f", opacity.native) as String
        
        redSlider.value = Float(red * 255.0)
        redLabel.text = String(format: "%d", Int(redSlider.value)) as String
        
        greenSlider.value = Float(green * 255.0)
        greenLabel.text = String(format: "%d", Int(greenSlider.value)) as String
        
        blueSlider.value = Float(blue * 255.0)
        blueLabel.text = String(format: "%d", Int(blueSlider.value)) as String

    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        drawPreview()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func closeButtonPressed(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        self.delegate?.settingsViewControllerFinished(self)
        
    }
   
    
    @IBAction func brushSizeSliderChanged(_ sender: Any) {
        
        brush = CGFloat(brushSizeSlider.value)
        brushSizeLabel.text = String(format: "Brush Size: %.2f", brush.native) as String // 2 in "2f" = numbers after decimal
        
        drawPreview()
        
    }
    
    
    @IBAction func opacitySliderChanged(_ sender: Any) {
        
        opacity = CGFloat(opacitySlider.value)
        opacityLabel.text = String(format: "Opacity: %.1f", opacity.native) as String
        
        drawPreview()
        
    }
    
    
    @IBAction func redSliderChanged(_ sender: Any) {
        
        red = CGFloat(redSlider.value / 255)
        redLabel.text = String(format: "%d", Int(redSlider.value)) as String
        drawPreview()
        
    }
    
    @IBAction func greenSliderChanged(_ sender: Any) {
        
        green = CGFloat(greenSlider.value / 255)
        greenLabel.text = String(format: "%d", Int(greenSlider.value)) as String
        drawPreview()
        
        
    }
    
    @IBAction func blueSliderChanged(_ sender: Any) {
        
        blue = CGFloat(blueSlider.value / 255)
        blueLabel.text = String(format: "%d", Int(blueSlider.value)) as String
        drawPreview()
        
    }
    
    
    func drawPreview() {
        
        UIGraphicsBeginImageContext(brushImage.frame.size)
        let context = UIGraphicsGetCurrentContext()
        
        context?.setLineCap(CGLineCap.round)
        context?.setLineWidth(brush)
        
        context?.setStrokeColor(red: red, green: green, blue: blue, alpha: opacity)
        context?.move(to: CGPoint(x: 90.0, y: 90.0))
        context?.addLine(to: CGPoint(x: 90.0, y: 90.0)) // Places the dot in the middle of the image view
        context?.strokePath() // Now we can visually see it in the screen
        
        brushImage.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        brushImage.backgroundColor = UIColor(patternImage: UIImage(named: "brushBackground.png")!) // Makes the UIImage background the brushBackground
        
        
        
        
    }
    
    
    

}
