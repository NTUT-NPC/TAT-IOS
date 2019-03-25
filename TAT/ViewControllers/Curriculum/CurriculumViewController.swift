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

  private lazy var curriculumViewModel = CurriculumViewModel()

  lazy var curriculumCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)

    layout.scrollDirection = .vertical
    layout.minimumInteritemSpacing = 0
    layout.minimumLineSpacing = 0
    layout.sectionInset = UIEdgeInsets(top: 2, left: 0, bottom: 2, right: 0)

    collectionView.translatesAutoresizingMaskIntoConstraints = true
    collectionView.backgroundColor = UIColor.white
    collectionView.register(CurriculumCourseCollectionViewCell.self,
                            forCellWithReuseIdentifier: CurriculumCourseCollectionViewCell.reuseIdentifier)

    return collectionView
  }()

  // MARK: - Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(curriculumCollectionView)
    curriculumCollectionView.snp.makeConstraints { (make) in
      make.edges.equalTo(view)
    }

    let dataSource = RxCollectionViewSectionedReloadDataSource<SectionOfCourseInfo>(configureCell: { dataSource, collectionView, indexPath, item in
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CurriculumCourseCollectionViewCell.reuseIdentifier, for: indexPath) as? CurriculumCourseCollectionViewCell else {
        return collectionView.dequeueReusableCell(withReuseIdentifier: CurriculumCourseCollectionViewCell.reuseIdentifier, for: indexPath)
      }

      cell.courseNameLabel.text = item.name
      cell.backgroundColor = item.color
      return cell
    })

    curriculumViewModel.output.bind(to: curriculumCollectionView.rx.items(dataSource: dataSource)).disposed(by: rx.disposeBag)
    curriculumCollectionView.rx.setDelegate(self).disposed(by: rx.disposeBag)
  }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CurriculumViewController: UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = collectionView.frame.width
    let cellCount: CGFloat = 7
    return CGSize(width: (width * 0.95) / cellCount, height: (width * 0.95) / cellCount * 1.2)
  }

}
