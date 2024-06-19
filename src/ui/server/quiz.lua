quiz = {}
quiz.__index = quiz


quiz.new = function(id, data)
  local self = setmetatable(data, quiz)
  self.id = id
  quiz[id] = self
  self:__init()
  return self
end

quiz.get = function(id)
  return quiz[id]
end

quiz.delete = function(id)
  quiz[id] = nil
end


function quiz:__init()
  assert(self.title, 'quiz must have a title')
  assert(self.time, 'quiz must have a time')
  assert(self.timeout, 'quiz must have a timeout')
  assert(self.passMark, 'quiz must have a passMark')
  assert(self.answerAll, 'quiz must have an answerAll')
  assert(self.questions, 'quiz must have questions')
  assert(type(self.questions) == 'table', 'questions must be a table')
  assert(#self.questions > 0, 'questions must have atleast one question')
  for number, data in pairs(self.questions) do 
    assert(data.type, string.format('question %s must have a type', number))
    assert(data.question, string.format('question %s must have a question', number))
    assert(data.correct, string.format('question %s must have a correct answer', number))

    if data.type == 'multiple' then 
      assert(type(data.correct) == 'table', string.format('question %s correct answer must be a table', number))
    end

    if data.type == 'text' then 
      assert(type(data.correct) == 'string', string.format('question %s correct answer must be a string', number))
    end

    if data.type == 'number' then 
      assert(type(data.correct) == 'number', string.format('question %s correct answer must be a number', number))
    end


  end

  if not self.last then 
    self.last = {}
  end
end

function quiz:parse_answers_for_client()
  local questions = {}
  for i,v in ipairs(self.questions) do 
    local question = {
      type = v.type,
      question = v.question,
      options = v.options,
      correct = self.secureMode and nil or v.correct
    }
    table.insert(questions, question)
  end
  return questions
end

function quiz:check_answer(question, answer)
  local correct = question.correct
  if question.type == 'single' then 
    return correct == answer
  end
  if question.type == 'multiple' then 
    for i,v in ipairs(answer) do 
      if not table.includes(correct, v) then 
        return false
      end
    end
    return true
  end
  if question.type == 'text' then 
    return correct == answer
  end
  if question.type == 'number' then 
    return correct == answer
  end
end

lib.callback.register('dirk_lib:quiz:check_answer', function(player_id, quiz_id, question_id, answer)
  local quiz = lib.getQuiz(quiz_id)
  if not quiz then return end
  local question = quiz.questions[question_id]
  if not question then return end
  return quiz:check_answer(question, answer)
end)

function quiz:check_answers(answers)
  local score = 0
  for i,v in ipairs(self.questions) do 
    if self:check_answer(v, answers[i]) then 
      score = score + 1
    end
  end
  return score
end

lib.callback.register('dirk_lib:quiz:check_answers', function(player_id, quiz_id, answers)
  local quiz = lib.getQuiz(quiz_id)
  if not quiz then return end
  return quiz:check_answers(answers)
end)

function quiz:can_start(player_id)
  if not self.canRetake then return true end
  local last = self.last[player_id]
  if not last then return true end
  return os.time() - last > self.timeout
end

function quiz:start(player_id)
  self.last[player_id] = os.time()

  return true, {
    title = self.title,
    icon = self.icon,
    time = self.time,
    answerAll = self.answerAll,
    passMark = self.passMark,
    questions = self:parse_answers_for_client()
  }
end

function quiz:save_result(player_id, status, score)
  -- Save the result to the database or wherever we wish
end

function quiz:submit(player_id, answers)
  local score = self:check_answers(answers)
  if score < self.passMark then 
    self:save_result(player_id, 'FAILED', score)
    return false, score
  end

  self:save_result(player_id, 'PASSED', score)
  
  return true, score
end 

lib.callback.register('dirk_lib:quiz:submit', function(player_id, quiz_id, answers)
  local quiz = lib.getQuiz(quiz_id)
  if not quiz then return end
  return quiz:submit(player_id, answers)
end)

lib.callback.register('dirk_lib:quiz:start', function(player_id, quiz_id)
  local quiz = lib.getQuiz(quiz_id)
  if not quiz then return false, 'quiz_not_found' end
  if not quiz:can_start(player_id) then return false, 'cant_start' end
  return quiz:start(player_id)
end)





lib.registerQuiz = function(id, data)
  quiz.new(id, data)
end

lib.getQuiz = function(id)
  return quiz.get(id)
end

lib.deleteQuiz = function(id)
  quiz.delete(id)
end




-- Useage 
-- lib.quiz.register('quiz1', {
--   title = 'Quiz 1',
--   time = 10,
--   timeout = 60,
--   passMark = 5,
--   answerAll = true,
--   questions = {
--     {
--       type = 'single',
--       question = 'What is 1 + 1',
--       options = {2, 3, 4, 5},
--       correct = 1
--     },
--     {
--       type = 'multiple',
--       question = 'What are the colors of the rainbow',
--       correct = {1, 2, 3, 4, 5, 6, 7}
--     },
--     {
--       type = 'text',
--       question = 'What is the capital of Nigeria',
--       correct = 'Abuja'
--     },
--     {
--       type = 'number',
--       question = 'What is the square root of 16',
--       correct = 4
--     }
--   }
-- })
