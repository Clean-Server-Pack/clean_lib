import React, { createContext, useContext, useRef, ReactNode } from 'react';
import ClickSound from './click_sound.mp3'
import HoverSound from './hover_sound.mp3'

type AudioPlayerContextType = {
  play: (sound: string) => void;
  stop: (sound: string) => void;
};

type AudioPlayerProviderProps = {
  children: ReactNode;
};

const AudioPlayerContext = createContext<AudioPlayerContextType>({
  play: () => {},
  stop: () => {},
});

export const AudioPlayerProvider: React.FC<AudioPlayerProviderProps> = ({ children }) => {
  const audioRefs = useRef<{ [key: string]: HTMLAudioElement }>({});

  // Predefined sounds
  const sounds: { [key: string]: string } = {
    click: ClickSound,
    hover: HoverSound,
  };

  // Initialize audio elements for each sound
  Object.keys(sounds).forEach((sound) => {
    if (!audioRefs.current[sound]) {
      audioRefs.current[sound] = new Audio(sounds[sound]);
    }
  });

  const play = (sound: string) => {
    if (audioRefs.current[sound]) {
      audioRefs.current[sound].currentTime = 0; // Reset to start
      audioRefs.current[sound].volume = 0.1;
      audioRefs.current[sound].play();
    } else {
      console.warn(`Sound '${sound}' not found.`);
    }
  };

  const stop = (sound: string) => {
    if (audioRefs.current[sound]) {
      audioRefs.current[sound].pause();
      audioRefs.current[sound].currentTime = 0; // Reset to start
    } else {
      console.warn(`Sound '${sound}' not found.`);
    }
  };

  return (
    <AudioPlayerContext.Provider value={{ play, stop }}>
      {children}
    </AudioPlayerContext.Provider>
  );
};

export const useAudioPlayer = (): AudioPlayerContextType => {
  const context = useContext(AudioPlayerContext);
  if (!context) {
    throw new Error('useAudioPlayer must be used within an AudioPlayerProvider');
  }
  return context;
};
