//
//  TextValidationModel.swift
//  Biirr
//
//  Created by Ana Márquez on 08/03/2021.
//

import UIKit

class GenericValidation<T> : NSObject {
    var data: DynamicValue<[String: T?]> = DynamicValue([:])
}

class TextValidationModel: GenericValidation<String>, UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let tf = textField as? BiirrTextField {
            tf.tintColor = tf.borderLineColor
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let tf = textField as? BiirrTextField {
            tf.tintColor = .lightGray
            data.value = [tf.validationType.rawValue: textField.text]
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
