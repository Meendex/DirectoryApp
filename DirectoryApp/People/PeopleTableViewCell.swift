//
//  PeopleTableViewCell.swift
//  DirectoryApp
//
//  Created by Mindaugas Balakauskas on 23/10/2022.
//

import UIKit

class PeopleTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var jobtitleLabel: UILabel!
    @IBOutlet weak var favoriteColorLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func prepareForReuse() {
        avatarImageView.image = nil
        createdAtLabel.text = "Created: "
        firstNameLabel.text = "First Name: "
        lastNameLabel.text = "Last Name: "
        emailLabel.text = "E-mail: "
        jobtitleLabel.text = "Job Title:"
        favoriteColorLabel.text = "Favorite Color: "
        idLabel.text = "ID: "
    }
    func updateDisplayData(with model: PeopleRespose) {
        createdAtLabel.text = model.createdAt
        firstNameLabel.text = model.firstName
        lastNameLabel.text = model.lastName
        emailLabel.text = model.email
        jobtitleLabel.text = model.jobtitle
        favoriteColorLabel.text = model.favouriteColor
        idLabel.text = model.id
    }
}
