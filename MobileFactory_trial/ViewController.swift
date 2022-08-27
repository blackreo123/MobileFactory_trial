//
//  ViewController.swift
//  MobileFactory_trial
//
//  Created by JIHA YOON on 2022/08/26.
//

import UIKit

enum Answer: String {
    case yes = "含まれています。"
    case no = "含まれてないです。"
}

class ViewController: UIViewController {
    
    @IBOutlet weak var selectedTimeTextField: UITextField!
    @IBOutlet weak var startTimeTextField: UITextField!
    @IBOutlet weak var endTimeTextFied: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    var toolBar:UIToolbar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupToolbar()
        selectedTimeTextField.delegate = self
        startTimeTextField.delegate = self
        endTimeTextFied.delegate = self
    }
    
    func setupToolbar() {
        toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        toolBar.setItems([doneButton], animated: true)
        selectedTimeTextField.inputAccessoryView = toolBar
        startTimeTextField.inputAccessoryView = toolBar
        endTimeTextFied.inputAccessoryView = toolBar
    }
    
    @objc func doneButtonTapped(){
        self.view.endEditing(true)
    }
    
    @IBAction func judgeButtonAction(_ sender: UIButton) {
        guard let selectedTime = Int(selectedTimeTextField.text ?? "") else { return }
        guard let startTime = Int(startTimeTextField.text ?? "") else { return }
        guard let endTime = Int(endTimeTextFied.text ?? "") else { return }

        if startTime < endTime {
            if startTime..<endTime ~= selectedTime {
                resultLabel.text = Answer.yes.rawValue
            } else {
                resultLabel.text = Answer.no.rawValue
            }
        }
        
        
        if startTime == endTime {
            if selectedTime == startTime {
                resultLabel.text = Answer.yes.rawValue
            } else {
                resultLabel.text = Answer.no.rawValue
            }
        }
        
        if startTime > endTime {
            if startTime..<24 ~= selectedTime {
                resultLabel.text = Answer.yes.rawValue
            } else if 0..<endTime ~= selectedTime {
                resultLabel.text = Answer.yes.rawValue
            } else {
                resultLabel.text = Answer.no.rawValue
            }
        }
        
    }
    
}

extension ViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = .time
        datePickerView.preferredDatePickerStyle = .wheels
        textField.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(datePickerValueChanged(sender:)), for: .valueChanged)
    }
    
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat  = "HH"
        dateFormatter.locale = Locale(identifier: "ja_JP")
        
        if selectedTimeTextField.isFirstResponder {
            selectedTimeTextField.text = dateFormatter.string(from: sender.date)
        }
        if startTimeTextField.isFirstResponder {
            startTimeTextField.text = dateFormatter.string(from: sender.date)
        }
        if endTimeTextFied.isFirstResponder {
            endTimeTextFied.text = dateFormatter.string(from: sender.date)
        }
    }
}
