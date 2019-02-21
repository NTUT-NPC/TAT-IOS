//
//  CurriculumViewController.swift
//  TAT
//
//  Created by Jamfly on 2019/1/29.
//  Copyright © 2019 jamfly. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import SnapKit

class CurriculumViewController: BaseViewController {

  // MARK: - Properties

  private let disposeBag = DisposeBag()

  lazy var curriculumCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)

    layout.scrollDirection = .horizontal
    layout.minimumInteritemSpacing = 0
    layout.minimumLineSpacing = 0
//    layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

    collectionView.translatesAutoresizingMaskIntoConstraints = true
    collectionView.backgroundColor = UIColor.gray
    collectionView.register(CurriculumCourseCollectionViewCell.self, forCellWithReuseIdentifier: CurriculumCourseCollectionViewCell.reuseIdentifier)

    return collectionView
  }()

  // MARK: - Life cycle

  override func viewDidLoad() {
    super.viewDidLoad()

    view.addSubview(curriculumCollectionView)

    curriculumCollectionView.snp.makeConstraints { (make) in
      make.edges.equalTo(view)
    }

//    let item = Observable.just((0..<20).map { "OwO \($0)" })
    //    item.bind(to: self.curriculumCollectionView.rx.items(cellIdentifier: CurriculumCourseCollectionViewCell.reuseIdentifier, cellType: CurriculumCourseCollectionViewCell.self)) { row, data, cell in
    //      cell.testLabel.text = data
    //      cell.backgroundColor = UIColor.gray
    //    }.disposed(by: disposeBag)
//    let items = Observable.just([
//      SectionModel(model: "OwO", items: [
//        "owo",
//        "owwo",
//        "owwwo",
//        "owo",
//        "owwo",
//        "owo",
//        "owwo"
//        ]),
//      SectionModel(model: "OwwO", items: [
//        "OwO",
//        "OwwO",
//        "OwwwO",
//        "OwO",
//        "OwwO",
//        "OwO",
//        "OwwO"
//        ])
//      ])

    let testItems = [
      SectionOfCourseInfo(day: "OwO", items: [
        CourseInfo(name: "OwO", id: nil, instructor: nil, classroom: nil),
        CourseInfo(name: "OwO", id: nil, instructor: nil, classroom: nil),
        CourseInfo(name: "OwO", id: nil, instructor: nil, classroom: nil)
        ]),
      SectionOfCourseInfo(day: "OwO", items: [
        CourseInfo(name: nil, id: nil, instructor: nil, classroom: nil),
        CourseInfo(name: nil, id: nil, instructor: nil, classroom: nil),
        CourseInfo(name: nil, id: nil, instructor: nil, classroom: nil)
        ]),
      SectionOfCourseInfo(day: "OwO", items: [
        CourseInfo(name: nil, id: nil, instructor: nil, classroom: nil),
        CourseInfo(name: nil, id: nil, instructor: nil, classroom: nil),
        CourseInfo(name: nil, id: nil, instructor: nil, classroom: nil)
        ])
    ]

//    let dataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, String>>(configureCell: { dataSource, collectionView, indexPath, item in
//      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CurriculumCourseCollectionViewCell.reuseIdentifier, for: indexPath)
//      guard let courseCell = cell as? CurriculumCourseCollectionViewCell else {
//        return cell
//      }
//
//      courseCell.courseNameLabel.text = item
//      courseCell.backgroundColor = UIColor.lightGray
//      return cell
//    })

    let dataSource = RxCollectionViewSectionedReloadDataSource<SectionOfCourseInfo>(configureCell: { dataSource, collectionView, indexPath, item in
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CurriculumCourseCollectionViewCell.reuseIdentifier, for: indexPath) as? CurriculumCourseCollectionViewCell else {
        return collectionView.dequeueReusableCell(withReuseIdentifier: CurriculumCourseCollectionViewCell.reuseIdentifier, for: indexPath)
      }

      cell.backgroundColor = UIColor.lightGray

      guard let name = item.name else {
        cell.courseNameLabel.text = "Empty OwO"
        return cell
      }

      cell.courseNameLabel.text = "This is \(name)"
      return cell
    })

//    items.bind(to: curriculumCollectionView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
    Observable.just(testItems).bind(to: curriculumCollectionView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
    curriculumCollectionView.rx.setDelegate(self).disposed(by: disposeBag)

  }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CurriculumViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//    let width = collectionView.contentSize.width
    let width = collectionView.frame.width
    let cellCount: CGFloat = 7
//    let width = UIScreen.main.bounds.width
//    let infoWidth: CGFloat = 25
//    let infoHeight: CGFloat = 25
////    let days = CGFloat(self.courseTables?[collectionView.tag].days.count ?? 5)
//    let days: CGFloat = 5
//    let courseWidth = (width - infoWidth) / days - 5
//
//    if indexPath.section == 0 {
//      if indexPath.row == 0 {
//        // Semester cell
//        return CGSize(width: infoWidth, height: infoHeight)
//      }
//      // Day cell
//      return CGSize(width: courseWidth, height: infoHeight)
//    } else {
//      if indexPath.row == 0 {
//        // Time cell
//        return CGSize(width: infoWidth, height: courseWidth)
//      }
//      // Course cell
//      return CGSize(width: courseWidth, height: courseWidth)
//    }
    return CGSize(width: (width * 0.95) / cellCount, height: (width * 0.95) / cellCount * 2)
  }
}

// MARK: - CourseInfo

struct CourseInfo {
  var name: String?
  var id: String?
  var instructor: String?
  var classroom: String?
}

struct SectionOfCourseInfo {
  var day: String
  var items: [Item]
}

extension SectionOfCourseInfo: SectionModelType {
  typealias Item = CourseInfo

  init(original: SectionOfCourseInfo, items: [Item]) {
    self = original
    self.items = items
  }
}

// MARK: - Test ViewModel

class TestViewModel {
  func transform(input: [Course]) -> [SectionOfCourseInfo] {
    <#function body#>
  }
}
