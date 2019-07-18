//
//  dataCell.swift
//  Assignment
//
//  Created by test on 17/07/19.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit

class DataCell: UITableViewCell {
    static let dataCelIdentifier = "DataCellIdentifier"
    /// subviews
    /// Image from the data
    let imgView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill // image will never be strecthed vertially or horizontally
        image.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        image.layer.cornerRadius = 5
        image.clipsToBounds = true
        return image
    }()
    /// Main title label
    let title: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.backgroundColor =  UIColor.white
        label.textColor =  UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    /// Description Label
    let subTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor =  UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    /// init cell with subviews
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(imgView)
        self.contentView.addSubview(title)
        self.contentView.addSubview(subTitle)
        layoutConstraints()
        self.contentView.layer.cornerRadius = 5.0
        self.contentView.clipsToBounds = true
    }
    /// Cell layout Constraints
    func layoutConstraints() {
        let marginGuide = contentView.layoutMarginsGuide
        subTitle.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imgView.centerYAnchor.constraint(equalTo: marginGuide.centerYAnchor),
            imgView.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor, constant: 5),
            imgView.widthAnchor.constraint(equalToConstant: 60),
            imgView.heightAnchor.constraint(equalToConstant: 60),
            title.leadingAnchor.constraint(equalTo: imgView.trailingAnchor, constant: 5),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            title.topAnchor.constraint(equalTo: topAnchor, constant: 3),
            title.heightAnchor.constraint(equalToConstant: 30),
            subTitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 3),
            subTitle.leadingAnchor.constraint(equalTo: imgView.trailingAnchor, constant: 5),
            subTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5)
            ])
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
