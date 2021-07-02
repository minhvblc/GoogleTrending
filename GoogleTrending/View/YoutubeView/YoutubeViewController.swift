//
//  YoutubeViewController.swift
//  GoogleTrending
//
//  Created by Nguyễn Minh on 28/06/2021.
//

import UIKit
import DropDown
class YoutubeViewController: UIViewController {
    //Model
    var nextPageToken : String?
    var video : [Video]?
    
    //region
    var region : String?
    var regionImage : UIImage?
    var regionName: String?
    
    
    var orderChoice : String?
    
    
    var myPickerView : UIPickerView?
    let dropDown = DropDown()
    let refreshControl = UIRefreshControl()
    var keyWord : String?
    
    //IBOutlet
    @IBOutlet weak var flagImg: UIImageView!
    @IBOutlet weak var dropdownView: UIView!
    @IBOutlet weak var filterLabel: UILabel!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var dropDownBtn: UIButton!
    @IBOutlet weak var regionTF: UITextField!
    @IBOutlet weak var chooseRegionView: UIView!
    @IBOutlet weak var pickerBigView: UIView!
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Observe notify
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(pickRegion), name: Notification.Name("pickedRegion"), object: nil)
        initUI()
        setUp()
        settingDropDown()
    }
    func setUp(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "YoutubeTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        regionTF.addInputViewDatePicker(target: self)
    }
    @IBAction func dropdownBtn(_ sender: Any) {
        dropDown.show()
    }
    func settingDropDown(){
        dropDown.anchorView = dropdownView 
        dropDown.dataSource = orders
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            filterLabel.text = "Order by: " + item
            orderChoice = item
            refresh(nil)
        }
        
        
    }
    
    @objc func refresh(_ sender: AnyObject?) {
        YoutubeService.shared.getData(keyWord: keyWord ?? "", region: region ?? "VN", order: orderChoice ?? Order.relevance.rawValue) { (video) in
            self.nextPageToken = video?.nextPageToken
            self.video = video?.items
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }
    func loadMore(nextPageToken : String) {
        YoutubeService.shared.loadMoreData(keyWord: keyWord ?? "", region: region ?? "VN", order: orderChoice ?? Order.relevance.rawValue, nextPageToken: nextPageToken) { (video) in
            self.nextPageToken = video?.nextPageToken
            if let videos = video?.items{
                self.video?.append(contentsOf: videos)
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.loadingView.isHidden = true
            }
        }
    }
    @objc func pickRegion(_ notification: Notification) {
        if let data = notification.userInfo as? [String: String] {
            for (key, val) in data {
                if(key == "regionCode"){
                    region = val
                }
                else if (key == "image"){
                    self.flagImg.image = UIImage(named: val)
                }
            }
            self.refresh(nil)
        }
    }
    
    
    func initUI(){
        self.loadingView.isHidden = true
        self.chooseRegionView.layer.shadowColor = UIColor.black.cgColor
        self.chooseRegionView.layer.shadowOpacity = 0.5
        self.chooseRegionView.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.chooseRegionView.layer.shadowRadius = 4.0
        if let image = regionImage, let regionName = regionName{
            self.flagImg.image = image
            self.regionTF.text = regionName
        }
        
        tableView.addSubview(refreshControl)
        self.title = "Video"
    }
    
    
}
extension YoutubeViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return video?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! YoutubeTableViewCell
        cell.videoSnippet = video?[indexPath.row].snippet
        cell.initUI()
        
        if video != nil{
            if indexPath.row == self.video!.count-1{
                if let token = self.nextPageToken{
                    self.loadingView.isHidden = false
                    self.loadMore(nextPageToken: token)
                }
                
            }}
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = YoutubePlayViewController()
        vc.videoID = video?[indexPath.row].id?.videoID
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //Animation
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(translationX: 0, y: cell.frame.height)
        UIView.animate(withDuration: 1, delay: 0.05*Double(indexPath.row), usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 0.1, options: .curveEaseInOut) {
            cell.transform = CGAffineTransform(translationX: 0, y: 0)
        }
    }
    
}


