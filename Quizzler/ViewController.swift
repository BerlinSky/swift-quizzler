//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Place your instance variables here
    let allQuestions = QuestionBank()
    var pickedAnswer : Bool = false
    var totalNumberOfQuestions : Int = 0
    var questionNumber : Int = 0
    var score : Int = 0
    

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        totalNumberOfQuestions = allQuestions.list.count
        startOver()
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        if sender.tag == 1 {
            pickedAnswer = true
            score = score + 1
        }
        else if sender.tag == 2 {
            pickedAnswer = false
        }
        
        checkAnswer()
        
        nextQuestion()
    }
    
    
    func updateUI() {
      
        questionLabel.text = allQuestions.list[questionNumber].questionText
        scoreLabel.text = "Score: \(score)"
        progressLabel.text = "\(questionNumber) / \(allQuestions.list.count)"
  
        progressBar.frame.size.width = (view.frame.size.width / CGFloat(totalNumberOfQuestions)) * CGFloat(questionNumber)
    }
    

    func nextQuestion() {
        
        if questionNumber < (totalNumberOfQuestions - 1) {
            questionNumber = questionNumber + 1
        }
        else {
            let alert = UIAlertController(title: "Awesome", message: "You've finished all the questions, do you want to start over?", preferredStyle: .alert)
            
            let restartAction = UIAlertAction(title: "Restart", style: .default, handler:
                { (UIAction) in
                self.startOver()
            })
        
            alert.addAction(restartAction)
            
            present(alert, animated: true, completion: nil)
        }
        
//        questionLabel.text = allQuestions.list[questionNumber].questionText
        updateUI()
    }
    
    
    func checkAnswer() {
        
        let corectAnswer = allQuestions.list[questionNumber].answer
        
        if corectAnswer == pickedAnswer {
            print("You got it right")
        }
        else {
            print("You got it wrong")
        }
    }
    
    
    func startOver() {
        
        questionNumber = 0
        score = 0
        
        updateUI()
    }
    
}
