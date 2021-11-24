//
//  Closures.swift
//  
//
//  Created by Yasin Nazlican on 18.11.2021.
//

import Foundation

public typealias ReturnClosure<T> = () -> T
public typealias ThrowableReturnClosure<T> = () throws -> T
public typealias ValueClosure<T> = ValueReturnClosure<T, Void>
public typealias ValueReturnClosure<T, R> = (_ value: T) -> R
public typealias ValueThrowableReturnClosure<T, R> = (_ value: T) throws -> R
public typealias VoidClosure = ReturnClosure<Void>
public typealias VoidThrowableClosure = ThrowableReturnClosure<Void>
