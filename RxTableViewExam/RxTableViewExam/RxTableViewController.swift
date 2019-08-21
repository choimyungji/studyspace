//
//  ViewController.swift
//  RxTableViewExam
//
//  Created by Myungji Choi on 21/08/2019.
//  Copyright © 2019 Myungji Choi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class RxTableViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  let bag = DisposeBag()

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    bindTableView4()
  }

  private func bindTableView1() {
    let cities = ["London", "Vienna", "Lisbon"]
    let citiesOb: Observable<[String]> = Observable.of(cities)
    citiesOb.bind(to: tableView.rx.items) { tableView, index, element -> UITableViewCell in
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "NameCell") else { return UITableViewCell() }
      cell.textLabel?.text = element
      return cell
    }.disposed(by: bag)
  }

  private func bindTableView2() {
    let cities = ["London", "Vienna", "Lisbon"]
    let citiesOb: Observable<[String]> = Observable.of(cities)

    citiesOb.bind(to: tableView.rx.items(cellIdentifier: "NameCell")) { index, element, cell in
      cell.textLabel?.text = element
    }.disposed(by: bag)
  }

  private func bindTableView3() {
    let cities = ["London", "Vienna", "Lisbon"]
    let citiesOb: Observable<[String]> = Observable.of(cities)

    citiesOb.bind(to: tableView.rx.items(cellIdentifier: "NameCell", cellType: NameCell.self)) { index, element, cell in
      cell.textLabel?.text = element
    }.disposed(by: bag)
  }

  typealias CitySectionModel = SectionModel<String, String>
  typealias CityDataSource = RxTableViewSectionedReloadDataSource<CitySectionModel>

  private func bindTableView4() {
    let firstCities = ["London", "Vienna", "Lisbon"]
    let secondCities = ["Paris", "Madrid", "Seoul"]

    let sections = [
      CitySectionModel(model: "first section", items: firstCities),
      CitySectionModel(model: "second section", items: secondCities)
    ]

    Observable.just(sections)
      .bind(to: tableView.rx.items(dataSource: cityDataSource))
      .disposed(by: bag)


  }

  private var cityDataSource: CityDataSource {
    let configureCell: (TableViewSectionedDataSource<CitySectionModel>, UITableView, IndexPath, String) -> UITableViewCell = { datasource, tableView, indexPath, element in
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "NameCell", for: indexPath) as? NameCell else { return UITableViewCell() }
      cell.textLabel?.text = element
      return cell
    }

    let datasource = CityDataSource.init(configureCell: configureCell)
    datasource.titleForHeaderInSection = { datasource, index in
      return datasource.sectionModels[index].model
    }

    return datasource
  }
}

class NameCell: UITableViewCell {

}
