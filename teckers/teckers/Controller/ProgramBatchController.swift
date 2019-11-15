//
//  ProgramBatchController.swift
//  teckers
//
//  Created by Maggie Mendez on 13/11/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import UIKit

class ProgramBatchController: UIViewController {

    @IBOutlet weak var ProgramTextField: UITextField!
    @IBOutlet weak var BatchTextField: UITextField!
    
    @IBOutlet weak var ContinueButton: UIButton!
    var program: Program? {
        didSet{
            BatchService.getBatches(by: program?.id ?? "", onSuccess: { (batches) in
                self.batch = batches
            }, onFailure: nil)
        }
    }
    var programs: [Program]?
    var batch: [Batch]?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let navigator = navigationController {
            navigator.setNavigationBarHidden(true, animated: true)
        }
        setupContinueButton()
        
        ProgramService.getPrograms(onSuccess: {[weak self] (allPrograms) in
            self?.programs = allPrograms
        }, onFailure: nil)
        let pickerView = UIPickerView()
        pickerView.delegate = self
        
        setupProgramTextField(with: pickerView)
        setupBatchTextField(with: pickerView)
    }
    func setupContinueButton(){
        ContinueButton.isEnabled = false
        ContinueButton.adjustsImageWhenDisabled = true
        ContinueButton.backgroundColor = UIColor.systemGray
        ContinueButton.layer.cornerRadius = ContinueButton.frame.height/4
    }
    func setupProgramTextField(with picker: UIPickerView){
        ProgramTextField.inputView = picker
        ProgramTextField.inputAccessoryView = setupToolBarForPrograms()
        ProgramTextField.delegate = self
    }
    func setupBatchTextField(with picker: UIPickerView){
        BatchTextField.isEnabled = false
        BatchTextField.inputView = picker
        BatchTextField.inputAccessoryView = setupToolBarForPrograms()
        BatchTextField.delegate = self
    }
    func setupToolBarForPrograms() -> UIToolbar{
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(didTapDone))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(didTapCancel))

        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.sizeToFit()
        return toolBar
    }
    @objc func didTapDone() {
        if ProgramTextField.isFirstResponder{
            programPickerDone()
        }
        else if BatchTextField.isFirstResponder{
            batchPickerDone()
        }
    }
    func programPickerDone(){
        self.ProgramTextField.resignFirstResponder()
        BatchTextField.isEnabled = true
    }
    func batchPickerDone(){
        self.BatchTextField.resignFirstResponder()
        ContinueButton.isEnabled = true
        ContinueButton.backgroundColor = Color.purple
    }

    @objc func didTapCancel() {
        if ProgramTextField.isFirstResponder{
            self.ProgramTextField.text = nil
            self.ProgramTextField.resignFirstResponder()
            BatchTextField.isEnabled = false
        }
        else if BatchTextField.isFirstResponder{
            self.BatchTextField.text = nil
            self.BatchTextField.resignFirstResponder()
        }
    }
    @IBAction func tapContinue(_ sender: Any) {
        if let viewController = UIStoryboard(name: Storyboards.logedStoryboard.rawValue , bundle: nil).instantiateViewController(withIdentifier: Views.DeliverablesID.rawValue) as? DeliverablesController {
               if let navigator = navigationController {
                   navigator.setNavigationBarHidden(false, animated: true)
                   navigator.pushViewController(viewController, animated: true)
               }
           }
    }
    
}
extension ProgramBatchController: UIPickerViewDelegate{
    
}
extension ProgramBatchController: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if ProgramTextField.isFirstResponder{
            return (programs?.count ?? 0) 
        }
        return (batch?.count ?? 0)
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if ProgramTextField.isFirstResponder{
            return programs?[row].name ?? ""
        }
        else if BatchTextField.isFirstResponder{
            return batch?[row].name ?? ""
        }
        return ""
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if ProgramTextField.isFirstResponder{
            ProgramTextField.text = programs?[row].name
            program = programs?[row]
        }
        else if BatchTextField.isFirstResponder{
            BatchTextField.text = batch?[row].name
        }
    }
    
}
extension ProgramBatchController: UITextFieldDelegate{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
}
