//
//  CurrencyConverterViewController.swift
//  CashFlow_Storyboard
//
//  Created by Otabek Tuychiev.
//

import UIKit

class CurrencyConverterViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceLabel_BV: UIView!
    @IBOutlet weak var title_Label: UILabel!
    
    
    @IBOutlet weak var mainView_BV: UIView!
    @IBOutlet weak var amount_TextField: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    
    
    @IBOutlet weak var backgroundView_1: UIView!
    @IBOutlet weak var backgroundView_2: UIView!
    
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    @IBOutlet weak var noInternetConnection: UILabel!
    
    var title9 = "title9".localized()
    var amount_placeholder = "amount_placeholder".localized()
    
    var currencyCode: [String] = []
    var values: [Double] = []
    var activeCurrency = 0.0

    

    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        self.hideKeyboardWhenTappedAround()
    }

    // MARK: - Actions
   
    @IBAction func backBtn_Action(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Methods
    
    private func initViews() {
        pickerView.isUserInteractionEnabled = false
        pickerView.delegate = self
        pickerView.dataSource = self
        fetchJSON()
        amount_TextField.addTarget(self, action: #selector(updateViews), for: .editingChanged)
        
        mainView_BV.applyShadow(cornerRadius: 18.0)
        priceLabel_BV.applyShadow(cornerRadius: 18.0)
        backgroundView_1.applyShadow(cornerRadius: 18.0, shadowOpacity: 0.1)
        backgroundView_2.applyShadow(cornerRadius: 18.0, shadowOpacity: 0.2)
        
        title_Label.text = title9
        amount_TextField.placeholder = amount_placeholder
    }
    
    @objc func updateViews(input: Double) {
        guard let amountText = amount_TextField.text, let theAmountText = Double(amountText) else { return }
        if amount_TextField.text != ""{
            let total = theAmountText * activeCurrency
            priceLabel.text = String(format: "%.2f", total)
        }
    }
    
    private func fetchJSON() {
        loadingView.startAnimating()
        noInternetConnection.isHidden = true
        
        guard let url = URL(string: "https://open.exchangerate-api.com/v6/latest") else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                // Hide the loading view
                self.loadingView.stopAnimating()
                self.loadingView.isHidden = true
                
                // Handle any errors
                if error != nil {
                    self.noInternetConnection.isHidden = false
                    self.pickerView.isUserInteractionEnabled = false
                    print("Error fetching data: \(error!.localizedDescription)")
                    return
                }
                
                // Safely unwrap the data
                guard let safeData = data else {
                    self.noInternetConnection.isHidden = false
                    self.noInternetConnection.text = "No Data 404"
                    print("No data found")
                    return
                }
                
                // Decode JSON data
                do {
                    let results = try JSONDecoder().decode(ExchangeRates.self, from: safeData)
                    self.currencyCode = Array(results.rates.keys)
                    self.values = Array(results.rates.values)
                    
                    // Reload the picker view with the new data
                    self.pickerView.reloadAllComponents()
                    
                    // Enable the picker view for interaction
                    self.pickerView.isUserInteractionEnabled = true
                    
                    // Optionally set a default selected currency
                    if !self.values.isEmpty {
                        self.activeCurrency = self.values[0]
                        self.updateViews(input: self.activeCurrency)
                    }
                    
                } catch {
                    print("Error decoding JSON: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
    
    //MARK: - Picker View...
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyCode.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyCode[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        activeCurrency = values[row]
        updateViews(input: activeCurrency)
    }
    
//End.
}
