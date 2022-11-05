//
//  ViewController.swift
//  Ejercicio2
//
//  Created by Luis Garcia on 05/11/22.
//

import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    
    @IBOutlet var sliderVolume: UISlider!
    @IBOutlet var btnStop: UIButton!
    @IBOutlet var btnPlay: UIButton!
    @IBOutlet var sliderDuration: UISlider!
    var audioPlayer = AVAudioPlayer()
    var timer:Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        cargarAudio()
        
    }
    
    func cargarAudio(){
        guard let laURL = Bundle.main.url(forResource: "MUSIC3", withExtension: "mp3")
        else{
            print ("Error al cargar archivo")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: laURL)
            inicializaInterfaz()
        }catch{
            print("Ocurrio un error")
        }
        
    }
    
    func inicializaInterfaz(){
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(actualizaSlider), userInfo: nil, repeats: true)
        sliderDuration.value = 0
        sliderDuration.maximumValue = Float(audioPlayer.duration)
        btnStop.isEnabled = false
        btnPlay.isEnabled = true
        audioPlayer.delegate = self
        audioPlayer.volume = 0.5
        sliderVolume.value = 0.5
    }
    
    @objc func actualizaSlider(){
        sliderDuration.value = Float(audioPlayer.currentTime)
    }
    
    @IBAction func btnPlayTouch(_ sender: Any) {
        audioPlayer.play()
        btnStop.isEnabled = true
        btnPlay.isEnabled = false
    }
    
    @IBAction func sliderVolumeChange(_ sender: Any) {
        audioPlayer.volume = sliderVolume.value
    }
    @IBAction func sliderDurationChange(_ sender: Any) {
        audioPlayer.currentTime = Double(sliderDuration.value)
    }
    
    @IBAction func btnStopTouch(_ sender: Any) {
        audioPlayer.stop()
        btnStop.isEnabled = false
        btnPlay.isEnabled = true
    }
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool){
        timer?.invalidate()
        inicializaInterfaz()
        
    }
}

