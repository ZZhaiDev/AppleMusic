//
//  ZJViewControllerWhileNavigation.swift
//  Carloudy
//
//  Created by Cognitive AI Technologies on 3/9/18.
//  Copyright © 2018 Acani Inc. All rights reserved.
//

import UIKit
import MediaPlayer


class ZJViewControllerWhileNavigation: UIViewController {
    var mediaPlayer = MPMusicPlayerController.systemMusicPlayer
    var timerToCheckSongs = Timer()
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var imageV: UIImageView!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBAction func playbuttonClicked(_ sender: Any) {
        if mediaPlayer.playbackState == .playing {
            resetSongs()
            mediaPlayer.pause()
            playPauseButton.setImage(UIImage(named: "player_btn_play_normal"), for: .normal)
        } else {
            resetSongs()
            mediaPlayer.play()
            playPauseButton.setImage(UIImage(named: "player_btn_pause_normal"), for: .normal)
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
         timerToCheckSongs = Timer(timeInterval: 1, repeats: true, block: { (_) in
            self.resetSongs()
        })
        RunLoop.current.add(timerToCheckSongs, forMode: .commonModes)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timerToCheckSongs.invalidate()
        
    }
    
    fileprivate func resetSongs(){
        if let item = mediaPlayer.nowPlayingItem{
            if let albumImage = item.artwork?.image(at: CGSize(width: 500, height: 500)){
                imageV.image = albumImage
                if let title = item.title{
                    labelTitle.text = title
                }
            }
        }
    }
    @IBAction func preButtonClicked(_ sender: Any) {
        mediaPlayer.skipToPreviousItem()
        resetSongs()
    }
    @IBAction func nextButtonClicked(_ sender: Any) {
        mediaPlayer.skipToNextItem()
        resetSongs()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        resetSongs()
        if mediaPlayer.playbackState == .playing {
            playPauseButton.setImage(UIImage(named: "player_btn_pause_normal"), for: .normal)
        } else {
            playPauseButton.setImage(UIImage(named: "player_btn_play_normal"), for: .normal)
            mediaPlayer.prepareToPlay()
        }
        imageV.layer.masksToBounds = true
        imageV.layer.cornerRadius = imageV.bounds.size.width/2
         
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

}
