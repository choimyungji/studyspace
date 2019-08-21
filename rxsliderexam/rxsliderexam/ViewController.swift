//
//  ViewController.swift
//  rxsliderexam
//
//  Created by Myungji Choi on 21/08/2019.
//  Copyright © 2019 Myungji Choi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

  @IBOutlet weak var colorView: UIView!
  @IBOutlet weak var rLabel: UILabel!
  @IBOutlet weak var gLabel: UILabel!
  @IBOutlet weak var bLabel: UILabel!
  @IBOutlet weak var rSlider: UISlider!
  @IBOutlet weak var gSlider: UISlider!
  @IBOutlet weak var bSlider: UISlider!

  var disposeBag = DisposeBag()
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    bind()
  }
}

extension ViewController {
  func bind() {
    let rObservable = rSlider.rx.value.map { CGFloat($0) }
    let gObservable = gSlider.rx.value.map { CGFloat($0) }
    let bObservable = bSlider.rx.value.map { CGFloat($0) }

    rObservable.map { "\(Int($0*255))" }
      .bind(to: rLabel.rx.text)
      .disposed(by: disposeBag)

    gObservable.map { "\(Int($0*255))" }
      .bind(to: gLabel.rx.text)
      .disposed(by: disposeBag)

    bObservable.map { "\(Int($0*255))" }
      .bind(to: bLabel.rx.text)
      .disposed(by: disposeBag)

    let color = Observable<UIColor>.combineLatest(rObservable, gObservable, bObservable) { (rValue, gValue, bValue) -> UIColor in
      return UIColor(red: rValue, green: gValue, blue: bValue, alpha: 1)
    }

//    color.subscribe(onNext: { [weak self] color in
//      self?.colorView.backgroundColor = color
//    }).disposed(by: disposeBag)

    color.bind(to: colorView.rx.backgroundColor)
      .disposed(by: disposeBag)
  }
}

extension Reactive where Base:UIView {
  var backgroundColor:Binder<UIColor> {
    return Binder(self.base, binding: { view, color in
      view.backgroundColor = color
    })
  }
}
