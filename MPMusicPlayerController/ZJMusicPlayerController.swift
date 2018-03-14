//
//  ZJMusicPlayerController.swift
//  ZJMusicPlayerController

//  Copyright © 2018 zijia. All rights reserved.
//

import UIKit
import MediaPlayer

class ZJMusicPlayerController: UIViewController {
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    // MARK: - Properties
    
    var mediaPlayer = MPMusicPlayerController.systemMusicPlayer
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var artImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var playPauseButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        artImageView.layer.cornerRadius = artImageView.frame.width/2
        artImageView.layer.masksToBounds = true
        artImageView.layer.borderColor = UIColor.lightGray.cgColor
        artImageView.layer.borderWidth = 8
        beginAnimation()
    }
    
    func beginAnimation(){
        artImageView.layer.removeAllAnimations()
        let animation = CABasicAnimation()
        animation.fromValue = 0
        animation.toValue = Double.pi * 2
        animation.duration = 30
        animation.keyPath = "transform.rotation.z"
        animation.repeatCount = Float(CGFloat.greatestFiniteMagnitude)
        animation.isRemovedOnCompletion = false
        artImageView.layer.add(animation, forKey: "rotation")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        artImageView.image = UIImage(named: "Music-icon")
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "stars.png")!)
        resetImageAndSongTitle()
        if mediaPlayer.playbackState == .playing {
            playPauseButton.setImage(UIImage(named: "player_btn_pause_normal"), for: .normal)
        } else {
            playPauseButton.setImage(UIImage(named: "player_btn_play_normal"), for: .normal)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 
    
    func resetImageAndSongTitle(){
        if let item = mediaPlayer.nowPlayingItem{
            if let albumImage = item.artwork?.image(at: CGSize(width: 500, height: 500)){
                artImageView.image = albumImage
                if let title = item.title{
                    titleLabel.text = title
                }
            }
        }
    }
    @IBAction func nextMusicClick(_ sender: Any) {
        mediaPlayer.skipToNextItem()
        resetImageAndSongTitle()
    }
    @IBAction func previousMusicClick(_ sender: Any) {
        mediaPlayer.skipToPreviousItem()
        resetImageAndSongTitle()
    }
    
    
  
    
    func mediaPickerDidCancel(_ mediaPicker: MPMediaPickerController) {
        mediaPicker.dismiss(animated: true, completion: nil)
    }
    
 
    
    func playItem(item: MPMediaItem) {
        
        if let albumImage = item.artwork?.image(at: CGSize(width: 500, height: 500)){
            artImageView.image = albumImage
            if let title = item.title{
                titleLabel.text = title
            }
        }
        mediaPlayer.setQueue(with: MPMediaItemCollection(items: [item]))
        mediaPlayer.play()
        playPauseButton.setImage(UIImage(named: "player_btn_pause_normal"), for: .normal)
        if mediaPlayer.playbackState == .playing {
            playPauseButton.setImage(UIImage(named: "player_btn_pause_normal"), for: .normal)
        } else {
            playPauseButton.setImage(UIImage(named: "player_btn_play_normal"), for: .normal)
            
        }
        
    }
    
    @IBAction func playPauseTapped(_ sender: Any) {
        if mediaPlayer.playbackState == .playing {
            mediaPlayer.pause()
            playPauseButton.setImage(UIImage(named: "player_btn_play_normal"), for: .normal)
        } else {
            mediaPlayer.play()
            playPauseButton.setImage(UIImage(named: "player_btn_pause_normal"), for: .normal)
        }
    }
      
}
