//
//  ViewController.swift
//  audiokit_testing
//
//  Created by Gallagher, Matthew on 11/29/16.
//  Copyright © 2016 Gallagher, Matthew. All rights reserved.
//

import UIKit
import AudioKit
import CoreMotion

class ViewController: UIViewController {

    var oscillator = AKOscillator()
    @IBOutlet var toggleButton : UIButton?
    @IBOutlet var freqSlider : UISlider?
    @IBOutlet var tapRecognizer : UITapGestureRecognizer?
    @IBOutlet var tapView : UIView?
    
    var motionManager = CMMotionManager()
    
    override func viewDidLoad() {
        
        let fileName = try? AKAudioFile(readFileName: "cheeb-snr.wav", baseDir: .resources)
        let player = fileName?.player
        
        super.viewDidLoad()
        
        //AudioKit.output = oscillator
        //AudioKit.start()
        motionManager.accelerometerUpdateInterval = 0.05
        motionManager.deviceMotionUpdateInterval = 0.05
        
            
            AudioKit.output = player!
            AudioKit.start()
            
            
        

        
        
       /* motionManager.startAccelerometerUpdates(to: OperationQueue.current!, withHandler: {(accelerometerData: CMAccelerometer?, error: Error?) -> Void
            in
            self.playAccelerometerSound(acceleration: accelerometerData!.acceleration)
            if(error != nil){
                print("\(error)")
            }
            
            })
        */
        motionManager.startDeviceMotionUpdates(to: OperationQueue.current!, withHandler: {(deviceMotionData: CMDeviceMotion?, error: Error?) -> Void
            in
            self.playAccelerometerSound(acceleration: deviceMotionData!.userAcceleration, AKPlayer: player)
            if(error != nil){
                print("\(error)")
            }
            
        })
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func toggleSound(_ sender: UIButton) {
        if oscillator.isPlaying {
            oscillator.stop()
            sender.setTitle("Play Sine Wave", for: .normal)
        } else {
            oscillator.amplitude = random(0.5, 1)
            oscillator.frequency = Double((freqSlider?.value)!)
            oscillator.start()
            sender.setTitle("Stop Sine Wave at \(Int(oscillator.frequency))Hz", for: .normal)
        }
    }
    
    @IBAction func changeFreq() {
        oscillator.frequency = Double((freqSlider?.value)!)
        toggleButton?.setTitle("Stop Sine Wave at \(Int(oscillator.frequency))Hz", for: .normal)
    }
    
    @IBAction func recognizeTap() {
        let location = (tapRecognizer?.location(in: tapView))
        let newFreq = ((Double((location?.x)!)*3)+220.0)
        oscillator.frequency = newFreq as Double
        
        toggleButton?.setTitle("Stop Sine Wave at \(Int(oscillator.frequency))Hz", for: .normal)

    }
    
    func playAccelerometerSound(acceleration: CMAcceleration, AKPlayer: AKAudioPlayer?){
        //print(acceleration.y)
        if(acceleration.y > 0.8){
            
            
            
            AKPlayer!.start()
            
            
            //let file = Bundle.main.path(forResource: "cheeb-snr", ofType: "wav")
            
            
            }
    }

}

