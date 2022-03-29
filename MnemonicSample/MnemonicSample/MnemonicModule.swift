//
//  MnemonicModule.swift
//  MnemonicSample
//
//  Created by hanwe on 2022/03/29.
//

import Foundation
import CryptoSwift

// 1. 암호학적으로 랜덤한 128~256 bits의 시퀀스 S를 만든다.
// 2. S의 SHA-256 해시값 중에서 앞(왼쪽)에서 S의 길이 / 32비트만큼을 체크섬으로 만든다.
// 3. 2번에서 만든 체크섬을 S의 끝에 추가한다.
// 4. 3번에서 만든 시퀀스와 체크섬의 연결을 11 bits 단위로 자른다.
// 5. 각 각의 11비트를 2048(2^11)개의 미리 정의된 단어로 치환한다.
// 6. 단어 시퀀스로부터 순서를 유지하면서 니모닉 코드를 생성한다.[

class MnemonicModule: NSObject {
    
    // MARK: private property
    
    // MARK: internal property
    
    // MARK: lifeCycle
    
    // MARK: private function
    
    // MARK: internal function
    
    func makeRandom() -> Data {
//        guard bitsOfEntropy >= 128 && bitsOfEntropy <= 256 && bitsOfEntropy.isMultiple(of: 32) else {return nil}
//        Data().is
    }
    
}
