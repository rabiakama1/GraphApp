//
//  ViewController.swift
//  MyGraphApp
//
//  Created by RABİA KAMA on 13.05.2025.
//

import UIKit
import MyGraphFramework

class ViewController: UIViewController {
    private var graphFramework: MyGraphFramework?
    private var nodes: [Node] = []
    
    private let loadButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Load Graph", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let nodePicker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    private let typeTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter node type (e.g., 'wc')"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let findButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Find Closest Node", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(loadButton)
        view.addSubview(nodePicker)
        view.addSubview(typeTextField)
        view.addSubview(findButton)
        view.addSubview(resultLabel)
        
        NSLayoutConstraint.activate([
            loadButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            loadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            nodePicker.topAnchor.constraint(equalTo: loadButton.bottomAnchor, constant: 20),
            nodePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nodePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nodePicker.heightAnchor.constraint(equalToConstant: 150),
            
            typeTextField.topAnchor.constraint(equalTo: nodePicker.bottomAnchor, constant: 20),
            typeTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            typeTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            findButton.topAnchor.constraint(equalTo: typeTextField.bottomAnchor, constant: 20),
            findButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            resultLabel.topAnchor.constraint(equalTo: findButton.bottomAnchor, constant: 20),
            resultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            resultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        nodePicker.delegate = self
        nodePicker.dataSource = self
    }
    
    private func setupActions() {
        loadButton.addTarget(self, action: #selector(loadButtonTapped), for: .touchUpInside)
        findButton.addTarget(self, action: #selector(findButtonTapped), for: .touchUpInside)
    }
    
    @objc private func loadButtonTapped() {
        // Sample graph data
        let jsonString = """
        [
            {
                "id": "node1",
                "pointType": "point",
                "edges": [
                    {
                        "id": "node2",
                        "weight": 7.5
                    },
                    {
                        "id": "node3",
                        "weight": 12
                    }
                ]
            },
            {
                "id": "node2",
                "pointType": "wc",
                "edges": [
                    {
                        "id": "node1",
                        "weight": 7.5
                    }
                ]
            },
            {
                "id": "node3",
                "pointType": "point",
                "edges": [
                    {
                        "id": "node1",
                        "weight": 12
                    }
                ]
            }
        ]
        """
        
        do {
            graphFramework = try MyGraphFramework(jsonString: jsonString)
            let decoder = JSONDecoder()
            nodes = try decoder.decode([Node].self, from: jsonString.data(using: .utf8)!)
            nodePicker.reloadAllComponents()
            resultLabel.text = "Graph loaded successfully!"
        } catch {
            resultLabel.text = "Error loading graph: \(error.localizedDescription)"
        }
    }
    
    @objc private func findButtonTapped() {
        guard let framework = graphFramework,
              let selectedNode = nodes[safe: nodePicker.selectedRow(inComponent: 0)],
              let targetType = typeTextField.text,
              !targetType.isEmpty else {
            resultLabel.text = "Please select a node and enter a target type"
            return
        }
        
        if let result = framework.findClosestNode(ofType: targetType, fromNodeId: selectedNode.id) {
            resultLabel.text = "Closest \(targetType) node: \(result.node.id)\nDistance: \(result.distance)"
        } else {
            resultLabel.text = "No \(targetType) node found"
        }
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return nodes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return nodes[row].id
    }
}

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

