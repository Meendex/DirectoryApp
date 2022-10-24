//
//  ViewController.swift
//  DirectoryApp
//
//  Created by Mindaugas Balakauskas on 20/10/2022.
//

import UIKit
import Combine

class RoomsViewController: UIViewController {
    
    let viewModel = RoomsViewModel()
    @IBOutlet weak var tableView: UITableView!
    var bag: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        Task {
            await viewModel.getRoomsAsync()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        let cancellable = viewModel.$rooms.sink(receiveValue: { _ in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })

        bag.insert(cancellable)
        
    }
}
extension RoomsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.roomsRecordCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "roomCell", for: indexPath) as? RoomsTableViewCell else {
            return UITableViewCell()
            
        }
        let room = viewModel.getRoomsModel(index: indexPath.row)
        cell.updateData(with: room)
        
        
        return cell
    }
}
