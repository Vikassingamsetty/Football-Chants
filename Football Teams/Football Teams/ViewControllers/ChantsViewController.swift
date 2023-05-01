//
//  ChantsViewController.swift
//  Football Teams
//
//  Created by Vikas on 01/05/23.
//

import UIKit

class ChantsViewController: UIViewController {

    // MARK: - UI
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .clear
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 44
        table.separatorStyle = .none
        table.delegate = self
        table.dataSource = self
        table.register(TeamTableViewCell.self, forCellReuseIdentifier: TeamTableViewCell.cellID)
        return table
    }()
    
    private lazy var viewModel = TeamsViewModel()
    private lazy var audioPlayer = AudioManagerViewModel()
    
    // MARK: - View Lifecycle
    override func loadView() {
        super.loadView()
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
}

private extension ChantsViewController {
    
    func setup() {
        navigationController?.navigationBar.topItem?.title = "Football Chants"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        self.view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

extension ChantsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.teams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TeamTableViewCell.cellID, for: indexPath) as! TeamTableViewCell
        cell.configure(with: viewModel.teams[indexPath.row], delegate: self )
        return cell
    }
}

extension ChantsViewController: TeamTableViewCellDelegate {
    
    func didTapPlayButton(for team: Team) {
        
        audioPlayer.playback(with: team)
        viewModel.togglePlayback(for: team)
        tableView.reloadData()
    }
}

