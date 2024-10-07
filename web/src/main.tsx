import '@mantine/carousel/styles.css';
import '@mantine/core/styles.css';
import React from 'react';
import ReactDOM from 'react-dom/client';
import App from './components/App';
import './index.css';
import './niceFont.css';
import './scrollBar.css';

import { library } from "@fortawesome/fontawesome-svg-core";
import { fab } from "@fortawesome/free-brands-svg-icons";
import { far } from "@fortawesome/free-regular-svg-icons";
import { fas } from "@fortawesome/free-solid-svg-icons";
import { SettingsProvider } from './providers/settings/settings';
import { AudioPlayerProvider } from './providers/audio/audio';
library.add(fas, far, fab);

ReactDOM.createRoot(document.getElementById('root')!).render(
  <React.StrictMode>
    <SettingsProvider>
      <AudioPlayerProvider>
        <App />
      </AudioPlayerProvider>
    </SettingsProvider>
  </React.StrictMode>,
);




