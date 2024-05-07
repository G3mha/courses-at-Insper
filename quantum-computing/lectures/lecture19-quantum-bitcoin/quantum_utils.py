from qiskit import QuantumCircuit,execute
from qiskit_aer import Aer

import hashlib
import random
import string

def quantum_operation():
    circuit = QuantumCircuit(2)
    circuit.h(0)
    circuit.cx(0, 1)
    circuit.measure_all()
    simulator = Aer.get_backend('qasm_simulator')
    result = execute(circuit, simulator, shots=1).result()
    counts = result.get_counts(circuit)
    return list(counts.keys())[0]

def random_string(length):
    letters_and_digits = string.ascii_letters + string.digits
    return ''.join(random.choice(letters_and_digits) for i in range(length))

def generate_quantum_bitcoin_address():
    quantum_bits = quantum_operation()
    prefix = random.choice(['1', '3', 'bc1'])
    rest_length = random.randint(25, 34 - len(prefix))
    rest_of_address = random_string(rest_length)
    address = prefix + rest_of_address
    return address

