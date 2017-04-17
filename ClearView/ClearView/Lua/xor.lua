torch.setdefaulttensortype('torch.FloatTensor')

function loadNeuralNetwork(path)
  print (path)
  model = torch.load(path)

  print ("Loaded Neural Network -- Success")
  print ("Model Architecture --\n")
  print (model)
  print ("---------------------\n")
end

function classifyExample(tensorInput)
  v = model(tensorInput)
  print(v[1])
  return v[1]
end
