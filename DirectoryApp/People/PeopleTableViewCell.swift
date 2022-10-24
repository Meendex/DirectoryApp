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
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var jobtitleLabel: UILabel!
    @IBOutlet weak var favoriteColorLabel: UILabel!
    
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
        
        emailLabel.text = "E-mail: "
        jobtitleLabel.text = "Job Title:"
        favoriteColorLabel.text = "Favorite Colour: "
        
    }
    func updateDisplayData(with model: PeopleRespose) {
        createdAtLabel.text = "Joined at: " + model.createdAt
        firstNameLabel.text = "Full name: " + model.firstName + " " + model.lastName
        
        emailLabel.text = model.email
        jobtitleLabel.text = "Title: " + model.jobtitle
        favoriteColorLabel.text = "Favorite colour: " + model.favouriteColor
        
    }
}
