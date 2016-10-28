//
//  RecordSoundsViewController
//  PitchPerfect
//
//  Created by Baratta, Dominic on 10/26/16.
//  Copyright © 2016 Dominic Baratta. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    // MARK: UI Element Outlets
    
    @IBOutlet weak var tapToRecordLabel: UILabel!
    @IBOutlet weak var tapToRecordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    var audioRecorder: AVAudioRecorder!
    
    
    // Override the default will appear function to the set the enabled property of the
    // recording button to false. This could also be done via the story board however that
    // editor is confusing and has tons of options, code is a lot more to the point :)
    override func viewWillAppear(_ animated: Bool) {
        stopRecordingButton.isEnabled = false
    }
    
    // Function called just before the segue to the next storyboard. Use this function
    // to prepare and ship over the audio file.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "stopRecording") {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioUrl = sender as! NSURL
            playSoundsVC.recordedAudioURL = recordedAudioUrl as URL!
        }
    }
    
    // MARK: UI Interraction Handlers

    // Handle a user pressing the button to start a new recording
    @IBAction func recordButtonPress(_ sender: UIButton) {
        tapToRecordLabel.text = "Recording"
        tapToRecordButton.isEnabled = false
        stopRecordingButton.isEnabled = true
        
        // Setup the file path to store the audio file in
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURL(withPathComponents: pathArray)
        print(filePath)
        
        // Grab required audio hardware from the OS
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        // Create a recorder, setup delegation and start recording audio
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }

    // Handle a user pressing the button to stop recording audio
    @IBAction func stopRecordingButtonPress(_ sender: UIButton) {
        tapToRecordLabel.text = "Tap to Record"
        tapToRecordButton.isEnabled = true
        stopRecordingButton.isEnabled = false
        
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    // MARK: Callback's
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if (flag) {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else {
            let alertController = UIAlertController(title: "Error", message: "Recording Could Not Be Saved", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertController, animated: true)
        }
    }
    

    
}

