import UIKit

protocol AlertDelegate: class {
    func okButtonClicked(_ yolcu: Yolcu)
    func cancelButtonClicked()
}

class UserInfoView: UIViewController {
    
    let containerView = UIView()
    
    let name    = UITextField()
    let surname = UITextField()
    let tc      = UITextField()
    let hesKodu = UITextField()
    let cancelButton = UIButton()
    let okButton     = UIButton()
    
    weak var alertDelegate: AlertDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    
    private func configureUI(){
        view.addSubview(containerView)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor     = .systemBackground
        containerView.layer.cornerRadius  = 16
        containerView.layer.borderWidth   = 2
        containerView.layer.borderColor   = UIColor.white.cgColor
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 300),
            containerView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        configureName()
        configureSurname()
        configureTC()
        configureButtons()
        
    }
    
    private func configureName(){
        containerView.addSubview(name)
        name.translatesAutoresizingMaskIntoConstraints = false
        
        name.placeholder = "İsminiz"
        name.borderStyle = .roundedRect
        
        let padding = CGFloat(10)
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            name.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            name.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            name.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func configureSurname(){
        containerView.addSubview(surname)
        surname.translatesAutoresizingMaskIntoConstraints = false
        
        surname.placeholder = "Soy isminiz"
        surname.borderStyle = .roundedRect
        
        let padding = CGFloat(10)
        NSLayoutConstraint.activate([
            surname.topAnchor.constraint(equalTo: name.bottomAnchor, constant: padding),
            surname.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            surname.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            surname.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func configureTC(){
        containerView.addSubview(tc)
        containerView.addSubview(hesKodu)
        
        tc.placeholder  = "TC"
        tc.borderStyle  = .roundedRect
        
        hesKodu.placeholder   = "Hes Kodu"
        hesKodu.borderStyle   = .roundedRect
        
        tc.translatesAutoresizingMaskIntoConstraints  = false
        hesKodu.translatesAutoresizingMaskIntoConstraints   = false
        
        
        let padding = CGFloat(10)
        let sizeWidth = (300 - 6*padding)/2
        
        let size = CGFloat(30)
        NSLayoutConstraint.activate([
            tc.topAnchor.constraint(equalTo: surname.bottomAnchor, constant: padding),
            tc.leadingAnchor.constraint(equalTo: surname.leadingAnchor, constant: padding),
            tc.widthAnchor.constraint(equalToConstant: sizeWidth),
            tc.heightAnchor.constraint(equalToConstant: size),
            
            hesKodu.topAnchor.constraint(equalTo: surname.bottomAnchor, constant: padding),
            hesKodu.leadingAnchor.constraint(equalTo: tc.trailingAnchor, constant: padding),
            hesKodu.widthAnchor.constraint(equalToConstant: sizeWidth),
            hesKodu.heightAnchor.constraint(equalToConstant: size),
        ])
    }
    
    func configureButtons(){
        containerView.addSubview(cancelButton)
        containerView.addSubview(okButton)
        
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        okButton.translatesAutoresizingMaskIntoConstraints = false
        
        cancelButton.setTitle("İptal", for: .normal)
        cancelButton.backgroundColor = .systemPink
        cancelButton.setTitleColor(.white, for: .normal)
        cancelButton.layer.cornerRadius      = 10
        cancelButton.titleLabel?.font        = UIFont.preferredFont(forTextStyle: .headline)
        cancelButton.addTarget(self, action: #selector(cancelButtonClicked), for: .touchUpInside)
        
        okButton.setTitle("Kaydet", for: .normal)
        okButton.backgroundColor = .systemGreen
        okButton.setTitleColor(.white, for: .normal)
        okButton.layer.cornerRadius      = 10
        okButton.titleLabel?.font        = UIFont.preferredFont(forTextStyle: .headline)
        okButton.addTarget(self, action: #selector(okButtonClicked), for: .touchUpInside)
        
        let padding = CGFloat(10)
        let buttonWidth = (300-4*padding)/2
        
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: tc.bottomAnchor, constant: padding),
            cancelButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            cancelButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            cancelButton.heightAnchor.constraint(equalToConstant: 40),
            
            okButton.topAnchor.constraint(equalTo: tc.bottomAnchor, constant: padding),
            okButton.leadingAnchor.constraint(equalTo: cancelButton.trailingAnchor, constant: padding),
            okButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            okButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    @objc func cancelButtonClicked(){
        alertDelegate?.cancelButtonClicked()
        dismiss(animated: true, completion: nil)
    }
    
    @objc func okButtonClicked(){
        
        guard let name = name.text,
              let surname = surname.text,
              let tc = tc.text,
              let hes = hesKodu.text
        else { return }
        
        let yolcu = Yolcu(id: Int.random(in: 1000...9000), ad: name, soyad: surname, tc: tc, hes: hes)
        
        alertDelegate?.okButtonClicked(yolcu)
        dismiss(animated: true, completion: nil)
    }
}
