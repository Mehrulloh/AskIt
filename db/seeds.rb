10.times do
  title = Faker::Hipster.sentence(word_count: 3)
  body = Faker::Lorem.paragraph(sentence_count: 5, supplemental: true, random_sentences_to_add: 4)
<<<<<<< HEAD
  Question.create body: body, title: title
=======
  Answer.create body:
>>>>>>> 8542b4c7444ab7b2836222c9ba49ed7c3b7895ed
end
