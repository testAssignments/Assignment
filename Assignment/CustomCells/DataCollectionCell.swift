//
//  DataCollectionCell.swift
//  Assignment
//
//  Created by test on 23/07/19.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit
import SDWebImage

class DataCollectionCell: UICollectionViewCell {
    static let dataCelIdentifier = "DataCollectionCell"
    static let cellCornerRadius: CGFloat = 5.0
    let spacingValue: CGFloat = 15
    /// Container view for beautification
    let containerView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.black
        view.layer.cornerRadius = cellCornerRadius
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    /// Image from the data
    let imgView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit // image will never be strecthed vertially or horizontally
        image.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        return image
    }()
    /// Main title label
    let title: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor =  UIColor.white
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    /// Description Label
    let subTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor =  UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var width: NSLayoutConstraint = {
        let width = contentView.widthAnchor.constraint(equalToConstant: bounds.size.width)
        width.isActive = true
        return width
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.layer.cornerRadius = DataCollectionCell.cellCornerRadius
        contentView.clipsToBounds = true
        contentView.backgroundColor = UIColor.black
        layoutCellConstraints()
    }
    override func systemLayoutSizeFitting(_ targetSize: CGSize,
                                          withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority,
                                          verticalFittingPriority: UILayoutPriority) -> CGSize {
        width.constant = bounds.size.width
        if UIDevice.current.userInterfaceIdiom == .pad {
            return contentView.systemLayoutSizeFitting(CGSize(width: Constant.ipadWidth, height: Constant.estimatedHeight))
        } else {
            return contentView.systemLayoutSizeFitting(CGSize(width: Constant.iphoneWidth, height: Constant.estimatedHeight))
        }
    }
    /// Layout for the cell things
    func layoutCellConstraints() {
        contentView.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
        contentView.addSubview(title)
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: spacingValue),
            title.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: spacingValue),
            title.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -spacingValue),
            ])
        contentView.addSubview(subTitle)
        NSLayoutConstraint.activate([
            subTitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: spacingValue),
            subTitle.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: spacingValue),
            subTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -spacingValue),
            ])
        contentView.addSubview(imgView)
        NSLayoutConstraint.activate([
            imgView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: spacingValue),
            imgView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imgView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imgView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imgView.heightAnchor.constraint(equalToConstant: Constant.estimatedHeight),
            imgView.widthAnchor.constraint(equalTo: contentView.widthAnchor)
            ])
        contentView.bottomAnchor.constraint(equalTo: subTitle.bottomAnchor, constant: spacingValue).isActive = true
    }
    /// Setting up the collectionview cell
    func setUpCell(with cellData: DataDict) {
        title.text = ""
        subTitle.text = ""
        /// check for nil values
        if cellData.title != nil || cellData.description != nil || cellData.imageHref != nil {
            if let titletext = cellData.title {
                title.text = titletext
            }
            if let subTitleText = cellData.description {
                subTitle.text = subTitleText
            }
            if let imghref = cellData.imageHref {
                let url = URL(string: imghref)
                /// Use of Sd_WebImage framework for image downloading
                imgView.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "Imageplaceholder"))
            } else {
                imgView.image = #imageLiteral(resourceName: "Imageplaceholder")
            }
        }
        layoutCellConstraints()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
