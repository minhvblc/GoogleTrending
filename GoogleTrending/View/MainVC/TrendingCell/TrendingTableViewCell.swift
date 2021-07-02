//
//  TrendingTableViewCell.swift
//  GoogleTrending
//
//  Created by Nguyễn Minh on 26/06/2021.
//

import UIKit
import SDWebImage

class TrendingTableViewCell: UITableViewCell {
    //Modedl
    var trend : Trend?
    var videos: VideoData?
    var regionCode : String?
    
    
    //get youtube data when fetching
    var youTubeClosure :  ((VideoData)->Void)?
    
    //super viewcotroller handle loading animaion
    var loading : (()->Void)?
    
    //super viewcotroller handle when fetching fail
    var error : (()->Void)?
    
    
    
    //IBoutlet
    @IBOutlet weak var pubDate: UILabel!
    @IBOutlet weak var traffic: UILabel!
    @IBOutlet weak var hoursAgo: UILabel!
    @IBOutlet weak var bigView: UIView!
    @IBOutlet weak var youTubeButton: UIButton!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var imageTrend: UIImageView!
    
    
    
    @IBAction func youTube(_ sender: UIButton) {
        loading?()
        let queue = DispatchQueue(label: "loadData", qos: .userInitiated)
        queue.async {
            let dispatchGroup = DispatchGroup()
            dispatchGroup.enter()
            YoutubeService.shared.getData(keyWord: self.trend?.title ?? "", region: self.regionCode ?? "VN", order: Order.relevance.rawValue){ video in
                self.videos = video
                dispatchGroup.leave()
            }
            dispatchGroup.notify(queue: queue) {
                if let video = self.videos{
                    DispatchQueue.main.async {
                        self.youTubeClosure?(video)
                    }
                    
                }
                else{
                    DispatchQueue.main.async {
                        self.error?()
                    }
                }
            }
            
        }
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    
    func initUI(){
        if let stringURL = trend?.pictureURL{
            if let url = URL(string: stringURL){
                imageTrend.sd_setImage(with: url, completed: nil)
            }
        }
        
        bigView.layer.cornerRadius = 10
        self.bigView.layer.shadowColor = UIColor.black.cgColor
        self.bigView.layer.shadowOpacity = 0.5
        self.bigView.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.bigView.layer.shadowRadius = 4.0
        if trend?.pudDate?.dateIntoString() == ""{
            pubDate.text = ""
        } else{
            pubDate.text = trend?.pudDate?.dateIntoString()
        }
        hoursAgo.text =  trend?.pudDate?.calHourBetweenDateAndNowToString()
        title.text =  String(htmlEncodedString: (trend?.title)!)
        youTubeButton.imageView?.contentMode = .scaleAspectFit
        traffic.text = String(htmlEncodedString: (trend?.traffic)!)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
