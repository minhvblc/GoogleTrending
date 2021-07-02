//
//  YoutubeTableViewCell.swift
//  GoogleTrending
//
//  Created by Nguyễn Minh on 28/06/2021.
//

import UIKit
import SDWebImage
class YoutubeTableViewCell: UITableViewCell {
    
    //IBoutlet
    @IBOutlet weak var titleVideo: UILabel!
    @IBOutlet weak var chanelTitle: UILabel!
    @IBOutlet weak var bigView: UIView!
    @IBOutlet weak var bigStackView: UIStackView!
    @IBOutlet weak var thumbnailPic: UIImageView!
    @IBOutlet weak var createTime: UILabel!
    
    //Model
    var videoSnippet : Snippet?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func initUI(){
        if let url = URL(string: (videoSnippet?.thumbnails.thumbnailsDefault.url)!){
            thumbnailPic.sd_setImage(with: url, completed: nil)
        }
        bigStackView.spacing = 10
        bigView.layer.cornerRadius = 10
        self.bigView.layer.shadowColor = UIColor.black.cgColor
        self.bigView.layer.shadowOpacity = 0.5
        self.bigView.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.bigView.layer.shadowRadius = 4.0
        titleVideo.text = String(htmlEncodedString: videoSnippet?.title ?? "")
        chanelTitle.text = String(htmlEncodedString: videoSnippet?.channelTitle ?? "")
        let dateCreate = videoSnippet?.publishedAt.stringIntoDate()
        let dateText = dateCreate?.dateIntoString()
        createTime.text = dateText
       
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
