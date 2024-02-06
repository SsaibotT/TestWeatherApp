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
    @Injected var cityInfoUseCase: CityInfoAutocompleteUseCaseProtocol
    var coordinator: Coordinator?
    var disposeBag = DisposeBag()
    
    // MARK: Output
    var cities = BehaviorRelay<[CityInfo]>(value: [])
    
    // MARK: Actions
    var getCityInfoAutocomplete = BehaviorRelay<String>(value: "")
    var cancelTapped = BehaviorRelay<Void>(value: ())
    
    init() {
        configureBindings()
    }
    
    // MARK: Configuring
    private func configureBindings() {
        getCityInfoAutocomplete
            .debounce(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest { [weak self] word -> Observable<DataResult<[CityInfo]>> in
                guard let self = self else { return Observable.empty() }
                
                if word.isEmpty {
                    self.cities.accept([])
                } else {
                    let observable = self.getCityInfoAutocomplete(by: word)
                    return observable
                        .catch { Observable.just(DataResult(data: nil, failure: .error($0))) }
                }
                
                return Observable.empty()
            }
            .observe(on: MainScheduler.instance)
            .bind { result in
                if let resultCities = result.data {
                    self.cities.accept(resultCities)
                }
            }
            .disposed(by: disposeBag)
        
        cancelTapped
            .skip(1)
            .bind { [weak self] _ in
                self?.getCityInfoAutocomplete.accept("")
                self?.cities.accept([])
            }
            .disposed(by: disposeBag)
    }
    
    // MARK: Private methods
    private func getCityInfoAutocomplete(by word: String) -> Observable<DataResult<[CityInfo]>> {
        cityInfoUseCase.getCityInfoAutocomplete(word: word)
    }
}
