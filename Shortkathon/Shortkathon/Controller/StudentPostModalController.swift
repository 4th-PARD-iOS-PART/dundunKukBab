import UIKit
import AVFoundation

class StudentPostModalController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var audioRecorder: AVAudioRecorder?
    var audioPlayer: AVAudioPlayer?
    var isRecording = false
    var recordings: [URL] = []
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.isScrollEnabled = false // 스크롤 비활성화
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.clear
        setUI()
    }
    
    let button1: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "Group 14"), for: .normal) // 이미지 설정
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        return button
    }()
    
    let button2: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "Group 15"), for: .normal) // 이미지 설정
        return button
    }()
    
    func setUI() {
        let contentView: UIView = {
            let contents = UIView()
            contents.translatesAutoresizingMaskIntoConstraints = false
            return contents
        }()
        
        let modal: UIView = {
            let modal = UIView()
            modal.translatesAutoresizingMaskIntoConstraints = false
            modal.backgroundColor = UIColor.white
            modal.layer.cornerRadius = 20
            modal.layer.masksToBounds = true
            return modal
        }()
        
        let titleTextField: UITextField = {
            let textField = UITextField()
            textField.translatesAutoresizingMaskIntoConstraints = false
            textField.placeholder = "제목쓰기"
            textField.font = UIFont.boldSystemFont(ofSize: 24)
            textField.textAlignment = .left
            textField.borderStyle = .roundedRect
            return textField
        }()
        
        let button: UIButton = {
            let button = UIButton()
            button.setTitle("녹음하기", for: .normal)
            button.backgroundColor = UIColor(red: 255/255.0, green: 131/255.0, blue: 15/255.0, alpha: 1.0)
            button.setTitleColor(.white, for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
            button.layer.cornerRadius = 30.0
            button.addTarget(self, action: #selector(buttonClicked1), for: .touchUpInside)
            return button
        }()
        
        let label1: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "음성메시지"
            label.font = UIFont(name: "Pretendard-Regular", size: 17)
            label.textColor = .black
            label.textAlignment = .center
            return label
        }()
        
        view.addSubview(contentView)
        contentView.addSubview(modal)
        modal.addSubview(titleTextField)
        modal.addSubview(button)
        modal.addSubview(label1)
        modal.addSubview(tableView)
        modal.addSubview(button1)
        modal.addSubview(button2)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            modal.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            modal.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            modal.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            modal.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1),
            
            titleTextField.topAnchor.constraint(equalTo: modal.topAnchor, constant: 20),
            titleTextField.leadingAnchor.constraint(equalTo: modal.leadingAnchor, constant: 20),
            titleTextField.trailingAnchor.constraint(equalTo: modal.trailingAnchor, constant: -20),
            titleTextField.heightAnchor.constraint(equalToConstant: 40),
            
            button.leadingAnchor.constraint(equalTo: modal.leadingAnchor, constant: 108),
            button.trailingAnchor.constraint(equalTo: modal.trailingAnchor, constant: -94),
            button.bottomAnchor.constraint(equalTo: modal.bottomAnchor, constant: -43),
            button.heightAnchor.constraint(equalToConstant: 56),
            
            label1.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 22),
            label1.leadingAnchor.constraint(equalTo: titleTextField.leadingAnchor),
            
            button1.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -46),
            button1.leadingAnchor.constraint(equalTo: modal.leadingAnchor, constant: 208),
            button1.heightAnchor.constraint(equalToConstant: 46),
            button1.widthAnchor.constraint(equalToConstant: 46),
            
            button2.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -46),
            button2.leadingAnchor.constraint(equalTo: button1.trailingAnchor, constant: 13),
            button2.heightAnchor.constraint(equalToConstant: 46),
            button2.widthAnchor.constraint(equalToConstant: 46),
            
            tableView.topAnchor.constraint(equalTo: label1.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: modal.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: modal.trailingAnchor, constant: -20),
            tableView.heightAnchor.constraint(equalToConstant: 50) // 한 개의 셀 높이
        ])
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    
    @objc func buttonClicked() {
        print("녹음하기")
        if isRecording {
            audioRecorder?.stop()
            isRecording = false
            
            if let fileURL = audioRecorder?.url {
                recordings.insert(fileURL, at: 0) // 최신 파일을 맨 앞에 추가
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
        }
    }
    
    @objc func buttonClicked1(){
        
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
        showAlert(title: "녹음 완료", message: "녹음이 성공적으로 저장되었습니다.")
    }
    
    
    func playRecording() {
        guard let lastRecording = recordings.first else { return }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: lastRecording)
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
            print("Playing: \(lastRecording.lastPathComponent)")
        } catch {
            print("Failed to play audio: \(error)")
        }
    }
    
    // MARK: - UITableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return min(recordings.count, 1) // 1개의 셀만 표시
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if recordings.indices.contains(indexPath.row) {
            let fileURL = recordings[indexPath.row]
            cell.textLabel?.text = fileURL.deletingPathExtension().lastPathComponent
            cell.textLabel?.font = UIFont.systemFont(ofSize: 16)
            cell.textLabel?.textColor = .black
            cell.backgroundColor = .white
        }
        return cell
    }
    
    // MARK: - UITableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        playRecording()
        let cell = tableView.cellForRow(at: indexPath)
        cell?.backgroundColor = .white
        
    }
}
