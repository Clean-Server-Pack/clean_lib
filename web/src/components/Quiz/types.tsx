export type QuestionProps = {
  type: string,
  image?: string,
  extraInfo?: string,
  question: string,
  options?: string[],
  correct: string | string[] | number
}

export type QuizInfoProps = {
  title: string,

  icon: string,
  time: number,
  timeout: number,
  passMark: number,
  answerAll: boolean,
  questions: QuestionProps[]

}