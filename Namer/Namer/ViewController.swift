//
//  ViewController.swift
//  Namer
//
//  Created by Lucas Inocencio on 03/01/19.
//  Copyright © 2019 Lucas Inocencio. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class ViewController: UIViewController {

    // Outlets
    @IBOutlet weak var helloLbl: UILabel!
    @IBOutlet weak var nameEntryTextField: UITextField!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var namesLbl: UILabel!
    @IBOutlet weak var addNameBtn: UIButton!
    
    
    // Variables
    let disposeBag = DisposeBag()
    var namesArray: Variable<[String]> = Variable([])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindTextField()
        bindSubmitButton()
        bindAddNameButton()
        
        namesArray.asObservable().subscribe(onNext: { names in
            self.namesLbl.text = names.joined(separator: ", ")
        })
    }
    
    func bindTextField() {
        nameEntryTextField.rx.text
            .map {
                if $0 == "" {
                    return "Type your name below."
                } else {
                    return "Hello, \($0!)."
                }
            }
            .bind(to:  helloLbl.rx.text)
            .disposed(by: disposeBag)
    }
    
    func bindSubmitButton() {
        submitBtn.rx.tap
            .subscribe(onNext: {
                if self.nameEntryTextField.text != "" {
                    self.namesArray.value.append(self.nameEntryTextField.text!)
                    self.namesLbl.rx.text.onNext(self.namesArray.value.joined(separator: ", "))
                    self.nameEntryTextField.rx.text.onNext("")
                    self.helloLbl.rx.text.onNext("Type your name below.")
                }
            })
            .disposed(by: disposeBag)
    }
    
    func bindAddNameButton() {
        addNameBtn.rx.tap
            .throttle(0.5, scheduler: MainScheduler.instance)
            .subscribe(onNext: {
                guard let addNameVC = self.storyboard?.instantiateViewController(withIdentifier: "AddNameVC") as? AddNameViewController else { fatalError("Couldn't not create AddNameVC") }
                addNameVC.nameSubject.subscribe(onNext: { name in
                    self.namesArray.value.append(name)
                    addNameVC.dismiss(animated: true, completion: nil)
                }).disposed(by: self.disposeBag)
                self.present(addNameVC, animated: true, completion: nil)
            })
    }


}

