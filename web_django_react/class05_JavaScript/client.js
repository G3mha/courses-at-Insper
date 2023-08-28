async function main() {
  const axios = require("axios");

  // make function async to request token
  async function getToken() {
    // Request to get access token for exercise auth
    var request = {
      method: 'POST',
      url: 'https://tecweb-js.insper-comp.com.br/token',
      data: {
        username: 'enriccog'
      },
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    };
    const response = await axios(request);
    return response.data.accessToken;
  }

  // make function async to request exercises
  async function getExercises(token) {
    // Request to get the exercises
    var request2 = {
      method: 'GET',
      url: 'https://tecweb-js.insper-comp.com.br/exercicio',
      data: {
        username: 'enriccog',
      },
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ' + token
      },
    };
    try {
      const response = await axios(request2);
      return response.data;
    } catch (error) {
      // console.error(error);
    }
  }

  // Send the solution for an exercise
  async function getResponse(token, SLUG, resposta) {
    var request3 = {
      method: 'POST',
      url: `https://tecweb-js.insper-comp.com.br/exercicio/${SLUG}`,
      data: {
        username: 'enriccog',
        'resposta': resposta
      },
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ' + token
      },
    };
    try {
      const response = await axios(request3);
      return response.data.sucesso;
    } catch (error) {
      // console.error(error);
    }
  }

  var token = await getToken();
  var exercises = await getExercises(token);
  var exercisesNames = Object.keys(exercises);
  
  // Solve exercise 'Soma valores'
  var SLUG = exercisesNames[0];
  var exercise = exercises[SLUG];
  var answer = exercise.entrada.a + exercise.entrada.b;
  var isCorrect = await getResponse(token, SLUG, answer);
  console.log(`O exercício ${exercise.titulo} está correto: ${isCorrect}`);
  
  // Solve exercise 'Tamanho da string'
  var SLUG = exercisesNames[1];
  var exercise = exercises[SLUG];
  var answer = exercise.entrada.string.length;
  var isCorrect = await getResponse(token, SLUG, answer);
  console.log(`O exercício ${exercise.titulo} está correto: ${isCorrect}`);
  
  // Solve exercise 'Nome do usuário'
  var SLUG = exercisesNames[2];
  var exercise = exercises[SLUG];
  var answer = '';
  for (var i = 0; i < exercise.entrada.email.length; i++) {
    var char = exercise.entrada.email.charAt(i);
    if (char == '@') {
      break;
    }
    answer = answer + char;
  }
  var isCorrect = await getResponse(token, SLUG, answer);
  console.log(`O exercício ${exercise.titulo} está correto: ${isCorrect}`);
  
  // Solve exercise 'Jaca Wars!'
  var SLUG = exercisesNames[3];
  var exercise = exercises[SLUG];
  var distance_reached = (exercise.entrada.v**2)*Math.sin(2*(exercise.entrada.theta*(Math.PI/180)))/9.8;
  if (distance_reached <= 102 && distance_reached >= 98) {
    var answer = 0;
  }
  if (distance_reached > 102) {
    var answer = 1;
  }
  if (distance_reached < 98) {
    var answer = -1;
  }
  var isCorrect = await getResponse(token, SLUG, answer);
  console.log(`O exercício ${exercise.titulo} está correto: ${isCorrect}`);
  
  // Solve exercise 'Ano bissexto'
  var SLUG = exercisesNames[4];
  var exercise = exercises[SLUG];
  var answer = false;
  if ((0 == exercise.entrada.ano % 4) && (0 != exercise.entrada.ano % 100) || (0 == exercise.entrada.ano % 400)) {
    answer = true;
  }
  var isCorrect = await getResponse(token, SLUG, answer);
  console.log(`O exercício ${exercise.titulo} está correto: ${isCorrect}`);
  
  // Solve exercise 'Volume da PIZZA!'
  var SLUG = exercisesNames[5];
  var exercise = exercises[SLUG];
  var answer = Math.round(Math.pow(exercise.entrada.z,2)*Math.PI*exercise.entrada.a);
  var isCorrect = await getResponse(token, SLUG, answer);
  console.log(`O exercício ${exercise.titulo} está correto: ${isCorrect}`);
  
  // Solve exercise 'Movimento retilíneo uniforme'
  var SLUG = exercisesNames[6];
  var exercise = exercises[SLUG];
  var answer = exercise.entrada.s0+(exercise.entrada.v*exercise.entrada.t);
  var isCorrect = await getResponse(token, SLUG, answer);
  console.log(`O exercício ${exercise.titulo} está correto: ${isCorrect}`);

  // Solve exercise 'Inverta a string'
  var SLUG = exercisesNames[7];
  var exercise = exercises[SLUG];
  var answer = exercise.entrada.string.split('').reverse().join('');
  var isCorrect = await getResponse(token, SLUG, answer);
  console.log(`O exercício ${exercise.titulo} está correto: ${isCorrect}`);
  
  // Solve exercise 'Soma os valores guardados no objeto'
  var SLUG = exercisesNames[8];
  var exercise = exercises[SLUG];
  var answer = 0;
  Object.entries(exercise.entrada.objeto).forEach(([key, value]) => {
    answer += parseInt(value);
  });
  var isCorrect = await getResponse(token, SLUG, answer);
  console.log(`O exercício ${exercise.titulo} está correto: ${isCorrect}`);
 
  // Solve exercise 'Encontra o n-ésimo número primo'
  var SLUG = exercisesNames[9];
  var exercise = exercises[SLUG];
  const isPrime = (number) => {
    for (let i = 2; i <= Math.sqrt(number); i++) {
      if (number % i === 0) {
        return false;
      }
    }
    return number > 1;
  }
  var counter = 1;
  for (var answer = 2; counter < exercise.entrada.n+1; answer++) {
    if (isPrime(answer)) {
      counter++;
    }
  }
  answer--;
  var isCorrect = await getResponse(token, SLUG, answer);
  console.log(`O exercício ${exercise.titulo} está correto: ${isCorrect}`);

  // Solve exercise 'Maior prefixo comum'
  var SLUG = exercisesNames[10];
  var exercise = exercises[SLUG];
  var answer = '';

  let words = exercise.entrada.strings.sort((a, b) => a.length - b.length);
  for (listIndex = 0; listIndex < words.length; listIndex++) {
    let word_current = words[listIndex];
    for (listIndexSubsequent = listIndex+1; listIndexSubsequent < words.length; listIndexSubsequent++) {
      let word_subsequent = words[listIndexSubsequent];
      let charIndex = 0;
      while (charIndex < word_current.length && charIndex < word_current.length && word_current[charIndex] == word_subsequent[charIndex]) {
        charIndex++;
      }
      if (charIndex > answer.length) {
        answer = word_current.substring(0, charIndex);
      }
    }
  }
  var isCorrect = await getResponse(token, SLUG, answer);
  console.log(`O exercício ${exercise.titulo} está correto: ${isCorrect}`);

  // Solve exercise 'Soma do segundo maior e menor números'
  var SLUG = exercisesNames[11];
  var exercise = exercises[SLUG];
  var numbers = exercise.entrada.numeros.sort((a, b) => a - b);
  var answer = numbers[1] + numbers[numbers.length-2];
  var isCorrect = await getResponse(token, SLUG, answer);
  console.log(`O exercício ${exercise.titulo} está correto: ${isCorrect}`);

  // Solve exercise 'Conta palíndromos'
  var SLUG = exercisesNames[12];
  var exercise = exercises[SLUG];
  var answer = 0;
  exercise.entrada.palavras.forEach((word) => {
    if (word == word.split('').reverse().join('')) {
      answer++;
    }
  });
  var isCorrect = await getResponse(token, SLUG, answer);
  console.log(`O exercício ${exercise.titulo} está correto: ${isCorrect}`);

  // Solve exercise 'Soma de strings de ints'
  var SLUG = exercisesNames[13];
  var exercise = exercises[SLUG];
  var answer = exercise.entrada.strings.map(x => parseInt(x)).reduce((a, b) => a + b);
  var isCorrect = await getResponse(token, SLUG, answer);
  console.log(`O exercício ${exercise.titulo} está correto: ${isCorrect}`);

  // Solve exercise 'Soma com requisições'
  var SLUG = exercisesNames[14];
  var exercise = exercises[SLUG];
  var answer = 0;
  for (var index = 0; index < exercise.entrada.endpoints.length; index++) {
    var request = {
      method: 'GET',
      url: exercise.entrada.endpoints[index],
      data: {
        username: 'enriccog'
      },
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ' + token
      },
    };
    const response = await axios(request);
    answer += response.data;
  }
  var isCorrect = await getResponse(token, SLUG, answer);
  console.log(`O exercício ${exercise.titulo} está correto: ${isCorrect}`);

  // Solve exercise 'Caça ao tesouro'
  var SLUG = exercisesNames[15];
  var exercise = exercises[SLUG];
  var answer = exercise.entrada.inicio;
  while (isNaN(answer)) {
    var request = {
      method: 'GET',
      url: answer,
      data: {
        username: 'enriccog'
      },
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ' + token
      },
    };
    const response = await axios(request);
    answer = response.data;
  }
  var isCorrect = await getResponse(token, SLUG, answer);
  console.log(`O exercício ${exercise.titulo} está correto: ${isCorrect}`);
}

main();
