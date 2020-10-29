
import UIKit
import AVFoundation

class QRSacnVC: UIViewController, AVCaptureMetadataOutputObjectsDelegate, UIGestureRecognizerDelegate {
    // MARK:- Properties
    lazy var bottomSafeMargin = (UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0) as CGFloat
    lazy var ratio = (view.frame.height / 812.0) < 1 ? 1:(view.frame.height / 812.0)
    private let viewModel = QRScanVM()
    
    //Timer
    private var timer: Timer?
    private var currentTimer = 30.0
    private lazy var counter = UIView()
    private lazy var processBar = ProgressBar()
    private let timerLable = UILabel()

    //Camera frame
//    private var hasScanned = false
    private let videoPreview = UIView()
    private var qrFrameColor = UIColor()
    private let noCameraPlaceholder = UIImageView()
    private lazy var frame = viewModel.frame(target: self)
    private lazy var noCameraView = viewModel.askCameraPermissionView(
                                    target: self,action: #selector(openSetting))
    
    //Debug TextLabel
    private let validationLabel = UILabel()
    private var hadScan = false

    enum error: Error {
        case noCameraAvaliable
        case videoInputInitFail
    }
    
    // MARK:- Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureUI()

        do {
            try scanQRCode()
        } catch {
            print("DEBUG:- fail to scan QR code")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        counter.isHidden = false
        processBar.isHidden = false
        timerLable.isHidden = false
        setTimer(every: 0.1)
        
        #if DEBUG
//        dismiss(animated: true) {
//            MainTabBar.shared.presentRecipeInfoViewVC()
//        }
        #endif
    }
    
    // MARK:- Configures
    private func configureView() {
        view.backgroundColor = .clear
        counter.isHidden = true
        processBar.isHidden = true
        timerLable.isHidden = true
        noCameraView.isHidden = true
        self.view.isUserInteractionEnabled = true
    }
    
    private func configureUI() {
        view.addSubview(counter)
        counter.layer.cornerRadius = 56 / 2
        counter.backgroundColor = .primeOrange
        counter.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
            make.height.width.equalTo(56)
        }
        
        counter.addSubview(processBar)
        processBar.snp.makeConstraints { make in
            make.width.height.equalTo(56)
            make.center.equalToSuperview()
        }
        
        counter.addSubview(timerLable)
        timerLable.text = "30"
        timerLable.textColor = .white
        timerLable.font = UIFont.boldSystemFont(ofSize: 18)
        timerLable.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        view.addSubview(frame)
        frame.layer.cornerRadius = 24
        frame.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.bottom.equalTo(counter.snp.top).offset(-16)
            make.right.equalToSuperview()
            make.height.equalTo(view.frame.width * 1.12)
        }
        
        frame.addSubview(videoPreview)
        videoPreview.isUserInteractionEnabled = true
        videoPreview.clipsToBounds = true
        videoPreview.layer.cornerRadius = 24

        videoPreview.frame = CGRect(x: 24, y: 50,
                             width: view.frame.width - 48,
                             height: view.frame.width - 48)
        
        view.addSubview(validationLabel)
        validationLabel.numberOfLines = 0
        validationLabel.text = "Scan QRcode at the restaurant\nAnd get a 50% off! 😆"
        validationLabel.textColor = .white
        validationLabel.textAlignment = .center
        validationLabel.font = UIFont.boldSystemFont(ofSize: 20)
        validationLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK:- Helpers
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects.count > 0  {
            let machineReadableCode = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
            if machineReadableCode.type == AVMetadataObject.ObjectType.qr {
                guard let qrCode = machineReadableCode.stringValue
                else { return }
                
//                guard let transformedObject = (videoPreview.layer.sublayers![0] as! AVCaptureVideoPreviewLayer).transformedMetadataObject(for: machineReadableCode) as? AVMetadataMachineReadableCodeObject
//                else { return }

                setupBoundingBox(color: .gray)
                hideBoundingBox(after: 0.25)
                setupBoundingBox(color: .primeOrange)
//                hasScanned = true
                //validationLabel.text = "Valid Code 😆"
                if !hadScan {
                    hadScan = true
                    dismiss(animated: true) {
                        MainTabBar.shared.presentRecipeInfoViewVC(code: String(qrCode))
                    }
                }
            }
        }
    }
    
    func scanQRCode() throws {
        let avCaptureSession = AVCaptureSession()
        
        guard let avCaptureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        else {
            displayAskCameraPermissionView()
            throw error.noCameraAvaliable
        }
        
        guard let avCaptureInput = try? AVCaptureDeviceInput(device: avCaptureDevice)
        else {
            displayAskCameraPermissionView()
            throw error.videoInputInitFail
        }
        
        if AVCaptureDevice.authorizationStatus(for: .video) !=  .authorized {

            AVCaptureDevice.requestAccess(for: .video, completionHandler: { [weak self] (granted: Bool) in
                guard let strongSelf = self else { return }
                if !granted {
                    DispatchQueue.main.async {
                        strongSelf.displayAskCameraPermissionView()
                    }
                }
            })
        } else {
            let avCaptureMetadataOutput = AVCaptureMetadataOutput()
            avCaptureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)

            avCaptureSession.addInput(avCaptureInput)
            avCaptureSession.addOutput(avCaptureMetadataOutput)

            avCaptureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]

            let avCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: avCaptureSession)
            avCaptureVideoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
            avCaptureVideoPreviewLayer.frame = videoPreview.bounds
            avCaptureVideoPreviewLayer.cornerRadius = 24
            videoPreview.layer.addSublayer(avCaptureVideoPreviewLayer)
            DispatchQueue.main.async {
                self.setupBoundingBox(color: .gray)
            }
            avCaptureSession.startRunning()
        }
    }
    
    private var resetTimer: Timer?
    fileprivate func hideBoundingBox(after: Double) {
        resetTimer?.invalidate()
        resetTimer = Timer.scheduledTimer(withTimeInterval: TimeInterval() + after,
                     repeats: false) { [weak self] timer in self?.resetViews() }
    }

    private func resetViews() {
        boundingBox.isHidden = true
    }
    
    private var boundingBox = CAShapeLayer()
    private func setupBoundingBox(color: UIColor) {
        boundingBox.frame = videoPreview.layer.bounds
        boundingBox.strokeColor = color.cgColor
        boundingBox.lineWidth = 4.0
        boundingBox.fillColor = UIColor.clear.cgColor
        
        videoPreview.layer.addSublayer(boundingBox)
    }
    
    fileprivate func updateBoundingBox(_ points: [CGPoint]) {
        guard let firstPoint = points.first
        else { return }
        
        let path = UIBezierPath()
        path.move(to: firstPoint)
        
        var newPoints = points
        newPoints.removeFirst()
        newPoints.append(firstPoint)
        
        newPoints.forEach { path.addLine(to: $0) }
        
        boundingBox.path = path.cgPath
        boundingBox.isHidden = false
    }
    
    private func displayAskCameraPermissionView() {
        noCameraView.isHidden = false
        videoPreview.addSubview(noCameraPlaceholder)
        noCameraPlaceholder.isUserInteractionEnabled = true
        noCameraPlaceholder.backgroundColor = .lightGray
        noCameraPlaceholder.layer.cornerRadius = 20
        noCameraPlaceholder.snp.makeConstraints { make in
            make.top.left.bottom.right.equalToSuperview()
        }
        
        noCameraPlaceholder.addSubview(noCameraView)
        noCameraView.snp.makeConstraints { make in
            make.top.left.bottom.right.equalToSuperview()
            
        }
    }
    
    public func setTimer(every second: Double) {
        timer = Timer.scheduledTimer(withTimeInterval: second, repeats: true) { [weak self]_ in
            guard let strongSelf = self else { return }
            if strongSelf.currentTimer >= 0 {
                strongSelf.timerLable.text = String(Int(strongSelf.currentTimer))
                strongSelf.currentTimer -= 0.1
                strongSelf.processBar.progress = min(0.03 * CGFloat(strongSelf.currentTimer), 1)
            } else {
                strongSelf.dismiss(animated: true, completion: nil)
            }
        }
        timer?.fire()
    }
    
    // MARK:- Selecotr
    @objc func presentAsk() {
        print("DEBUG:- presentAsk")
    }
    
    @objc func openSetting() {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString)
        else { return }

        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                print("Settings opened: \(success)")
            })
        }
    }
}
