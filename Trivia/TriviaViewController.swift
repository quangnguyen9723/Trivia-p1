//
//  TriviaViewController.swift
//  Trivia
//
//  Created by Quang Nguyen on 10/11/23.
//

import UIKit

class TriviaViewController: UIViewController {
    
    @IBOutlet weak var questionContent: UILabel!
    @IBOutlet weak var currentQuestion: UILabel!
    
    @IBOutlet weak var answer1: UIButton!
    @IBOutlet weak var answer2: UIButton!
    @IBOutlet weak var answer3: UIButton!
    @IBOutlet weak var answer4: UIButton!
    
    private var questions = [TriviaGame]()
    private var currentQuestionIndex = 0
    private var score = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionContent.layer.cornerRadius = 10
        
        questions = createMockData()
        configure()
    }
    
    @IBAction func didTapButton(_ sender: UIButton) {
        score += sender.titleLabel?.text! == questions[self.currentQuestionIndex].finalAnswer ? 1 : 0
        let nextIndex = (currentQuestionIndex + 1)
        if (nextIndex == questions.count) {
            showResult()
        } else {
            currentQuestionIndex = nextIndex
            configure()
        }
    }
    
    private func showResult() {
        let alertController = UIAlertController(title: "Game Over!", message: "Final score: \(score)/\(questions.count)", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Restart", style: .cancel) { (action) in
            self.currentQuestionIndex = 0
            self.score = 0
            self.configure()
        }
        
        alertController.addAction(cancelAction)
        
        // Present the alert
        self.present(alertController, animated: true, completion: nil)
    }

    
    private func configure() {
        let trivia = questions[currentQuestionIndex]
        currentQuestion.text = "Question: \(currentQuestionIndex + 1)/\(questions.count)"
        
        questionContent.text = trivia.question
        answer1.setTitle(trivia.answer1, for: .normal)
        answer2.setTitle(trivia.answer2, for: .normal)
        answer3.setTitle(trivia.answer3, for: .normal)
        answer4.setTitle(trivia.answer4, for: .normal)
    }
    
    private func createMockData() -> [TriviaGame] {
        let mockData1 = TriviaGame(question: "Which planet is known as the Red Planet?",
                                   answer1: "Earth",
                                   answer2: "Venus",
                                   answer3: "Mars",
                                   answer4: "Jupiter",
                                   finalAnswer: "Mars")

        let mockData2 = TriviaGame(question: "Which animal is known as the 'King of the Jungle'?",
                                   answer1: "Lion",
                                   answer2: "Elephant",
                                   answer3: "Tiger",
                                   answer4: "Bear", 
                                   finalAnswer: "Lion")

        let mockData3 = TriviaGame(question: "What is the largest ocean on Earth?",
                                   answer1: "Atlantic Ocean",
                                   answer2: "Indian Ocean",
                                   answer3: "Arctic Ocean",
                                   answer4: "Pacific Ocean",
                                   finalAnswer: "Pacific Ocean")
        return [mockData1, mockData2, mockData3]
    }

}
