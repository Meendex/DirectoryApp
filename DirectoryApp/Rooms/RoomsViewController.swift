//
//  ViewController.swift
//  DirectoryApp
//
//  Created by Mindaugas Balakauskas on 20/10/2022.
//

import UIKit
import Combine

class RoomsViewController: UIViewController {
    
    var viewModel: RoomsViewModel?
    @IBOutlet weak var tableView: UITableView!
    var bag: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        let cancellable = viewModel?.$rooms.sink(receiveValue: { _ in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
        guard let cancellable = cancellable
        else {
            return
        }
        bag.insert(cancellable)
        Task {
            await viewModel?.getRoomsAsync()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
extension RoomsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.roomsRecordCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel != nil {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "roomCell", for: indexPath) as? RoomsTableViewCell else {
                return UITableViewCell()
                
            }
            if let room = viewModel?.getRoomsModel(index: indexPath.row) {
                cell.updateData(with: room)
            }
            return cell
        }
        return UITableViewCell()
    }
    
    
}
