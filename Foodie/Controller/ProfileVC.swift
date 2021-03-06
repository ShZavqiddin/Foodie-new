//
//  ProfileVC.swift
//  Foodie
//
//  Created by Kh's on 7/4/21.
//

import UIKit

class ProfileVC: UIViewController {
    @IBOutlet var views: [UIView]!{
        didSet {
            for i in views {
                i.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.08105670853)
                i.layer.shadowOffset = CGSize(width: 1, height: 1)
                i.layer.shadowRadius = 3
                i.layer.shadowOpacity = 1
            }
        }
    }
    
    @IBOutlet weak var personNameLbl: UILabel!
    @IBOutlet weak var emaliLbl: UILabel!
    @IBOutlet weak var phoneNumberLbl: UILabel!
    @IBOutlet weak var aboutAddressLbl: UILabel!
    
    @IBOutlet weak var btnsHeights: NSLayoutConstraint!
    @IBOutlet weak var updateBtnHeight: NSLayoutConstraint!
    @IBOutlet weak var imgView: UIImageView!
    
    var data: PersonalDetailsDM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if (data?.email == "") {
//            emaliLbl.text = data?.email
//            aboutAddressLbl.text = data?.address
//            phoneNumberLbl.text = data?.phoneNumber
//            personNameLbl.text = data?.name
//        }

        decoder()
        setUp()
        
        title = "My Profile"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        emaliLbl.text = data?.email
        aboutAddressLbl.text = data?.address
        phoneNumberLbl.text = data?.phoneNumber
        personNameLbl.text = data?.name
        imgView.image = UserDefaults.standard.imageForKey(key: "Img")
    }
    
    // MARK: DECODER DATA
    func decoder(){
        if let savedData = UserDefaults.standard.object(forKey: "data") as? Data{
            let decoders = JSONDecoder()
            if let task = try? decoders.decode(PersonalDetailsDM.self, from: savedData){
                self.data = task
                
            }
        }
    }
    
    
    func setUp() {
        if isSmallScreen {
            btnsHeights.constant = 45
            updateBtnHeight.constant = 55
            emaliLbl.font = UIFont.systemFont(ofSize: 12)
            phoneNumberLbl.font = UIFont.systemFont(ofSize: 12)
            aboutAddressLbl.font = UIFont.systemFont(ofSize: 12)
        }
    }
    
    
    
    @IBAction func changeBtnPressed(_ sender: Any) {
        
        let vc = PresonalDetailsVC(nibName: "PresonalDetailsVC", bundle: nil)
        
        vc.modalPresentationStyle = .overFullScreen
        vc.delegate = self
        vc.dat = data
        present(vc, animated: true, completion: nil)
    }

}
extension ProfileVC: DMDelegate {
    func sendData(_ a: PersonalDetailsDM) {
        data = a
        emaliLbl.text = data?.email
        aboutAddressLbl.text = data?.address
        phoneNumberLbl.text = data?.phoneNumber
        personNameLbl.text = data?.name
        imgView.image = UserDefaults.standard.imageForKey(key: "Img")
        
    }
    
    var isSmallScreen : Bool {
        if UIScreen.main.bounds.height < 600 {
            return true
        }
        return false
    }
}
