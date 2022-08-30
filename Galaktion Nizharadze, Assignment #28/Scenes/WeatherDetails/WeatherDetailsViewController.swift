//
//  WeatherDetailsViewController.swift
//  Galaktion Nizharadze, Assignment #28
//
//  Created by Gaga Nizharadze on 30.08.22.
//

import UIKit

class WeatherDetailsViewController: UIViewController {
    
    var data: WeatherOfCountry? {
        didSet {
            if let imageName = viewModel.changeIconIfNeeds(weatherState: data?.weather.first?.main.lowercased() ?? "clear") {
                weatherIndicatorIconImageView.image = UIImage(systemName: imageName)
            }
        }
    }
    
    private let viewModel = WeatherDetailsViewModel()
    
    private let weatherIndicatorIconImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.image = UIImage(systemName: "sun.dust.fill")
        
        return imgView
    }()
    
    private let iconAndCityNameStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        
        return stackView
    }()
    
    
    private let feelsLikeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        
        return stackView
    }()
    
    
    private let pressureStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        
        return stackView
    }()
    
    
    private let humadityStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        
        return stackView
    }()
    
    
    private let detailsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.distribution = .fillProportionally
        
        return stackView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        createLabels()
        configureWholeUI()
    }
    
    
    // ეს ფუნქცია ვიცი დიდია მაგრამ ცალცალკე კეთება არჩავთვალე საჭიროდ გამეკეთებინა სათითაოდ ლეიბლები და თუ არასწორია დამიწერეთ რეკომენდაციაში და ცალცაკლე გავაკეთებ აწი :დ
    
    private func createLabels() {
        let temperatureIndicatorLabel: UILabel = viewModel.generatePricesLabels(fontSize: 24, isBold: true, textColor: .black, text: "\(data?.main.tempInCelsius ?? "0")", textAlignment: .center)
        
        let cityName = "\(data?.sys.country ?? "") - \(data?.name ?? "")"
        let cityNameLabel: UILabel = viewModel.generatePricesLabels(fontSize: 15, isBold: false, textColor: .systemGray2, text: cityName, textAlignment: .center)
        
        let feelsLikeLabel: UILabel = viewModel.generatePricesLabels(fontSize: 16, isBold: false, textColor: .black, text: "Feels Like", textAlignment: .left)
        let descriptionLabel: UILabel = viewModel.generatePricesLabels(fontSize: 16, isBold: false, textColor: .black, text: "Description", textAlignment: .left)
        let windSpeedLabel: UILabel = viewModel.generatePricesLabels(fontSize: 19, isBold: true, textColor: .black, text: "Wind Speed", textAlignment: .left)
        
        if let data = data {
            let descriptionValueLabel = viewModel.generatePricesLabels(fontSize: 16, isBold: false, textColor: .black, text: "\(data.weather.first?.weatherDescription ?? "clear")", textAlignment: .right)
            let feelsLikeValueLabel = viewModel.generatePricesLabels(fontSize: 16, isBold: false, textColor: .black, text: "\(data.main.feelsLikeInCelsius)", textAlignment: .right)
            let windSpeedValueLabel = viewModel.generatePricesLabels(fontSize: 19, isBold: true, textColor: .black, text: "\(data.wind.speed) km/h", textAlignment: .right)
            
            iconAndCityNameStackView.addArrangedSubview(temperatureIndicatorLabel)
            iconAndCityNameStackView.addArrangedSubview(cityNameLabel)
            
            feelsLikeStackView.addArrangedSubview(feelsLikeLabel)
            feelsLikeStackView.addArrangedSubview(feelsLikeValueLabel)
      
            pressureStackView.addArrangedSubview(descriptionLabel)
            pressureStackView.addArrangedSubview(descriptionValueLabel)

            humadityStackView.addArrangedSubview(windSpeedLabel)
            humadityStackView.addArrangedSubview(windSpeedValueLabel)
        }
    }
    
    private func configureWholeUI() {
        configurMainLogo()
        configureIconAndCityNameStackView()
        configureDetailsStackView()
    }
    
  
    
    private func configurMainLogo() {
        view.addSubview(weatherIndicatorIconImageView)
        NSLayoutConstraint.activate([
            weatherIndicatorIconImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            weatherIndicatorIconImageView.widthAnchor.constraint(equalToConstant: 170),
            weatherIndicatorIconImageView.heightAnchor.constraint(equalToConstant: 152),
            weatherIndicatorIconImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func configureIconAndCityNameStackView() {
        view.addSubview(iconAndCityNameStackView)
        
        NSLayoutConstraint.activate([
            iconAndCityNameStackView.topAnchor.constraint(equalTo: weatherIndicatorIconImageView.bottomAnchor, constant: 30),
            iconAndCityNameStackView.widthAnchor.constraint(equalToConstant: 200),
            iconAndCityNameStackView.heightAnchor.constraint(equalToConstant: 60),
            iconAndCityNameStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    
    private func configureDetailsStackView() {
        detailsStackView.addArrangedSubview(feelsLikeStackView)
        detailsStackView.addArrangedSubview(pressureStackView)
        detailsStackView.addArrangedSubview(humadityStackView)
        view.addSubview(detailsStackView)
        
        NSLayoutConstraint.activate([
            detailsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            detailsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            detailsStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            detailsStackView.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
}
