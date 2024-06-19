import React, { useState, useEffect} from 'react';
import {Flex, Text, Image, Input} from '@mantine/core';
import { QuestionProps } from "./types";
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';

function AnswerInput(props: {options?: string[], selected: string | number | string[] | null, setSelected: (value: string | number | string[] | null) => void, correct: string | string[] | number, type:string}) {
  
  const is_selected = (option: string) => {
    if (props.selected === null) {
      return false
    }
    if (Array.isArray(props.selected)) {
      return props.selected.includes(option)
    }
    return props.selected === option
  }

  return (
    <Flex
      direction='column'
      gap='xs'
      w='100%'
    >
      {props.options?.map((option, index) => (
        <Flex
          key={index}
          p='xs'
          bg='rgba(0,0,0,0.4)'
          style={{
            borderRadius:'var(--mantine-radius-sm)',
            cursor: 'pointer',
            border: is_selected(option) ? '1px solid var(--mantine-primary-color-9)' : 'none'
          }}
          onClick={() => {
            if (props.type === 'single') {
              props.setSelected(option)
            } else if (props.type === 'multiple') {
              if (props.selected === null) {
                props.setSelected([option.toString()])
              } else if (Array.isArray(props.selected)) {
                if (props.selected.includes(option.toString())) {
                  props.setSelected(props.selected.filter((value) => value !== option.toString()))
                } else {
                  props.setSelected([...props.selected, option.toString()])
                }
              } else {
                props.setSelected([props.selected.toString(), option.toString()])
              }
            } else {
              props.setSelected(option.toString())
            }

          }}
          align='center'
          gap='xs'

        >
          <FontAwesomeIcon icon={['fas', is_selected(option) ? 'check-circle' : 'circle']} style={{ color: 'white' }} />
          <Text>{option}</Text>
        </Flex>
      ))}

      {props.type == 'number' && 
        <Input type='number' onChange={(e) => props.setSelected(parseInt(e.currentTarget.value))}/>
      }

      {props.type == 'text' &&
        <Input type='text' onChange={(e) => props.setSelected(e.currentTarget.value)}/>
      }

    </Flex>
  )
}
// eslint-disable-next-line
function Question(props: {question: QuestionProps, answers: any, setAnswers: (value: any) => void, index: number}) {
  const [selected, setSelected] = useState<string | number | string[] | null>(null)

  useEffect(() => {

    // eslint-disable-next-line
    props.setAnswers((prev: any) => {
      return {
        ...prev,
        [props.index]: selected
      }
    })
  } , [selected, props])
  return (
    <Flex
      p='xs'
      w='90%'
      direction='column'
      mt='md'
      bg='rgba(0,0,0,0.4)'
      style={{
        borderRadius:'var(--mantine-radius-sm)',
      }}
    >
      <Flex
        gap='5px'
        align='center'
        p='1px'
        style={{
          borderBottom: '1px solid var(--mantine-primary-color-9)',
        }}
      >
        <FontAwesomeIcon icon={['fas', 'question-circle']} style={{ color: 'white' }} size='lg' />
        <Text>{props.question.question}</Text>
        {/* <Text style={{marginLeft: 'auto'}}>{props.type}</Text> */}
      </Flex>

      <Flex
        p='xs' 
        gap='xs'
        direction={'column'}
      >
        {props.question.extraInfo && <Text size='xs'>{props.question.extraInfo}</Text>}
        {props.question.image && <Image src={props.question.image} alt='Question Image' width={'100%'} height={'100%'} />}
      </Flex>
      
      <Flex p='xs'>
        <AnswerInput options={props.question.options} selected={selected} setSelected={setSelected} correct={props.question.correct} type={props.question.type}/>
      </Flex>
        
    </Flex>

  )
}

// eslint-disable-next-line
function Questions(props: {questions: QuestionProps[], answers: any, setAnswers: (value: any) => void}) {
  return (
    <Flex
      pb='20px'
      direction='column'
      align='center'
      mt='md'
      w='80%'
      flex={1}
      bg='rgba(0,0,0,0.4)'
      
      style={{
        borderRadius:'var(--mantine-radius-sm)',
        overflowY: 'auto'

      }}
    >
      {props.questions.map((question, index) => (
        <Question key={index} index={index} question={question} answers={props.answers} setAnswers={props.setAnswers}/>
      ))}
    </Flex>

  )
}

export default Questions;