//
//  PhotoCell.swift
//  KoinzTask
//
//  Created by Rowaad on 19/05/2022.
//

import UIKit

class PhotoCell: UITableViewCell {

    @IBOutlet weak fileprivate var photoImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        setupUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        setupUI()
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupUI() {
        photoImg.layer.cornerRadius = 8
    }
    
    func bind(_ vieWModel: PhotoViewModel) {
        self.photoImg.setImage(url: vieWModel.imageURL)
    }
    
}
