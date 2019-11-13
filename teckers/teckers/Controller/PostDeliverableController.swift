//
//  PostDeliverableController.swift
//  teckers
//
//  Created by Maggie Mendez on 05/11/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import UIKit

class PostDeliverableController: UIViewController {

    @IBOutlet weak var textArea: UITextView!
    @IBOutlet weak var nameDeliverable: UILabel!
    var deliverable: Deliverable?
    var placeholder: String = "Inserte texto aqui..."
    override func viewDidLoad() {
        super.viewDidLoad()
        textArea.text = placeholder
        textArea.delegate = self
        textArea.textColor = UIColor.lightGray
        nameDeliverable.text = deliverable?.title
        addDoneButtonOnKeyboard()
    }
    @objc func tapDone(sender: Any) {
        self.view.endEditing(true)
    }
    @IBAction func sendDeliverable(_ sender: Any) {
        guard textArea.textColor == UIColor.lightGray else {
            self.dismiss(animated: true, completion: nil)
            return
        }
        DeliverableService.postDeliverable(for: deliverable?.id ?? "", text: textArea.text, onSuccess: { [weak self] in
            self?.presentMessage(with: "Exito", message: "Tu tarea se entrego con exitoo")
        }) { [weak self] in
            self?.presentMessage(with: "Error", message: "Hubo un error al entregar tu tarea")
        }
    }
    func presentMessage(with title: String, message: String){
        let message = Alert(title: title, massage: message)
        self.present(message.showOK(), animated: true) { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
    }
    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = .blackOpaque
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem  = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonAction))

        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)

        doneToolbar.items = items
        doneToolbar.sizeToFit()

        self.textArea.inputAccessoryView = doneToolbar
    }

    @objc func doneButtonAction() {
        self.textArea.resignFirstResponder()
    }
}
extension PostDeliverableController: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeholder
            textView.textColor = UIColor.lightGray
        }
    }
}
