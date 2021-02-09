//
//  DetailViewController.swift
//  TestProject
//
//  Created by yakuza on 09.02.2021.
//

import UIKit

class DetailViewController: UIViewController, UIGestureRecognizerDelegate {

    
    
    var viewModel: DetailViewModel?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet weak var businessNumberLabel: UILabel!
    @IBOutlet weak var labelLabel: UILabel!
    @IBOutlet weak var businessPhone: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var viewLabel: UIView!
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    
    let space = CGFloat(45)
    
    var tapped: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // corner radius
        viewLabel.layer.cornerRadius = 10
        // border
        viewLabel.layer.borderColor = UIColor.black.cgColor
        
        // shadow
        viewLabel.layer.shadowColor = UIColor.black.cgColor
        viewLabel.layer.shadowOffset = CGSize(width: 0, height: 3)
        viewLabel.layer.shadowOpacity = 0.1
        viewLabel.layer.shadowRadius = 10.0
        
        
        viewHeight.constant -= self.space * 2
        businessNumberLabel.isHidden = true
        labelLabel.isHidden = true
        businessPhone.isHidden = true
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let viewModel = viewModel else { return }
        
        self.nameLabel.text = viewModel.name
        self.durationLabel.text = durationTime(timeDuration: viewModel.duration)
        self.phoneLabel.text = viewModel.phone.applyPatternOnNumbers(pattern: "+# ### ###-####", replacmentCharacter: "#")
        self.businessPhone.text = viewModel.businessNumber.applyPatternOnNumbers(pattern: "+# ### ###-####", replacmentCharacter: "#")
        
        
    }

    @IBAction func showDetailsAction(_ sender: Any) {
        
        if !tapped == true {
            viewHeight.constant += self.space * 2
            businessNumberLabel.isHidden = false
            labelLabel.isHidden = false
            businessPhone.isHidden = false
            self.tapped = true
        } else {
            tapped = true
            viewHeight.constant -= self.space * 2
            businessNumberLabel.isHidden = true
            labelLabel.isHidden = true
            businessPhone.isHidden = true
            self.tapped = false
        }
    }
    
    func durationTime(timeDuration: String) -> String {
        let dateAsString = timeDuration
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm:ss"
        let date = dateFormatter.date(from: dateAsString)
        dateFormatter.dateFormat = "mm:ss"
        let date24 = dateFormatter.string(from: date!)
        
        return date24
    }
}
