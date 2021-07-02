//
//  NewTableViewCell.swift
//  GoogleTrending
//
//  Created by Nguyễn Minh on 27/06/2021.
//

import UIKit
import LinkPresentation
class NewTableViewCell: UITableViewCell {
    //Model
    var item: Items?
    
    private var provider = LPMetadataProvider()
    
    //IBoutlet
    @IBOutlet weak var bigView: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var source: UILabel!
    @IBOutlet weak var snippet: UILabel!
    private var linkView = LPLinkView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
   
    func initUI(){
        bigView.layer.cornerRadius = 10
        self.bigView.layer.shadowColor = UIColor.black.cgColor
        self.bigView.layer.shadowOpacity = 0.5
        self.bigView.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.bigView.layer.shadowRadius = 4.0
        title.text = String(htmlEncodedString: (item?.title)!)
        source.text =  String(htmlEncodedString: (item?.source)!)
        snippet.text =  String(htmlEncodedString: (item?.snippet)!)
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
