import UIKit
import AVFoundation

class RecordViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var audioRecorder: AVAudioRecorder?
    var isRecording = false
    var audioEngine = AVAudioEngine() // 오디오 엔진 추가
    var audioPlayerNode = AVAudioPlayerNode() // 오디오 플레이어 노드 추가
    var audioFile: AVAudioFile? // 오디오 파일을 로드하는 변수
    
    var recordings: [URL] = [] // 녹음된 파일들의 URL 리스트
    
    let recordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Start Recording", for: .normal)
        button.addTarget(self, action: #selector(toggleRecording), for: .touchUpInside)
        return button
    }()
    
    let playButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Play Recording", for: .normal)
        button.addTarget(self, action: #selector(playRecording), for: .touchUpInside)
        button.isEnabled = false // 녹음 완료 전에는 비활성화
        return button
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUI()
        requestMicrophonePermission()
        loadRecordings() // 기존 저장된 파일 로드
    }
    
    func setUI() {
        recordButton.frame = CGRect(x: 100, y: 200, width: 200, height: 50)
        view.addSubview(recordButton)
        
        playButton.frame = CGRect(x: 100, y: 300, width: 200, height: 50)
        view.addSubview(playButton)
        
        tableView.frame = CGRect(x: 0, y: 400, width: view.bounds.width, height: view.bounds.height - 400)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
    
    func requestMicrophonePermission() {
        AVAudioSession.sharedInstance().requestRecordPermission { granted in
            if !granted {
                print("Microphone access denied")
            }
        }
    }
    
    func setupAudioRecorder() {
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(.playAndRecord, mode: .default, options: [])
            try session.setActive(true)
            
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            let fileName = "recording_\(Date().timeIntervalSince1970).m4a" // 파일 이름에 타임스탬프 추가
            let audioURL = paths[0].appendingPathComponent(fileName)
            
            let settings: [String: Any] = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 44100,
                AVNumberOfChannelsKey: 1,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
            
            audioRecorder = try AVAudioRecorder(url: audioURL, settings: settings)
            audioRecorder?.prepareToRecord()
        } catch {
            print("Failed to set up audio recorder: \(error)")
        }
    }
    
    @objc func toggleRecording() {
        if isRecording {
            audioRecorder?.stop()
            isRecording = false
            recordButton.setTitle("Start Recording", for: .normal)
            playButton.isEnabled = true
            
            // 녹음 파일 저장 후 목록 업데이트
            if let fileURL = audioRecorder?.url {
                recordings.append(fileURL)
                tableView.reloadData() // 테이블뷰 업데이트
                print("Recording saved at: \(fileURL)")
            }
        } else {
            setupAudioRecorder()
            audioRecorder?.record()
            isRecording = true
            recordButton.setTitle("Stop Recording", for: .normal)
            playButton.isEnabled = false
        }
    }
    
    @objc func playRecording() {
        guard let lastRecording = recordings.last else { return }
        playAmplifiedAudio(fileURL: lastRecording, amplificationFactor: 5.0) // 증폭 5배
    }
    
    func playAmplifiedAudio(fileURL: URL, amplificationFactor: Float) {
        do {
            // 오디오 파일 로드
            audioFile = try AVAudioFile(forReading: fileURL)
            
            // 오디오 엔진 초기화
            audioEngine = AVAudioEngine()
            audioPlayerNode = AVAudioPlayerNode()
            
            // 오디오 플레이어 노드 연결
            audioEngine.attach(audioPlayerNode)
            let mainMixer = audioEngine.mainMixerNode
            mainMixer.outputVolume = amplificationFactor // 증폭
            
            // 오디오 노드 연결
            audioEngine.connect(audioPlayerNode, to: mainMixer, format: audioFile?.processingFormat)
            
            // 엔진 준비 및 시작
            audioEngine.prepare()
            try audioEngine.start()
            
            // 오디오 파일 재생
            audioPlayerNode.scheduleFile(audioFile!, at: nil)
            audioPlayerNode.play()
            
            print("Playing amplified audio at volume factor: \(amplificationFactor)")
            
        } catch {
            print("Failed to play amplified audio: \(error)")
        }
    }
    
    func loadRecordings() {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileManager = FileManager.default
        do {
            let files = try fileManager.contentsOfDirectory(at: paths[0], includingPropertiesForKeys: nil)
            recordings = files.filter { $0.pathExtension == "m4a" } // 녹음 파일만 필터링
            tableView.reloadData()
        } catch {
            print("Failed to load recordings: \(error)")
        }
    }
    
    // MARK: - UITableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recordings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let fileURL = recordings[indexPath.row]
        cell.textLabel?.text = fileURL.lastPathComponent // 파일 이름 표시
        return cell
    }
    
    // MARK: - UITableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedFile = recordings[indexPath.row]
        playAmplifiedAudio(fileURL: selectedFile, amplificationFactor: 60.0) // 증폭 5배
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // 파일 삭제
            let fileURL = recordings[indexPath.row]
            do {
                try FileManager.default.removeItem(at: fileURL)
                print("File deleted: \(fileURL)")
                
                // 배열에서 항목 제거
                recordings.remove(at: indexPath.row)
                
                // 테이블 뷰 갱신
                tableView.deleteRows(at: [indexPath], with: .automatic)
            } catch {
                print("Failed to delete file: \(error)")
            }
        }
    }
}
