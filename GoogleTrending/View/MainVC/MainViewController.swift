//
//  MainViewController.swift
//  GoogleTrending
//
//  Created by Nguyễn Minh on 26/06/2021.
//

import UIKit
import Alamofire
import SWXMLHash
class MainViewController: UIViewController {
    //Model
    var trends : [Trend]?
    
    //Region data
    var regionName: String = "Vietnam"
    var regionCode : String =  "VN"
    let refreshControl = UIRefreshControl()
    
    //IBOutlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var regionView: UIView!
    @IBOutlet weak var regionTF: UITextField!
    @IBOutlet weak var rgionImg: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        setUp()
        //observe noti
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(pickRegion), name: Notification.Name("pickedRegion"), object: nil)
    }
    func setUp(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TrendingTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
        regionTF.addInputViewDatePicker(target: self)
    }
    @objc func pickRegion(_ notification: Notification) {
        if let data = notification.userInfo as? [String: String] {
            for (key, val) in data {
                if(key == "regionCode"){
                    regionCode = val
                    print(val)
                }
                else if (key == "image"){
                    self.rgionImg.image = UIImage(named: val)
                }
            }
            self.refresh(nil)
        }
    }
    // refresh data
    @objc func refresh(_ sender: AnyObject?) {
        TrendService.shared.fetchData(region: regionCode) { (trends) in
            if(trends?.count == 0){
                let alert = UIAlertController(title: "Loading error", message: "Don't have data from that region", preferredStyle: .alert)
                let action = UIAlertAction(title: "Oke", style: .cancel) { (action) in
                    alert.dismiss(animated: true, completion: nil)
                    
                }
                alert.addAction(action)
                DispatchQueue.main.async {
                    self.present(alert, animated: true, completion: nil)
                }
                return
            }
            self.trends = trends
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
                print("ok")
            }
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        loadingView.isHidden = true
    }
    
    
    
    func initUI(){
        self.title = "Top trending"
        self.regionView.layer.shadowColor = UIColor.black.cgColor
        self.regionView.layer.shadowOpacity = 0.5
        self.regionView.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.regionView.layer.shadowRadius = 4.0
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationItem.hidesBackButton = true
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
    }
}


extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trends?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TrendingTableViewCell
        cell.trend = trends![indexPath.row]
        
        cell.regionCode = regionCode
        cell.initUI()
        cell.loading = {
            self.loadingView.isHidden = false
        }
        cell.youTubeClosure = { videos in
            let vc = YoutubeViewController()
            vc.video = videos.items
            vc.nextPageToken = videos.nextPageToken
            vc.regionName = self.regionTF.text
            vc.region = self.regionCode
            vc.regionImage = self.rgionImg.image
            vc.keyWord = self.trends?[indexPath.row].title
            self.navigationController?.pushViewController(vc, animated: true)
        }
        cell.error = {
            self.loadingView.isHidden = true
            let alert = UIAlertController(title: "Loading error", message: "Can not load youtube search", preferredStyle: .alert)
            let action = UIAlertAction(title: "Oke", style: .cancel) { (action) in
                alert.dismiss(animated: true, completion: nil)
            }
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = NewViewController()
        vc.items = trends?[indexPath.row].item
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
