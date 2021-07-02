//
//  YoutubePlayViewController.swift
//  GoogleTrending
//
//  Created by Nguyễn Minh on 28/06/2021.
//

import UIKit
import youtube_ios_player_helper
class YoutubePlayViewController: UIViewController {
    
    var videoID: String?
    
    //IBoutlet
    @IBOutlet var playerView : YTPlayerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        playerView.delegate = self
        playerView.load(withVideoId: videoID ?? "", playerVars: ["playsinline": 1])
    }

}
extension YoutubePlayViewController: YTPlayerViewDelegate{
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        playerView.playVideo()
    }
}
