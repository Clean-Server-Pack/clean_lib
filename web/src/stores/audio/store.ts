import { create } from 'zustand';
import ClickSound from './click_sound.mp3';
import HoverSound from './hover_sound.mp3';


// Define a type for the store state and actions
type AudioPlayerStore = {
  play: (sound: string) => void;
  stop: (sound: string) => void;
};

// Create the store using Zustand
export const useAudio = create<AudioPlayerStore>(() => {
  const audioRefs: { [key: string]: HTMLAudioElement } = {};

  // Predefined sounds
  const sounds: { [key: string]: string } = {
    click: ClickSound,
    hover: HoverSound,
  };
  // Initialize audio elements for each sound
  Object.keys(sounds).forEach((sound) => {
    audioRefs[sound] = new Audio(sounds[sound]);
  });

  return {
    play: (sound: string) => {
      const audio = audioRefs[sound];
      if (audio) {
        audio.currentTime = 0; // Reset to start
        audio.volume = 0.1;
        audio.play();
      } else {
        console.warn(`Sound '${sound}' not found.`);
      }
    },
    stop: (sound: string) => {
      const audio = audioRefs[sound];
      if (audio) {
        audio.pause();
        audio.currentTime = 0; // Reset to start
      } else {
        console.warn(`Sound '${sound}' not found.`);
      }
    },
  };
});
