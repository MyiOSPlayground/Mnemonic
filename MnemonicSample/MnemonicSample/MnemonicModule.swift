//
//  MnemonicModule.swift
//  MnemonicSample
//
//  Created by hanwe on 2022/03/29.
//

import Foundation
import CryptoSwift

// 메서드와 구현내용은 아래 링크에서 참조하였습니다.
// https://github.com/skywinder/web3swift
// 수익의 목적 없이 학습을 위해서 만들어진 프로젝트입니다.

// 1. 암호학적으로 랜덤한 128~256 bits의 시퀀스 S를 만든다.
// 2. S의 SHA-256 해시값 중에서 앞(왼쪽)에서 S의 길이 / 32비트만큼을 체크섬으로 만든다.
// 3. 2번에서 만든 체크섬을 S의 끝에 추가한다.
// 4. 3번에서 만든 시퀀스와 체크섬의 연결을 11 bits 단위로 자른다.
// 5. 각 각의 11비트를 2048(2^11)개의 미리 정의된 단어로 치환한다.
// 6. 단어 시퀀스로부터 순서를 유지하면서 니모닉 코드를 생성한다.[

enum BitOfEntropy: Int {
    case bits128 = 128
    case bits160 = 160
    case bits192 = 192
    case bits224 = 224
    case bits256 = 256
}

class MnemonicModule: NSObject {
    
    // MARK: private property
    
    // MARK: internal property
    
    // MARK: lifeCycle
    
    // MARK: private function
    
    // MARK: internal function
    
    func genMnemonics(_ bitsOfEntropy: BitOfEntropy) -> [String]? {
        guard let entropy = Data.randomBytes(length: bitsOfEntropy.rawValue/8) else { return nil }
        print("gen entropy: \(entropy.toHexString())")
        return genMnemonicsFromEntropy(entropy: entropy)
    }
    
    func genMnemonicsFromEntropy(entropy: Data) -> [String]? {
        let checksum = entropy.sha256()
        let checksumBits = entropy.count*8/32
        var fullEntropy = Data()
        fullEntropy.append(entropy)
        fullEntropy.append(checksum[0 ..< (checksumBits + 7)/8 ])
        
        var returnValue = [String]()
        for i in 0 ..< fullEntropy.count*8/11 {
            guard let bits = fullEntropy.bitsInRange(i*11, 11) else { return nil }
            let index = Int(bits)
            guard Words.englishWords.count > index else { return nil }
            let word = Words.englishWords[index]
            returnValue.append(word)
        }
        
        return returnValue
    }
    
    func mnemonicsToEntropy(_ mnemonics: [String]) -> Data? {
        guard mnemonics.count >= 12 && mnemonics.count.isMultiple(of: 3) && mnemonics.count <= 24 else { return nil }
        var bitString = ""
        for mnemonic in mnemonics {
            guard let idx = Words.englishWords.firstIndex(of: mnemonic) else { return nil }
            let idxAsInt = Words.englishWords.startIndex.distance(to: idx)
            let stringForm = String(UInt16(idxAsInt), radix: 2).leftPadding(toLength: 11, withPad: "0")
            bitString.append(stringForm)
        }
        
        let stringCount = bitString.count
        if !stringCount.isMultiple(of: 33) {
            return nil
        }
        let entropyBits = bitString[0 ..< (bitString.count - bitString.count/33)]
        let checksumBits = bitString[(bitString.count - bitString.count/33) ..< bitString.count]
        guard let entropy = entropyBits.interpretAsBinaryData() else {
            return nil
        }
        let checksum = String(entropy.sha256().bitsInRange(0, checksumBits.count)!, radix: 2).leftPadding(toLength: checksumBits.count, withPad: "0")
        if checksum != checksumBits {
            return nil
        }
        return entropy
    }
    
}
