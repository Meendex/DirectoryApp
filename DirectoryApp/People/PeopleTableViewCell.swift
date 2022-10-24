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
        createdAtLabel.text = "Created: " + model.createdAt
        firstNameLabel.text = "First Name: " + model.firstName
        lastNameLabel.text = "Last Name: " + model.lastName
        emailLabel.text = "E-mail: " + model.email
        jobtitleLabel.text = "Job Title:" + model.jobtitle
        favoriteColorLabel.text = "Favorite Color: " + model.favouriteColor
        idLabel.text = "ID: " + model.id
    }
}
