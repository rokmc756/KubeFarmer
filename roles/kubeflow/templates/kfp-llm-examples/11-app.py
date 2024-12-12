from flask import Flask, request, jsonify
from transformers import AutoModelForCausalLM, AutoTokenizer

app = Flask(__name__)

model_name = "gpt2"
model = AutoModelForCausalLM.from_pretrained(model_name)
tokenizer = AutoTokenizer.from_pretrained(model_name)

@app.route('/predict', methods=['POST'])

def predict():
    data = request.json
    inputs = tokenizer.encode(data['text'], return_tensors='pt')
    outputs = model.generate(inputs)
    response = tokenizer.decode(outputs[0], skip_special_tokens=True)
    return jsonify({'response': response})


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)

