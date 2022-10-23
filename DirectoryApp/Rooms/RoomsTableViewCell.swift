//
//  RoomsTableViewCell.swift
//  DirectoryApp
//
//  Created by Mindaugas Balakauskas on 20/10/2022.
//

import UIKit

class RoomsTableViewCell: UITableViewCell {

    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var occupiedLabel: UILabel!
    @IBOutlet weak var maxOccupancyLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func updateData(with roomData: RoomResponse) {
        createdAtLabel.text = roomData.createdAt
        maxOccupancyLabel.text = String(roomData.maxOccupancy)
        occupiedLabel.text = String(roomData.isOccupied)
        idLabel.text = roomData.id
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
