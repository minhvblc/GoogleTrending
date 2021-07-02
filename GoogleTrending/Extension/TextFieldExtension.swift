//
//  TextFieldExtension.swift
//  GoogleTrending
//
//  Created by Nguyễn Minh on 30/06/2021.
//

import Foundation
import UIKit
extension UITextField: UIPickerViewDelegate, UIPickerViewDataSource {
  
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return allCountries.count
    }
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return allCountries[row].name
    }
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    
    }
    
    func addInputViewDatePicker(target: Any?) {
        
        let screenWidth = UIScreen.main.bounds.width
        
       
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))
       
        self.inputView = pickerView
        pickerView.delegate = self
        //Add Tool Bar as input AccessoryView
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelBarButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPressed))
        let doneBarButton = UIBarButtonItem(title: "Done", style: .plain, target: self
                                            ,action: #selector(tapDone))
        toolBar.setItems([cancelBarButton, flexibleSpace, doneBarButton], animated: false)
        
        self.inputAccessoryView = toolBar
        
        
        
    }
    
    
    @objc func cancelPressed() {
        self.resignFirstResponder()
    }
    @objc func tapDone() {
         if let pickerView = self.inputView as? UIPickerView { // 2.1
            let index = pickerView.selectedRow(inComponent: 0)
            self.text = allCountries[index].name
            let nc = NotificationCenter.default
            nc.post(name: Notification.Name("pickedRegion"), object: nil, userInfo: ["regionCode": allCountries[index].alpha2, "image": allCountries[index].image])
         }
        self.resignFirstResponder()
     }
}


