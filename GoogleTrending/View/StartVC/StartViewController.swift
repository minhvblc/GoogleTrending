//
//  StartViewController.swift
//  GoogleTrending
//
//  Created by Nguyễn Minh on 26/06/2021.
//

import UIKit

class StartViewController: UIViewController {
    // Model
    var trends : [Trend]?
    
    //IBoutlet
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    
    func initData(){
        TrendService.shared.fetchData(region: nil){ trends in
            self.trends = trends
            if trends != nil{
                DispatchQueue.main.async {
                    let vc = MainViewController()
                    vc.trends = trends
                    self.navigationController?.pushViewController(vc, animated: true)}
                
            }else{
                let alert = UIAlertController(title: "Loading error", message: "Can not load data, check your internet connection", preferredStyle: .alert)
                let action = UIAlertAction(title: "Try again", style: .cancel) { (action) in
                    alert.dismiss(animated: true, completion: nil)
                    self.initData()
                }
                alert.addAction(action)
                DispatchQueue.main.async {
                    self.present(alert, animated: true, completion: nil)
                }
                
            }
            
        }
        
        
    }
    
    
    
}
