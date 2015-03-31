//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Kian Chuan Ang on 17/3/15.
//  Copyright (c) 2015 kcology. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    var audioPlayer = AVAudioPlayer()
    var audioPlayer2 = AVAudioPlayer()
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    @IBOutlet weak var btnStop: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnStop.hidden = true

        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error:  nil)
        audioPlayer2 = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func playSlowSound(sender: UIButton) {
        playAudio(0.5)
        btnStop.hidden = false
    }
    
    @IBAction func playFastSound(sender: UIButton) {
        playAudio(1.5)
        btnStop.hidden = false
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000)
        btnStop.hidden = false
    }
    
    @IBAction func playVaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
        btnStop.hidden = false
    }
    
    @IBAction func playReverbAudio(sender: UIButton) {
        playAudioWithVariableReverb(0.0)
        btnStop.hidden = false
    }
    
    
    @IBAction func playEchoAudio(sender: AnyObject) {
        stopPlayingAudio()
        
        let delay:NSTimeInterval = 0.1
        var playtime:NSTimeInterval = audioPlayer2.deviceCurrentTime + delay
        
        audioPlayer2.stop()
        audioPlayer2.currentTime = 0
        audioPlayer2.volume = 0.7;
        audioPlayer2.playAtTime(playtime)
    }
    
    func playAudioWithVariableReverb(reverb: Float){
        stopPlayingAudio()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var reverbEffect = AVAudioUnitReverb()
        reverbEffect.wetDryMix = reverb
        audioEngine.attachNode(reverbEffect)
        
        audioEngine.connect(audioPlayerNode, to: reverbEffect, format: nil)
        audioEngine.connect(reverbEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
        
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        stopPlayingAudio()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    
    func playAudio(rate: Float){
        stopPlayingAudio()
        
        audioPlayer.rate = rate
        audioPlayer.play()
    }
    
    @IBAction func stopAudio(sender: UIButton) {
        stopPlayingAudio()
        btnStop.hidden = true
        
    }
    
    func stopPlayingAudio(){
        audioPlayer.stop()
        audioPlayer.currentTime = 0.0
        
        audioEngine.stop()
        audioEngine.reset()
        
    }
}
