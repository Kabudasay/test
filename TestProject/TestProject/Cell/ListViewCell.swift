//
//  ListViewCell.swift
//  TestProject
//
//  Created by yakuza on 09.02.2021.
//

import UIKit

protocol TableViewCellViewModelType: class {
    var name: String { get }
    var phone: String { get }
    var duration: String { get }
    var created: String { get }
}

class ListViewCell: UITableViewCell {
    
    @IBOutlet weak var contactNameLbl: UILabel!
    @IBOutlet weak var contactPhoneLbl: UILabel!
    @IBOutlet weak var durationTimeLbl: UILabel!
    @IBOutlet weak var createdLbl: UILabel!
    
    @IBOutlet weak var cellBackgroundView: UIView!
    
    weak var viewModel: TableViewCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            
            // Задача с отсутсвием имени
            // bold number
            if viewModel.name == "" {
                contactPhoneLbl.font = UIFont.boldSystemFont(ofSize: 15)
            }
            
            contactNameLbl.text = viewModel.name
            
            // Доп задача, маска для телефона
            contactPhoneLbl.text = viewModel.phone.applyPatternOnNumbers(pattern: "+# ### ###-####", replacmentCharacter: "#")
            createdLbl.text = createAt(value: viewModel.created)
            durationTimeLbl.text = durationTime(timeDuration: viewModel.duration)
            
        }
    }
    
    
    // MARK: - Дополнительные функции
    override func layoutSubviews() {
        super.layoutSubviews()
        self.cellBackgroundView.layer.cornerRadius = 10
        self.cellBackgroundView.layer.shadowColor = UIColor.black.withAlphaComponent(1.0).cgColor
        self.cellBackgroundView.layer.shadowOffset = CGSize.zero
        self.cellBackgroundView.layer.shadowRadius = 2
        self.cellBackgroundView.layer.shadowOpacity = 0.1
        self.cellBackgroundView.layer.masksToBounds = false
        self.cellBackgroundView.layer.shouldRasterize = true
        self.cellBackgroundView.layer.rasterizationScale = UIScreen.main.scale
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // Сорян за такие названия xD обычно я так не делаю
    // TODO: - переделать названия
    func durationTime(timeDuration: String) -> String {
        let dateAsString = timeDuration
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm:ss"
        let date = dateFormatter.date(from: dateAsString)
        dateFormatter.dateFormat = "mm:ss"
        let date24 = dateFormatter.string(from: date!)
        
        return date24
    }
    
    func createAt(value: String) -> String {
        let dateAsString = value
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.date(from: dateAsString)
        
        dateFormatter.dateFormat = "h:mm a"
        let date24 = dateFormatter.string(from: date!)
        
        return date24
    }
    
}
