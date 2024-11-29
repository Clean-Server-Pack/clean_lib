import { createContext, useContext, useEffect, useState } from "react";
import { fetchNui } from "../../utils/fetchNui";
import { isEnvBrowser } from "../../utils/misc";

type localeType = (key: string, ...args: string[]) => string;

type LocalesProps = {
  [key: string]: string;
};

const LocalesContext = createContext<localeType>(() => '');

const LocalesProvider: React.FC<{ children: React.ReactNode }> = ({ children }) => {
  const [rawLocales, setRawLocales] = useState<LocalesProps>({
    'title': 'Title',
    'status_time_over': 'Time\'s up!',
    'theme_color': 'Theme Color is %s',
  });

  // Updated locale function to handle string interpolation
  const locale = (key: string, ...args: string[]): string => {
    let translation = rawLocales[key] || key;
    
    if (args.length) {
      translation = translation.replace(/%s/g, () => args.shift() || '');
    }
    
    return translation;
  };

  useEffect(() => {
    if (!isEnvBrowser()) {
      fetchNui('GET_LOCALES')
        .then((data) => {
          setRawLocales(data as LocalesProps);
        })
        .catch((error) => {
          console.error('Failed to fetch locales:', error);
        });
    }
  }, []);

  return (
    <LocalesContext.Provider value={locale}>
      {children}
    </LocalesContext.Provider>
  );
};

export { LocalesProvider };

const useLocale = (): localeType => {
  const context = useContext(LocalesContext);
  if (context === undefined) {
    throw new Error('useLocale must be used within a LocalesProvider');
  }
  return context;
};

export { useLocale };