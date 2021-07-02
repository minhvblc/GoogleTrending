//
//  NewViewController.swift
//  GoogleTrending
//
//  Created by Nguyễn Minh on 27/06/2021.
//

import UIKit

class NewViewController: UIViewController {
    //Model
    var items : [Items]?
   
    //IBoutlet
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "NewTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        initUi()
        
    }

    func initUi(){
        self.title = "News"
    }
  

}
extension NewViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! NewTableViewCell
        cell.item = items?[indexPath.row]
        cell.initUI()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let url = URL(string: (items?[indexPath.row].url)!) {
            UIApplication.shared.open(url)
        }
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

