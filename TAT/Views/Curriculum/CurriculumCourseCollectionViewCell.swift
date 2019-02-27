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
  private let fontSize: CGFloat = 12.5

  lazy var courseNameLabel: UILabel = {
    let label = UILabel(frame: CGRect.zero)
    label.textColor = UIColor.white
    label.textAlignment = .center
    label.numberOfLines = 6
    label.lineBreakMode = .byCharWrapping
    label.font = label.font.withSize(fontSize)
    label.translatesAutoresizingMaskIntoConstraints = true
    return label
  }()

  // MARK: - Initializations
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.layer.cornerRadius = 3
    contentView.addSubview(courseNameLabel)
    courseNameLabel.snp.makeConstraints { (make) in
      make.edges.equalTo(contentView).inset(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
