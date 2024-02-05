//
//  SearchCityViewModel.swift
//  EmpikTestWeatherApp
//
//  Created by Serhii Semenov on 05.02.2024.
//

import Foundation
import RxSwift
import RxRelay

class SearchCityViewModel {
    var coordinator: Coordinator?
    @Injected var cityInfoUseCase: CityInfoAutocompleteUseCaseProtocol
    var disposeBag = DisposeBag()
    
    // MARK: Output
    var cities = BehaviorRelay<[CityInfo]>(value: [])
    
    // MARK: Actions
    var getCityInfoAutocomplete = BehaviorRelay<String>(value: "")
    var cancelTapped = BehaviorRelay<Void>(value: ())
    
    init() {
        getCityInfoAutocomplete
            .distinctUntilChanged()
            .bind { [weak self] word in
                if word.isEmpty { self?.cities.accept([]) }
                self?.getCityInfoAutocomplete(by: word)
            }
            .disposed(by: disposeBag)
        
        cancelTapped
            .bind { [weak self] _ in
                self?.getCityInfoAutocomplete.accept("")
                self?.cities.accept([])
            }
            .disposed(by: disposeBag)
    }
    
    // MARK: Private methods
    private func getCityInfoAutocomplete(by word: String) {
        print(word)
        cityInfoUseCase.getCityInfoAutocomplete(word: word)
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] result in
                if let resultCities = result.data {
                    self?.cities.accept(resultCities)
                }
            }
            .disposed(by: disposeBag)
    }
}
