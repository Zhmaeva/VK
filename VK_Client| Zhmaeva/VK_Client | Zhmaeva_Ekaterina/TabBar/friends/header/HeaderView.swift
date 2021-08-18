//
//  HeaderView.swift
//  VK_Client | Zhmaeva_Ekaterina
//
//  Created by Catherine on 08.07.2021.
//

import UIKit

final class HeaderView: UITableViewHeaderFooterView {
    
    
    @IBOutlet weak var backViewHeader: UIView!
    @IBOutlet weak var imageHeader: UIImageView!
    @IBOutlet weak var leterHeader: UILabel!
    
    var view: UIView?
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func loadFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "HeaderView", bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {return UIView()
        }
        return view
    }

    func setup() {
        view = loadFromNib()
        guard let view = view else {return}
        view.backgroundColor = #colorLiteral(red: 0.8979603648, green: 0.8980897069, blue: 0.8979321122, alpha: 1)
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
}
