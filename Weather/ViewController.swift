//
//  ViewController.swift
//  Weather
//
//  Created by Daniil on 27.10.2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var weatherLabel: UILabel! // Функция название
    @IBOutlet var getWeatherButton: UIButton!  // Функция кнопки
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        weatherLabel.text = "test"
        getWeatherButton.addTarget(self, action: #selector(didTapGetWeatherButton), for: .touchUpInside) // Отслеживает нажатие на кнопку
    }

    @objc func didTapGetWeatherButton() {
        let urlString = "https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&current_weather=true" // Ссылка на api
        let url = URL(string: urlString)! // преобразуем
        let request = URLRequest(url: url) // делаем запрос
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data, let weather = try? JSONDecoder().decode(WeatherData.self, from: data) { // Получаем ответ
                DispatchQueue.main.async {
                    self.weatherLabel.text = "Температура: \(weather.currentWeather.temperature) °" // Ввыводим текст отантп
                }

            } else {
                print("Falid")

            }
            
        }
        task.resume() // запускает
    }
}
