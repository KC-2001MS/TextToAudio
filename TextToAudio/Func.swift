//
//  Func.swift
//  TextToAudio
//
//  Created by 茅根 啓介 on 2022/10/20.
//

import Foundation
import Speech

let synthesizer = AVSpeechSynthesizer()

func exportAudio(_ text: String,_ voiceIdentifier: String,_ language: String,_ speed: Float,_ volume: Float,_ pitch: Float,_ url: URL) {
    let utterance = AVSpeechUtterance(string: text)
    utterance.voice = voiceIdentifier != "" ? AVSpeechSynthesisVoice(identifier: voiceIdentifier): AVSpeechSynthesisVoice(language: language)
    utterance.rate = speed
    utterance.volume = volume
    utterance.pitchMultiplier = pitch
    var output: AVAudioFile?
    print("test")
    synthesizer.write(utterance) { (buffer: AVAudioBuffer) in
        print("closure called")
        guard let pcmBuffer = buffer as? AVAudioPCMBuffer else {
            fatalError("unknown buffer type: \(buffer)")
        }
        if pcmBuffer.frameLength == 0 {
            // done
        } else {
            // append buffer to file
            if output == nil {
                let bufferSettings = utterance.voice?.audioFileSettings
                output = try? AVAudioFile(
                    forWriting: url,
                    settings: bufferSettings!)
            }
            try! output?.write(from: pcmBuffer)
        }
        print("end")
    }
}

extension UTType {
    //書き出すオーディオファイル
    static var caf: UTType {
        UTType(exportedAs: "com.typex.audio")
    }
}
