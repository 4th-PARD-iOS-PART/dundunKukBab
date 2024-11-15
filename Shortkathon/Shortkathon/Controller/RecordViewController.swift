import UIKit
import AVFoundation

class RecordViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var audioRecorder: AVAudioRecorder?
    var isRecording = false
    var recordings: [URL] = []

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
        button.isEnabled = false
        return button
    }()

    let uploadButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Upload File", for: .normal)
        button.addTarget(self, action: #selector(uploadRecordingAsMultipart), for: .touchUpInside)
        button.isEnabled = false // 초기 비활성화
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
        loadRecordings()

        // Upload 버튼 추가
        uploadButton.frame = CGRect(x: 100, y: 350, width: 200, height: 50)
        view.addSubview(uploadButton)
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

    @objc func toggleRecording() {
        if isRecording {
            audioRecorder?.stop()
            isRecording = false
            recordButton.setTitle("Start Recording", for: .normal)
            playButton.isEnabled = true

            if let fileURL = audioRecorder?.url {
                recordings.append(fileURL)
                tableView.reloadData()
                print("Recording saved at: \(fileURL)")
            }
        } else {
            let session = AVAudioSession.sharedInstance()
            try? session.setCategory(.playAndRecord, mode: .default, options: [])
            try? session.setActive(true)

            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            let fileName = "recording_\(Date().timeIntervalSince1970).m4a"
            let audioURL = paths[0].appendingPathComponent(fileName)

            let settings: [String: Any] = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 44100,
                AVNumberOfChannelsKey: 1,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]

            audioRecorder = try? AVAudioRecorder(url: audioURL, settings: settings)
            audioRecorder?.prepareToRecord()
            audioRecorder?.record()
            isRecording = true
            recordButton.setTitle("Stop Recording", for: .normal)
            playButton.isEnabled = false
        }
    }

    @objc func playRecording() {
        guard let lastRecording = recordings.last else { return }
        try? AVAudioPlayer(contentsOf: lastRecording).play()
    }

    @objc func uploadRecordingAsMultipart() {
        // 파일 URL 설정
        guard let fileURL = recordings.last else {
            print("No file selected for upload.")
            return
        }

        // 파일 이름에서 확장자 제거 후 title 생성
        let title = fileURL.deletingPathExtension().lastPathComponent
        print(title)
        // 서버 URL 설정
        guard let serverURL = URL(string: "http://172.17.208.113:8081/post/create") else {
            print("Invalid server URL")
            return
        }

        // URLRequest 설정
        var request = URLRequest(url: serverURL)
        request.httpMethod = "POST"

        // Boundary 설정
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        // Body 데이터 구성
        var body = Data()

        // Title 데이터 추가
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"title\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(title)\r\n".data(using: .utf8)!)
        print(title)
        // 파일 데이터 추가
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"file\"; filename=\"\(fileURL.lastPathComponent)\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: audio/m4a\r\n\r\n".data(using: .utf8)!)
        do {
            let fileData = try Data(contentsOf: fileURL)
            body.append(fileData)
        } catch {
            print("Failed to read file data: \(error)")
            return
        }
        body.append("\r\n".data(using: .utf8)!)

        // Boundary 종료
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)

        // 요청 Body 설정
        request.httpBody = body

        // URLSession으로 업로드 요청
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Upload failed: \(error.localizedDescription)")
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    print("Upload successful!")
                } else {
                    print("Upload failed with status code: \(httpResponse.statusCode)")
                    if let data = data, let responseString = String(data: data, encoding: .utf8) {
                        print("Server response: \(responseString)")
                    }
                }
            }
        }
        task.resume()
    }


    func loadRecordings() {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let files = (try? FileManager.default.contentsOfDirectory(at: paths[0], includingPropertiesForKeys: nil)) ?? []
        recordings = files.filter { $0.pathExtension == "m4a" }
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recordings.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let fileURL = recordings[indexPath.row]
        cell.textLabel?.text = fileURL.lastPathComponent
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedFile = recordings[indexPath.row]
        print("Selected file: \(selectedFile.lastPathComponent)")
        
        uploadButton.isEnabled = true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let fileURL = recordings[indexPath.row]
            do {
                try FileManager.default.removeItem(at: fileURL)
                print("File deleted: \(fileURL)")
                recordings.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            } catch {
                print("Failed to delete file: \(error)")
            }
        }
    }
}

