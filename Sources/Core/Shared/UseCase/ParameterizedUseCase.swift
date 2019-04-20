//
//  ParameterizedUseCase.swift
//  LivestreamFailsUnofficial
//
//  Created by Marcelo Vitoria on 19/04/19.
//  Copyright © 2019 Marcelo Vitoria. All rights reserved.
//

protocol ParameterizedUseCase {
    associatedtype Parameters

    func execute(with parameters: Parameters)
}
