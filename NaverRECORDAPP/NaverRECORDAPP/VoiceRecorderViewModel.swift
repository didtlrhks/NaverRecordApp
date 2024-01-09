//
//  VoiceRecorderViewModel.swift
//  NaverRECORDAPP
//
//  Created by 양시관 on 1/9/24.
//

import Foundation
import AVFoundation

class VoiceRecorderViewModel : NSObject, ObservableObject, AVAudioPlayerDelegate {
    @Published var isDisPlayRemoveVoiceRecorderAlert : Bool
    @Published var isDisPlayErrorAlert : Bool
    @Published var errorAlertMessage : String
    
    
    
    var audioRecorder : AVAudioRecorder?
    @Published var isRecording : Bool
    
    var audioPlayer : AVAudioPlayer?
    @Published var isPlaying : Bool
    @Published var isPaused : Bool
    @Published var playedTime : TimeInterval
    private var progressTimer : Timer?
    
    var recordedFiles : [URL]
    
    @Published var selectedRecoredFile: URL?
    
    init(isDisPlayRemoveVoiceRecorderAlert: Bool = false,
         isDisPlayErrorAlert: Bool  = false,
         errorAlertMessage: String = "",
         isRecording: Bool = false,
         audioPlayer: AVAudioPlayer? = nil,
         isPlaying: Bool = false,
         isPaused: Bool = false,
         playedTime: TimeInterval,
         recordedFiles: [URL],
         selectedRecoredFile: URL? = nil
    ) {
        self.isDisPlayRemoveVoiceRecorderAlert = isDisPlayRemoveVoiceRecorderAlert
        self.isDisPlayErrorAlert = isDisPlayErrorAlert
        self.errorAlertMessage = errorAlertMessage
        self.isRecording = isRecording
        self.audioPlayer = audioPlayer
        self.isPlaying = isPlaying
        self.isPaused = isPaused
        self.playedTime = playedTime
        self.recordedFiles = recordedFiles
        self.selectedRecoredFile = selectedRecoredFile
    }
}

extension VoiceRecorderViewModel {
    func voiceRecordCellTapped(_ recordedFile: URL) {
        if selectedRecoredFile != recordedFile {
            // 재생정지 메서드 호출
            selectedRecoredFile = recordedFile
        }
    }
    
    func removeBtnTapped() {
        //삭제 얼럿 노출 메서드
        setIsDisplayRemoveVoiceRecorderAlert(true)
    }
    
    func removeSelectedVoiceRecord() {
        
        guard let fileToRemove = selectedRecoredFile,
              let indexToRemove = recordedFiles.firstIndex(of: fileToRemove) else {
            displayAlert(message: "선택된 음성메모 파일을 찾을수 없습니다.")
            return
        }
        
        do {
            try FileManager.default.removeItem(at: fileToRemove)
            recordedFiles.remove(at: indexToRemove)
            selectedRecoredFile = nil
            displayAlert(message: "선택된 음성메모 파일을 성공적으로 삭제했습니다.")
            //재생정지 매서드
            //삭제성공 알럿
            
        }
        catch {
            //삭제 실패오류 얼럿
            displayAlert(message: "선택된 음성메모 파일 삭제 중 오류가 발생했습니다.ㄴ")
        }
    }
    private func setIsDisplayRemoveVoiceRecorderAlert(_ isDisplay : Bool) {
        isDisPlayRemoveVoiceRecorderAlert = isDisplay
    }
    private func setErrorAlertMessage(_ message: String) {
        errorAlertMessage = message
    }
    private func setIsDisplayErrorAlert(_ isDisplay : Bool) {
        isDisPlayErrorAlert = isDisplay
    }
    private func displayAlert(message : String ) {
        setErrorAlertMessage(message)
        setIsDisplayErrorAlert(true)
    }
}
