import RxCocoa
import RxSwift
import UIKit

class AddNameViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var newNameTextField: UITextField!
    @IBOutlet weak var submitBtn: UIButton!
    
    // Variagles
    let disposeBag = DisposeBag()
    let nameSubject = PublishSubject<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindSubmitBtn()
    }
    
    func bindSubmitBtn() {
        submitBtn.rx.tap
            .subscribe(onNext: {
                if self.newNameTextField.text != "" {
                    self.nameSubject.onNext(self.newNameTextField.text!)
                }
            })
            .disposed(by: disposeBag)
    }

}
