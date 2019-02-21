//
//  CurriculumCourseCollectionViewCell.swift
//  TAT
//
//  Created by 神崎秀吉 on 2019/02/18.
//

import UIKit
import SnapKit

class CurriculumCourseCollectionViewCell: UICollectionViewCell {

  // MARK: - Properties
  static let reuseIdentifier = "curriculumCourseCollectionViewCell"

  lazy var courseNameLabel: UILabel = {
    let label = UILabel(frame: CGRect.zero)
    label.textColor = UIColor.white
    label.textAlignment = .center
    label.numberOfLines = 6
    label.lineBreakMode = .byCharWrapping
    label.translatesAutoresizingMaskIntoConstraints = true
    return label
  }()

  // MARK: - Initialization

  override init(frame: CGRect) {
    super.init(frame: frame)

    contentView.addSubview(courseNameLabel)
    courseNameLabel.snp.makeConstraints { (make) in
      make.edges.equalTo(contentView).inset(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
    }

  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
